#!/bin/bash



if [ ! -f ${CATALINA_HOME}/.tomcat_created ]; then
  ${CATALINA_HOME}/bin/create_tomcat_user.sh
fi

DIR=${DEPLOY_DIR:-/webapps}
echo "Checking *.war in $DIR"
if [ -d $DIR ]; then
  for i in $DIR/*.war; do
     file=$(basename $i)
     echo "Linking $i --> ${CATALINA_HOME}/webapps/$file"
     ln -s $i ${CATALINA_HOME}/webapps/$file
  done
fi

DIR=${LIBS_DIR:-/libs}
echo "Checking tomcat extended libs *.jar in $DIR"
if [ -d $DIR ]; then
  for i in $DIR/*.jar; do
     file=$(basename $i)
     echo "Linking $i --> ${CATALINA_HOME}/lib/$file"
     ln -s $i ${CATALINA_HOME}/lib/$file
  done
fi

# Autorestart possible?
#-XX:OnError="cmd args; cmd args"
#-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/heapdump.hprof -XX:OnOutOfMemoryError="sh ~/cleanup.sh"

export LANG="en_US.UTF-8"
export JAVA_OPTS="$JAVA_OPTS -Duser.language=en -Duser.country=US"
export CATALINA_PID=${CATALINA_HOME}/temp/tomcat.pid
#export CATALINA_OPTS="$CATALINA_OPTS  -Xmx${JAVA_MAXMEMORY} -DjvmRoute=${TOMCAT_JVM_ROUTE}  -Dtomcat.maxThreads=${TOMCAT_MAXTHREADS}  -Dtomcat.minSpareThreads=${TOMCAT_MINSPARETHREADS}  -Dtomcat.httpTimeout=${TOMCAT_HTTPTIMEOUT}  -Djava.security.egd=file:/dev/./urandom"
exec ${CATALINA_HOME}/bin/catalina.sh run
# OpenCms startup script executed when Docker loads the image

# Execute pre-init configuration scripts
bash /root/process-script-dir.sh /root/preinit runonce

echo "Starting OpenCms / Tomcat in background"
/etc/init.d/${TOMCAT} start &> /dev/null &

# Execute post-init configuration scripts
bash /root/process-script-dir.sh /root/postinit runonce

# We need a running process for docker
sleep 10000d
