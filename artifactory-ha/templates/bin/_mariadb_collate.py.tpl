{{/*
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}

{{- define "artifactory.mariadb_collate" }}
#!/usr/bin/env python

# Creates db and user for an OpenStack Service:
# Set ROOT_DB_CONNECTION and DB_CONNECTION environment variables to contain
# SQLAlchemy strings for the root connection to the database and the one you
# wish the service to use. Alternatively, you can use an ini formatted config
# at the location specified by OPENSTACK_CONFIG_FILE, and extract the string
# from the key OPENSTACK_CONFIG_DB_KEY, in the section specified by
# OPENSTACK_CONFIG_DB_SECTION.

import os
import sys
import logging
from sqlalchemy import create_engine
from sqlalchemy import text
from sqlalchemy.engine import make_url

# Create logger, console handler and formatter
logger = logging.getLogger('Artifactory Collate Altering')
logger.setLevel(logging.DEBUG)
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)
formatter = logging.Formatter(
    '%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# Set the formatter and add the handler
ch.setFormatter(formatter)
logger.addHandler(ch)


# Get the connection string for the service db root user
if "ROOT_DB_CONNECTION" in os.environ:
    db_connection = os.environ['ROOT_DB_CONNECTION']
    logger.info('Got DB root connection')
else:
    logger.critical('environment variable ROOT_DB_CONNECTION not set')
    sys.exit(1)

mysql_x509 = os.getenv('MARIADB_X509', "")
ssl_args = {}
if mysql_x509:
    ssl_args = {'ssl': {'ca': '/etc/mysql/certs/ca.crt',
                        'key': '/etc/mysql/certs/tls.key',
                        'cert': '/etc/mysql/certs/tls.crt'}}

collate = os.environ.get('DB_COLLATE', 'utf8mb3_bin')

# Root DB engine
try:
    root_engine_url = make_url(db_connection)
    database = root_engine_url.database
    root_engine_url = root_engine_url._replace(database=None)
    root_engine = create_engine(root_engine_url, connect_args=ssl_args,
                                future=True)
    connection = root_engine.connect()
    connection.close()
    logger.info("Tested connection to DB {0}".format(root_engine_url))
except:
    logger.critical('Could not connect to database as root user')
    raise

# Alter DB
query = "ALTER DATABASE `{0}` COLLATE `{1}`".format(database, collate)
try:
    with root_engine.connect() as conn:
        conn.execute(text(query))
        conn.commit()
    logger.info("DB {0} Collate set to {1}".format(database, collate))
except:
    logger.critical("Could not set collate to DB {}".format(database))
    raise

# Alter Tables
try:
    with root_engine.connect() as conn:
        arg_dict = {'schema': database, 'collate': collate}
        stmt = text('SELECT TABLE_NAME FROM information_schema.TABLES WHERE '
                    'table_schema = :schema and table_collation != :collate')
        result = conn.execute(stmt, arg_dict).all()
        logger.info('Found {} table(s) with wrong collate'.format(len(result)))
        for row in result:
            query = "ALTER TABLE `{0}`.`{1}` COLLATE `{2}`".format(
                database, row.TABLE_NAME, collate)
            conn.execute(text(query))
        else:
            conn.commit()
            logger.info('Fixed collate for {} table(s)'.format(len(result)))
except:
    logger.critical("Could not alter tables in database {0}".format(database))
    raise

# Alter Columns
try:
    with root_engine.connect() as conn:
        conn.execute(text('SET FOREIGN_KEY_CHECKS=0'))
        arg_dict = {'schema': database, 'collate': collate}
        stmt = text('SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE FROM '
                    'information_schema.COLUMNS WHERE table_schema = :schema '
                    'and collation_name != :collate')
        result = conn.execute(stmt, arg_dict).all()
        logger.info('Found {} column(s) with wrong collate'.format(
            len(result)))
        for row in result:
            query = ("ALTER TABLE `{0}`.`{1}` MODIFY COLUMN `{2}` {3} COLLATE "
                     "`{4}`".format(database, row.TABLE_NAME, row.COLUMN_NAME,
                                    row.COLUMN_TYPE, collate))
            conn.execute(text(query))
        else:
            conn.commit()
            logger.info('Fixed collate for {} column(s)'.format(len(result)))
        conn.execute(text('SET FOREIGN_KEY_CHECKS=1'))
except:
    logger.critical("Could not alter columns in database {0}".format(database))
    conn.execute(text('SET FOREIGN_KEY_CHECKS=1'))
    raise

logger.info('Finished DB Management')
{{- end }}
