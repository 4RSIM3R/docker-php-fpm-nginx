FROM alpine:3.14.0

LABEL Maintainer="Nexteam <developer@nexteam.id>" \
      Description="Lightweight container with Nginx 1.16 & PHP-FPM 7.4 based on Alpine Linux"

#ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# make sure you can use HTTPS
RUN apk --update add ca-certificates

# add php repository
RUN echo "https://dl.bintray.com/php-alpine/v3.14/php-8.0" >> /etc/apk/repositories

# Install packages
RUN apk --no-cache add php \
       php-fpm \
       php-opcache \
       php-openssl \
       php-curl \
       php-mysqli \
       php-pdo \
       php-pdo_mysql \
       php-mbstring \
       nginx \
       supervisor \
       curl \
       vim \
       procps \
       htop 

# https://github.com/codecasts/php-alpine/issues/21
RUN ln -s /usr/bin/php7 /usr/bin/php

# Configure nginx
COPY server/nginx.conf /etc/nginx/nginx.conf

# Remove default server definition
RUN rm /etc/nginx/conf.d/default.conf

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup document root
RUN mkdir -p /var/www/html

RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

COPY --chown=nobody src/ /var/www/html/

EXPOSE 80

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]


