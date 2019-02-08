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

WORKDIR /var/tmp

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
#----- Copia o conteúdo Tomcat8 para a '/var/tmp/tomcat8' ------#
#===============================================================#
RUN mkdir -p /var/tmp/tomcat8/
RUN cp -R /var/lib/tomcat8/* /var/tmp/tomcat8/
RUN rm -Rf /var/tmp/tomcat8/webapps/

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
CMD ["/var/tmp/First_Startup.sh"]