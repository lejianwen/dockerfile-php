#!/bin/sh
set -e
#编译前准备
yum -y install epel-release
yum -y install autoconf bison gcc gcc-c++ make openssl openssl-devel curl curl-devel libxml2 libxml2-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel wget sqlite-devel libzip libzip-devel oniguruma oniguruma-devel

downurl=https://www.266555.net/php-7.4.12.tar.gz

useradd -u 1000 www -s /sbin/nologin &&
  mkdir /data/src/php -p /data/apps/php/etc &&
  cd /data/src &&
  wget $downurl -O php.tar.gz &&
  tar -zxf php.tar.gz -C ./php --strip-components 1

ldconfig
