#!/bin/bash
set -e

usage() {
    echo "Usage: $0 [store_password]"
    exit 1
}

processCommandLine() {
    if [[ "$1" =~ (help|-h|--help) ]]; then
        usage
    fi

    # Set password if not passed
    if [ -z "$1" ]; then
        echo "No password passed. Generating a random one..."
        storePassword=$(cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 16)
    else
        storePassword=$1
    fi
}

# Check if key generation tools are available
checkTools() {
    echo "Checking if required tools exist"
    for tool in "keytool" "openssl"; do
        echo "${tool}"
        hash ${tool} 2>/dev/null
    done
}

# Create the file system structure
createCertsDir() {
    tmpDir=./certs
    jfmcSecurity=${tmpDir}/mission-control/etc/security
    insightSecurity=${tmpDir}/insight-server/etc/security
    echo "Generating certs in ${tmpDir}"
    if [ -d ${tmpDir} ]; then
        echo "Found existing ${tmpDir}. Backing it up to ${tmpDir}-${timeStamp}..."
        mv ${tmpDir} ${tmpDir}-${timeStamp}
    fi

    mkdir -pv ${jfmcSecurity} ${insightSecurity}
}

genJfmcKeyStore() {
    keytool -genkeypair -alias secure-jfmc -keyalg RSA \
          -dname "CN=*,OU=JFMC,O=JFrog,L=Toulouse,S=France,C=fr" \
          -keystore ${tmpDir}/jfmc-keystore.jks \
          -storepass ${storePassword} \
          -keypass ${storePassword}

    keytool -exportcert -alias secure-jfmc \
          -file ${tmpDir}/jfmc-public.cer \
          -keystore ${tmpDir}/jfmc-keystore.jks \
          -storepass ${storePassword}

    keytool -importkeystore \
          -srcalias secure-jfmc \
          -srckeystore ${tmpDir}/jfmc-keystore.jks \
          -destkeystore ${tmpDir}/jfmc-keystore.p12 \
          -deststoretype PKCS12 \
          -srckeypass ${storePassword} \
          -srcstorepass ${storePassword} \
          -deststorepass ${storePassword}

    openssl pkcs12 -in ${tmpDir}/jfmc-keystore.p12 \
                 -nokeys \
                 -nodes \
                 -out ${tmpDir}/jfmc.crt \
                 -password pass:${storePassword} \
                 -passin pass:${storePassword}
}

genInsightKeyStore() {
    keytool -genkeypair -alias secure-insight -keyalg RSA \
          -dname "CN=*,OU=Insight,O=JFrog,L=Bengaluru,S=Kan,C=in" \
          -keystore ${tmpDir}/insight-keystore.jks \
          -storepass ${storePassword} \
          -keypass ${storePassword}

    keytool -exportcert -alias secure-insight \
          -file ${tmpDir}/insight-public.cer \
          -keystore ${tmpDir}/insight-keystore.jks \
          -storepass ${storePassword}

    keytool -importkeystore \
          -srcalias secure-insight \
          -srckeystore ${tmpDir}/insight-keystore.jks \
          -destkeystore ${tmpDir}/insight-keystore.p12 \
          -deststoretype PKCS12 \
          -noprompt \
          -srckeypass ${storePassword} \
          -srcstorepass ${storePassword} \
          -deststorepass ${storePassword}


    openssl pkcs12 -in ${tmpDir}/insight-keystore.p12 \
                 -nocerts \
                 -nodes \
                 -out ${tmpDir}/insight.key \
                 -password pass:${storePassword} \
                 -passin pass:${storePassword}
    openssl pkcs12 -in ${tmpDir}/insight-keystore.p12 \
                 -nokeys \
                 -nodes \
                 -out ${tmpDir}/insight.crt \
                 -password pass:${storePassword} \
                 -passin pass:${storePassword}
}

importInTrustStore() {
    keytool -importcert -keystore ${tmpDir}/jfmc-truststore.jks \
          -alias insightcert \
          -noprompt \
          -file ${tmpDir}/insight-public.cer \
          -storepass ${storePassword}

    keytool -importcert -keystore ${tmpDir}/insight-truststore.jks \
          -alias jfmccert \
          -noprompt \
          -file ${tmpDir}/jfmc-public.cer \
          -storepass ${storePassword}
}

# Put the generated files in their intended structure
arrangeFiles() {
    echo "Moving certs to their final location"
    mv -f ${tmpDir}/jfmc-truststore.jks ${jfmcSecurity}
    mv -f ${tmpDir}/jfmc-keystore.jks ${jfmcSecurity}
    mv -f ${tmpDir}/jfmc.crt ${insightSecurity}
    mv -f ${tmpDir}/insight-truststore.jks ${insightSecurity}
    mv -f ${tmpDir}/insight-keystore.jks ${insightSecurity}
    mv -f ${tmpDir}/insight.key ${insightSecurity}
    mv -f ${tmpDir}/insight.crt ${insightSecurity}
    cat ${jfmcSecurity}/jfmc-truststore.jks | base64 > ${jfmcSecurity}/jfmc-truststore.jks-b64
    cat ${jfmcSecurity}/jfmc-keystore.jks | base64 > ${jfmcSecurity}/jfmc-keystore.jks-b64
}

summary() {
    echo -e "\nAll keys and certificates are ready!"
    echo -e "\n- Mission Control files"
    find ${jfmcSecurity} -type f
    echo -e "\n- Insight Server files"
    find ${insightSecurity} -type f
}

############ Main ############

echo -e "\nCreating keys and certificates for JFrog Mission Control"
echo "========================================================"

timeStamp=$(date +%Y%m%d-%H%M%S)

processCommandLine $*
checkTools
createCertsDir
genInsightKeyStore
genJfmcKeyStore
importInTrustStore
arrangeFiles
summary
echo -e "========================================================\n"
