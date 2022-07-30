#!/bin/sh
set -e
#编译前准备
yum -y install epel-release
yum -y install autoconf bison gcc gcc-c++ make openssl openssl-devel curl curl-devel libxml2 libxml2-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel wget sqlite-devel oniguruma oniguruma-devel libwebp libwebp-devel

downurl=https://www.php.net/distributions/php-7.4.30.tar.gz

useradd -u 1000 www -s /sbin/nologin &&
  mkdir /data/src/php -p /data/apps/php/etc &&
  cd /data/src &&
  wget $downurl -O php.tar.gz &&
  tar -zxf php.tar.gz -C ./php --strip-components 1

cd /data/src && wget --no-check-certificate https://libzip.org/download/libzip-1.3.2.tar.gz \
    && tar -zxvf libzip-1.3.2.tar.gz