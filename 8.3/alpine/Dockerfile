FROM php:8.3-fpm-alpine

# 安装构建工具
RUN apk add --no-cache --virtual .pecl-deps  \
    autoconf \
    gcc \
    g++ \
    make \
    linux-headers \
    libc-dev \
   && docker-php-ext-install pdo_mysql && docker-php-ext-install pcntl && docker-php-ext-install opcache && docker-php-ext-install bcmath; \
#simdjson 需要 libstdc++ 库
#   pecl install simdjson && docker-php-ext-enable simdjson \
#   && apk add libstdc++; \
   \
   pecl install redis-5.3.7 && docker-php-ext-enable redis \
   && docker-php-source delete \
   && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
   && apk del --no-network .pecl-deps \
   && adduser www -u 1000 -s /sbin/nologin -D \
   && rm -rf /tmp/pear ~/.pearrc;
