#!/bin/bash

mkdir -p /var/lib/tomcat8/webapps/ROOT
cp -r /var/tmp/OPENCMS/* /var/lib/tomcat8/webapps/ROOT

source /usr/sbin/envvars && exec /usr/sbin/apache2 -D FOREGROUND