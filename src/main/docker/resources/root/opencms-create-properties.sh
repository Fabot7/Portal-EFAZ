#!/bin/bash

OCSERVER="http://127.0.0.1:8088"
HWADDR="78:f2:9e:f5:db:e6"

DB_USER=opencms
DB_PWD=oracle
DB_DB=opencms
DB_PRODUCT=oracle
DB_URL="jdbc:oracle:thin:@10.10.253.2:1521:XE"
DB_DRIVER=oracle.jdbc.driver.OracleDriver

# Create setup.properties
echo "OpenCms Setup: Writing configuration to '$CONFIG_FILE'"
echo "-- Components: $OPENCMS_COMPONENTS"
PROPERTIES="

setup.webapp.path=$OPENCMS_HOME_INSTALL
setup.default.webapp=
setup.install.components=$OPENCMS_COMPONENTS
setup.show.progress=true

db.product=$DB_PRODUCT
db.provider=$DB_PRODUCT
db.create.user=$DB_USER
db.create.pwd=$DB_PWD
db.worker.user=$DB_USER
db.worker.pwd=$DB_PWD
db.connection.url=$DB_URL
db.name=$DB_DB
db.create.db=true
db.create.tables=true
db.dropDb=true
db.default.tablespace=users
db.index.tablespace=users
db.jdbc.driver=$DB_DRIVER
db.template.db=
db.temporary.tablespace=temp

server.url=$OCSERVER
server.name=OpenCmsServer
server.ethernet.address=$HWADDR
server.servlet.mapping=

"
echo "$PROPERTIES" > $CONFIG_FILE || { echo "Error: Couldn't write to '$CONFIG_FILE'!" ; exit 1 ; }
