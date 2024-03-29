#!/bin/sh
set -e
cd /data/src/libzip-1.3.2 && ./configure --prefix=/usr && make && make install && make clean

cp /usr/lib/libzip.so.5 /lib64/
export PKG_CONFIG_PATH=/usr/lib/pkgconfig/:$PKG_CONFIG_PATH
ldconfig
echo $PKG_CONFIG_PATH
setuppath=/data/apps/php
# 编译php
cd /data/src/php &&
  ./configure --prefix=$setuppath \
    --with-config-file-path=$setuppath/etc \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-mysql-sock=/tmp/mysql.sock \
    --enable-mysqlnd \
    --enable-gd \
    --with-jpeg \
    --with-webp \
    --with-freetype \
    --with-iconv \
    --with-zlib \
    --enable-bcmath \
    --enable-shmop \
    --enable-sysvsem \
    --enable-inline-optimization \
    --enable-mbregex \
    --enable-fpm \
    --enable-mbstring \
    --enable-ftp \
    --with-openssl \
    --enable-pcntl \
    --enable-sockets \
    --with-xmlrpc \
    --with-zip \
    --enable-soap \
    --with-gettext \
    --with-curl \
    --enable-opcache \
    --without-pear \
    --disable-phar \
    --disable-phpdbg \
    && make -j8 && make install &&
  cp -a ./php.ini-production $setuppath/etc/php.ini &&
  cp -a $setuppath/etc/php-fpm.conf.default $setuppath/etc/php-fpm.conf &&
  cp -a $setuppath/etc/php-fpm.d/www.conf.default $setuppath/etc/php-fpm.d/www.conf &&
  make clean

#安装redis扩展
cd /data/src && mkdir /data/src/phpredis -p &&
  wget http://pecl.php.net/get/redis-4.0.0.tgz -O phpredis.tgz &&
  tar -zxf phpredis.tgz -C ./phpredis --strip-components 1 && cd phpredis &&
  $setuppath/bin/phpize && ./configure --with-php-config=$setuppath/bin/php-config && make && make install &&
  echo "extension_dir=\"$setuppath/lib/php/extensions/no-debug-non-zts-20190902/\"" >>$setuppath/etc/php.ini &&
  echo 'extension = "redis.so"' >>$setuppath/etc/php.ini &&
  make clean && rm /data/src -rf

ln -s /data/apps/php/bin/php /bin/php
ln -s /data/apps/php/sbin/php-fpm /sbin/php-fpm
