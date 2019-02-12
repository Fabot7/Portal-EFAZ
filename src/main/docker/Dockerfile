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

# Update the apt packet repos
RUN apt-get update
# Install tomcat8, wget, and unzip
RUN apt install -yq --no-install-recommends
RUN wget
RUN unzip

#===============================================================#
#------------------- Instalação do Tomcat8 ---------------------#
#===============================================================#
RUN apt-get update
RUN apt install default-jdk

RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

RUN cd /tmp
RUN curl -O http://mirror.nbtelecom.com.br/apache/tomcat/tomcat-8/v8.5.38/bin/apache-tomcat-8.5.38.tar.gz
RUN mkdir /opt/tomcat
RUN tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

RUN cd /opt/tomcat
RUN chgrp -R tomcat /opt/tomcat
RUN chmod -R g+r conf
RUN chmod g+x conf
RUN chown -R tomcat webapps/ work/ temp/ logs/

RUN update-java-alternatives -l

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

