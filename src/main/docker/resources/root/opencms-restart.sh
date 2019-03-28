#!/bin/bash

# OpenCms server restart script

# We must work around an isse here that exists with Docker and the default Tomcat startup scripts.
# In short, the official "restart" script does not work in a Docker container. This is a known issue.
# Full information on the issue: https://github.com/docker/docker/issues/6800

WIDTH=$(stty size | cut -d" " -f2)

# Stopping the container is simply kill all processes of the tomcat user
echo "."
echo "Restarting OpenCms!"
echo "."

pkill -u ${TOMCAT}

echo "Killed Tomcat."
echo "."
echo "Waiting 10 seconds so that OpenCms can do a clean shut down..."
echo "."

sleep 10
tail -20 /var/lib/${TOMCAT}/webapps/ROOT/WEB-INF/logs/opencms.log

echo "."
echo "Shut down completed - see opencms.log tail above."
echo "."
echo "Starting Tomcat again..."
echo "."

service ${TOMCAT} start
echo "."
ps aux | grep ${TOMCAT} | cut -c-$WIDTH

echo "."
echo "The ps output above should contain a ${TOMCAT} process."
echo "This means Tomcat runs, even though a [fail] message may have been displayed earlier!"
echo "."
