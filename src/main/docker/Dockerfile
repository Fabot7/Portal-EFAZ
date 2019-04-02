#===============================================================#
# -- Baixa o PHP 7.0 com Apache e o utiliza como imagem base -- #
#===============================================================#
FROM php:7.0-apache

#===============================================================#
# ------- Atribui o mantenedor do sistema dockerizado --------- #
#===============================================================#
MAINTAINER Fábio Silva da Conceição <fsconceicao@sefaz.al.gov.br>

#===============================================================#
# ------ Criação de volumes e exposição de portas TCP/UDP ----- #
#===============================================================#
VOLUME ["/var/www/html"]

EXPOSE 80

#===============================================================#
# --- Impede a interatividade via TTY, durante a instalação --- #
#===============================================================#
ENV DEBIAN_FRONTEND noninteractive

#===============================================================#
# ------------- Instala extensões PHP necessárias ------------- #
#===============================================================#
RUN set -ex; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libjpeg-dev \
		libpng-dev \
	; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install gd mysqli opcache zip;

#===============================================================#
# ----- Define configurações recomendadas para o php.ini ------ #
#===============================================================#
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

#===============================================================#
# ------------ Habilita reescrita no módulo Apache ------------ #
#===============================================================#
RUN a2enmod rewrite expires

#===============================================================#
# --- Definição de variáveis para instalação e configuração --- #
#===============================================================#
ENV WORDPRESS_VERSION 4.9.8

ENV WORDPRESS_SHA1 0945bab959cba127531dceb2c4fed81770812b4f

#===============================================================#
# --- Download, descompactação, posicionamento e permissões --- #
#===============================================================#
RUN set -ex; \
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
	chown -R www-data:www-data /usr/src/wordpress; \
	chown -R 777 /usr/src/wordpress

#===============================================================#
# --- Copia e posiciona foreground.sh e docker-entrypoint.sh -- #
#===============================================================#

COPY docker-entrypoint.sh /usr/local/bin/

COPY foreground.sh /usr/local/bin/

#===============================================================#
# --- Permite execução foreground.sh e docker-entrypoint.sh --- #
#===============================================================#

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/foreground.sh

#===============================================================#
# --- Executa docker-entrypoint.sh e depois o foreground.sh --- #
#===============================================================#

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["foreground.sh"]