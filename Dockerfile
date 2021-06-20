FROM alpine:latest

LABEL Maintainer="Nexteam <developer@nexteam.id>" \
      Description="Lightweight container with Nginx 1.16 & PHP-FPM 7.4 based on Alpine Linux"

# Install packages and remove default server definition
RUN apk --no-cache add \
  curl \
  nginx \
  php8 \
  php8-ctype \
  php8-curl \
  php8-dom \
  php8-fpm \
  php8-gd \
  php8-intl \
  php8-json \
  php8-mbstring \
  php8-mysqli \
  php8-opcache \
  php8-openssl \
  php8-phar \
  php8-session \
  php8-xml \
  php8-xmlreader \
  php8-zlib \
  supervisor

COPY server/nginx.conf /etc/nginx/nginx.conf

    # Setup document root
RUN mkdir -p /var/www/html

    # Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R 777 /var/www/html && \
      chown -R 777 /run && \
      chown -R 777 /var/lib/nginx && \
      chown -R 777 /var/log/nginx

WORKDIR /var/www/html
COPY src/ /var/www/html/

EXPOSE 80