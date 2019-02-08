#!/bin/bash

mkdir -p /var/tmp/tomcat8/webapps/ROOT
cp -r /var/tmp/OPENCMS/* /var/lib/tomcat8/webapps/ROOT

source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND