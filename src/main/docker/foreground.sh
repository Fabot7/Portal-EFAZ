#!/bin/bash

#===============================================================#
#---------- ATRIBUIÇÃO DE PROPRIEDADE E PERMISSÕES -------------#
#===============================================================#
chown -R www-data:www-data /var/www/html /var/www/html/*
chmod 777 -R /var/www/html /var/www/html/*
chmod 777 -R /usr/src/wordpress /usr/src/wordpress/*

#===============================================================#
#----------------- MANIPULAÇÃO DE CONTEÚDO ---------------------#
#===============================================================#

if [ -e /var/www/html/wp-content -o -e /var/www/html/wp-settings.php -o -e /var/www/html/wp-config.php ];
  then
  echo "Container reiniciou pela ultima vez em: $(date +%d)/$(date +%m)/$(date +%y) - $(date +%T)" > /var/www/html/Last_Container_Restart;
  else
  cp -R /usr/src/wordpress/* /var/www/html
  rm -R /var/www/html/index.html
fi

#===============================================================#
#---------- ATRIBUIÇÃO DE PROPRIEDADE E PERMISSÕES -------------#
#===============================================================#
chown -R www-data:www-data /var/www/html /var/www/html/*
chmod 777 -R /var/www/html /var/www/html/*

#===============================================================#
#----------- TRATAMENTO DE PRIORIDADE DE PROCESSOS -------------#
#===============================================================#
read pid cmd state ppid pgrp session tty_nr tpgid rest < /proc/self/stat
trap "kill -TERM -$pgrp; exit" EXIT TERM KILL SIGKILL SIGTERM SIGQUIT

#===============================================================#
#------ EXECUÇÃO DO APACHE2 E DEFINIÇÃO DE PRIMEIRO PLANO ------#
#===============================================================#
source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND

#===============================================================#