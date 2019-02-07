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
# Install mysql and tomcat
    apt-get install -yq --no-install-recommends \
        ${TOMCAT} \
        gettext && \
# Clean up and set timezone
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove && \
    apt-get clean

#===============================================================#
#----- Copia os arquivos de configuração para o container ------#
#===============================================================#
COPY resources /
ADD First_Startup.sh /

#===============================================================#
#---- Download, descompactação e posicionamento do OpenCMS -----#
#===============================================================#
# Download core artifacts if not already present
RUN bash /root/download-artifacts.sh /config/artifacts.csv && \
    cd /artifacts/core/ && \
    unzip opencms.zip && \
    cd / && \
    mv /artifacts/core/opencms.war /artifacts/opencms.war && \
    rm -fr /artifacts/core

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
CMD ["/root/opencms-run.sh"]