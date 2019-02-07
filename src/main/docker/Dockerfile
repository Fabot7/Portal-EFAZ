#===============================================================#
#------------ Imagem base da biblioteca java jre 8 -------------#
#===============================================================#
FROM java:8-jre

#===============================================================#
#----- Mantenedor local do sistema dockerizado Portal EFAZ -----#
#===============================================================#
MAINTAINER Fábio Silva da Conceição <fsconceicao@sefaz.al.gov.br>

#===============================================================#
#------------ Declaração de variáveis de ambiente --------------#
#===============================================================#
ENV DEBIAN_FRONTEND=noninteractive \
    TOMCAT=tomcat8

ENV WEBAPPS_HOME=/var/lib/${TOMCAT}/webapps \
    WEBAPPS_HOME_INSTALL=/var/lib/${TOMCAT}/webapps-install \
    OPENCMS_HOME=/var/lib/${TOMCAT}/webapps/ROOT \
    OPENCMS_HOME_INSTALL=/var/lib/${TOMCAT}/webapps-install/ROOT \
    CONFIG_FILE=/setup.properties \
    OPENCMS_COMPONENTS=workplace,demo

#===============================================================#
#----------- Instalação de complementos e utilitários ----------#
#===============================================================#
RUN \
# Update the apt packet repos
    apt-get update && \
# Install tomcat8, wget, and unzip
    apt-get install -yq --no-install-recommends \
        ${TOMCAT} \
        wget \
        unzip

#===============================================================#
#----- Copia os arquivos de configuração para o container ------#
#===============================================================#

COPY opencms.properties /var/tmp/opencms.properties
COPY database.properties /var/tmp/database.properties

#===============================================================#
#---- Download, descompactação e posicionamento do OpenCMS -----#
#===============================================================#
# Download core artifacts if not already present

WORKDIR /var/tmp

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
#----- Copia o conteúdo Tomcat8 para a '/var/tmp/tomcat8' ------#
#===============================================================#
RUN mkdir -p /var/tmp/tomcat8/
RUN cp -R /var/lib/tomcat8/* /var/tmp/tomcat8/
RUN rm -Rf /var/tmp/tomcat8/webapps/

#===============================================================#
#---- Abre o diretório do projeto webapps para persistência ----#
#===============================================================#
VOLUME ["/var/lib/tomcat8"]

#===============================================================#
#----------- Executa o script shell na inicialização -----------#
#===============================================================#
CMD ["/var/tmp/First_Startup.sh"]