#!/bin/bash

set -xe

sleep 300

until $(curl --output /dev/null --silent --head --fail {{ .Values.conf.location_config.jenkinsUrl }} ); do
    printf '.'
    sleep 5
done

cd ~
curl {{ .Values.conf.location_config.jenkinsUrl }} -o cli.jar
java -jar cli.jar -s {{ .Values.conf.location_config.jenkinsUrl }} -webSocket help