#===============================================================#
#------------ Imagem base da biblioteca java jre 8 -------------#
#===============================================================#
FROM tomcat:8-jre11

#===============================================================#
#----- Mantenedor local do sistema dockerizado Portal EFAZ -----#
#===============================================================#
MAINTAINER Fábio Silva da Conceição <fsconceicao@sefaz.al.gov.br>

WORKDIR /

# Variables used in the shell scripts loaded from the file system
ENV DEBIAN_FRONTEND=noninteractive
ENV TOMCAT=tomcat

ENV WEBAPPS_HOME=/usr/local/${TOMCAT}/webapps
ENV WEBAPPS_HOME_INSTALL=/usr/local/${TOMCAT}/webapps
ENV OPENCMS_HOME=/opt/tomcat/webapps/ROOT
ENV OPENCMS_HOME_INSTALL=/usr/local/${TOMCAT}/webapps/ROOT
ENV CONFIG_FILE=/setup.properties
ENV OPENCMS_COMPONENTS=workplace,demo

COPY resources/ resources
RUN mkdir /teste
COPY cmssetup.txt /teste/cmssetup.txt
COPY opencms-configuration.xslt /teste/opencms-configuration.xslt

COPY packages/ packages
COPY Startup.sh Startup.sh
COPY opencms.properties opencms.properties

#===============================================================#
#----------- Instalação de complementos e utilitários ----------#
#===============================================================#
RUN apt-get update

RUN apt install -yq --no-install-recommends wget
RUN apt install -yq --no-install-recommends unzip
RUN apt install -yq --no-install-recommends nano

#===============================================================#
#------------------- Instalação do Tomcat8 ---------------------#
#===============================================================#
RUN apt install -yq --no-install-recommends default-jdk

RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

RUN cd /tmp
COPY apache-tomcat-8.5.38.tar.gz apache-tomcat-8.5.38.tar.gz
RUN mkdir /opt/tomcat
RUN tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

RUN chgrp -R tomcat /opt/tomcat
RUN chmod -R g+r /opt/tomcat/conf/
RUN chmod g+x /opt/tomcat/conf/
RUN chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs

COPY tomcat.service /etc/systemd/system/tomcat.service

COPY create_tomcat_user.sh /usr/local/tomcat/bin/create_tomcat_user.sh

RUN chmod 777 /usr/local/tomcat/bin/create_tomcat_user.sh

#===============================================================#
#---- Download, descompactação e posicionamento do OpenCMS -----#
#===============================================================#
RUN wget http://www.opencms.org/downloads/opencms/opencms-10.5.4.zip

RUN unzip opencms-10.5.4.zip

RUN unzip -d OPENCMS opencms.war

RUN chmod 777 -R resources/*

RUN rm -R /usr/local/tomcat/webapps/ROOT/WEB-INF

RUN rm /OPENCMS/WEB-INF/config/opencms.properties

RUN cp opencms.properties /OPENCMS/WEB-INF/config/opencms.properties

RUN mv OPENCMS/* /usr/local/tomcat/webapps/ROOT

RUN cp /teste/* /resources/config/

RUN chmod 777 -R /Startup.sh

#===============================================================#
#---------- Execução dos scripts de configuração ---------------#
#===============================================================#


# Expose port 8080 for Tomcat and define the startup script
EXPOSE 8080

CMD ["/Startup.sh"]
