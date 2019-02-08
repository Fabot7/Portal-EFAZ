#!/bin/bash

mkdir -p /var/lib/tomcat8/webapps/ROOT
cp -r /var/tmp/OPENCMS/* /var/lib/tomcat8/webapps/ROOT

exec /usr/sbin/apache2 -DFOREGROUND