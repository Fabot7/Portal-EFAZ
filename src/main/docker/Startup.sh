#!/bin/bash



echo "##########Rodando Script de pré configuração##########"
echo "."
bash resources/root/opencms-create-properties.sh
echo "."
echo "Pré configuração concluída"
echo "."

echo "##########Rodando Script de pré instalação##########"
echo "."
bash resources/root/process-script-dir.sh resources/root/preinstall
echo "."
echo "##########Pré Instalação Concluída##########"
echo "."

echo "##########Rodando Script Auto Configuração##########"
echo "."
java -classpath "${OPENCMS_HOME_INSTALL}/WEB-INF/lib/*:${OPENCMS_HOME_INSTALL}/WEB-INF/classes:/usr/local/${TOMCAT}/lib/*" org.opencms.setup.CmsAutoSetup -path $CONFIG_FILE
echo "."
echo "##########Auto Config executada##########"
echo "."

echo "##########Rodando Script de pós install##########"
echo "."
bash resources/root/process-script-dir.sh resources/root/postinstall
echo "."
echo "##########Pós Install executado##########"
echo "."

echo "##########Iniciando TOMCAT e APP##########"
echo "."
bash resources/root/opencms-run.sh
echo "############################"
echo "##########É tetra!##########"
echo "############################"
echo "."

echo "Movendo arquivos para config"
echo "."
bash cp teste/* resources/config
echo "."
