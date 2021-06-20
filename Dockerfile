FROM alpine:latest

LABEL Maintainer="Nexteam <developer@nexteam.id>" \
      Description="Lightweight container with Nginx 1.16 & PHP-FPM 7.4 based on Alpine Linux"

RUN apk update \
  && apk add --no-cache nginx php8-fpm php8-mcrypt \
    php8-soap php8-openssl php8-gmp \
    php8-pdo_odbc php8-json php8-dom \
    php8-pdo php8-zip php8-mysqli \
    php8-apcu php8-pdo_pgsql \
    php8-bcmath php8-gd php8-odbc \
    php8-pdo_mysql \
    php8-gettext php8-xmlreader php8-xmlrpc \
    php8-bz2 php8-iconv php8-pdo_dblib php8-curl php8-ctype \
    supervisor