#===============================================================#
#------------ Imagem base da biblioteca java jre 8 -------------#
#===============================================================#
FROM tomcat:8-jre11

#===============================================================#
#----- Mantenedor local do sistema dockerizado Portal EFAZ -----#
#===============================================================#
MAINTAINER Fábio Silva da Conceição <fsconceicao@sefaz.al.gov.br>

#===============================================================#
#------------ Declaração de variáveis de ambiente --------------#
#===============================================================#
ENV DEBIAN_FRONTEND=noninteractive \
    TOMCAT=tomcat8

#===============================================================#
#------------------ Define diretório de trabalho----------------#
#===============================================================#
WORKDIR /var/tmp

#===============================================================#
#----------- Instalação de complementos e utilitários ----------#
#===============================================================#
RUN \
# Update the apt packet repos
    apt-get update && \
# Install tomcat8, wget, and unzip
    apt-get install -yq --no-install-recommends \
        wget \
        unzip
#===============================================================#
#------------------- Instalação do Tomcat8 ---------------------#
#===============================================================#
RUN \
#Install Java
sudo apt-get update
sudo apt-get install default-jdk

RUN \
#Create Tomcat User
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

RUN \
#Install Tomcat
cd /tmp
curl -O http://mirror.nbtelecom.com.br/apache/tomcat/tomcat-8/v8.5.38/bin/apache-tomcat-8.5.38.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

RUN \
#Update Permissions
cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/

RUN \
#Create a systemd Service File
sudo update-java-alternatives -l

RUN rm -R /etc/systemd/system/tomcat.service

COPY tomcat.service /etc/systemd/system/tomcat.service

#===============================================================#
#----- Copia os arquivos de configuração para o container ------#
#===============================================================#

COPY opencms.properties opencms.properties
COPY database.properties database.properties
COPY First_Startup.sh First_Startup.sh

#===============================================================#
#---- Download, descompactação e posicionamento do OpenCMS -----#
#===============================================================#

RUN wget http://www.opencms.org/downloads/opencms/opencms-10.5.4.zip

RUN unzip opencms-10.5.4.zip
RUN unzip -d OPENCMS opencms.war

RUN rm -Rf OPENCMS/WEB-INF/config/opencms.properties
RUN rm -Rf OPENCMS/setup/database/database.properties

RUN mv opencms.properties OPENCMS/WEB-INF/config/opencms.properties
RUN mv database.properties OPENCMS/setup/database/oracle/database.properties

#===============================================================#
#----- Expôe a porta padrão do servidor web Apache Tomcat ------#
#===============================================================#
EXPOSE 8080

#===============================================================#
#---- Abre o diretório do projeto webapps para persistência ----#
#===============================================================#
VOLUME ["/var/lib/tomcat8"]

#===============================================================#
#----------- Executa o script shell na inicialização -----------#
#===============================================================#

CMD ["/var/tmp/Startup.sh"]

