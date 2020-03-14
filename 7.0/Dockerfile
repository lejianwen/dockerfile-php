FROM centos
MAINTAINER lejianwen <84855512@qq.com>
RUN yum -y install epel-release autoconf bison gcc gcc-c++ make openssl openssl-devel curl curl-devel libxml2 libxml2-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel wget
ENV setuppath /data/apps/php
ENV downurl https://www.266555.net/php-7.0.33.tar.gz
RUN useradd -u 1000 www -s /sbin/nologin \
  && mkdir /data/src/php -p \
  && cd /data/src \
  && wget $downurl -O php.tar.gz \
  && tar -zxf php.tar.gz -C ./php --strip-components 1  \
  && cd php \
  && ./configure --prefix=$setuppath \
     		--with-config-file-path=$setuppath/etc \
     		--with-mysqli=mysqlnd \
     		--with-pdo-mysql=mysqlnd \
     		--with-mysql-sock=/tmp/mysql.sock \
     		--enable-mysqlnd \
     		--with-gd \
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
     		--enable-gd-native-ttf \
     		--with-openssl \
     		--enable-pcntl \
     		--enable-sockets \
     		--with-xmlrpc \
     		--enable-zip \
     		--enable-soap \
     		--with-gettext \
     		--with-curl \
     		--with-jpeg-dir \
     		--enable-opcache \
     		--without-pear \
#     		--disable-phar \
#     		--disable-cli \
#     		--disable-phpdbg \
     		--with-freetype-dir && make && make install \
     		&& cp -a ./php.ini-production $setuppath/etc/php.ini \
     		&& cp -a $setuppath/etc/php-fpm.conf.default $setuppath/etc/php-fpm.conf \
     		&& cp -a $setuppath/etc/php-fpm.d/www.conf.default $setuppath/etc/php-fpm.d/www.conf \
     		&& make clean \
  && cd /data/src && mkdir /data/src/phpredis -p \
  && wget http://pecl.php.net/get/redis-4.0.0.tgz -O phpredis.tgz \
  &&  tar -zxvf phpredis.tgz -C ./phpredis --strip-components 1 && cd phpredis \
  && $setuppath/bin/phpize && ./configure --with-php-config=$setuppath/bin/php-config && make && make install \
  && echo "extension_dir=\"$setuppath/lib/php/extensions/no-debug-non-zts-20151012/\"" >> $setuppath/etc/php.ini \
  && echo 'extension = "redis.so"' >> $setuppath/etc/php.ini \
  && make clean && rm /data/src -rf
EXPOSE 9000
CMD ["/data/apps/php/bin/php", "-v"]
