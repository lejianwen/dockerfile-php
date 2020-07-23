FROM centos:7 as php-base
MAINTAINER lejianwen <84855512@qq.com>
RUN yum -y install epel-release autoconf bison gcc gcc-c++ make openssl openssl-devel curl curl-devel libxml2 libxml2-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel wget

ENV setuppath /data/apps/php
ENV downurl https://www.266555.net/php-7.3.6.tar.gz

RUN useradd -u 1000 www -s /sbin/nologin \
  && mkdir /data/src/php -p  /data/apps/php/etc \
  && cd /data/src \
  && wget $downurl -O php.tar.gz \
  && tar -zxf php.tar.gz -C ./php --strip-components 1

# libzip
RUN yum -y remove libzip libzip-devel
RUN cd /data/src && wget https://libzip.org/download/libzip-1.3.2.tar.gz \
    && tar -zxvf libzip-1.3.2.tar.gz  && cd /data/src/libzip-1.3.2 && ./configure && make && make install && make clean
RUN ldconfig

RUN cd /data/src/php \
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
     		--disable-fpm \
     		--enable-mbstring \
     		--enable-ftp \
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
     		--disable-phar \
     		--disable-phpdbg \
     		--with-freetype-dir && make -j4 && make install \
     		&& cp -a ./php.ini-production $setuppath/etc/php.ini \
#     		&& cp -a $setuppath/etc/php-fpm.conf.default $setuppath/etc/php-fpm.conf \
#     		&& cp -a $setuppath/etc/php-fpm.d/www.conf.default $setuppath/etc/php-fpm.d/www.conf \
     		&& make clean
RUN cd /data/src && mkdir /data/src/phpredis -p \
  && wget http://pecl.php.net/get/redis-4.0.0.tgz -O phpredis.tgz \
  &&  tar -zxf phpredis.tgz -C ./phpredis --strip-components 1 && cd phpredis \
  && $setuppath/bin/phpize && ./configure --with-php-config=$setuppath/bin/php-config && make && make install \
  && echo "extension_dir=\"$setuppath/lib/php/extensions/no-debug-non-zts-20180731/\"" >> $setuppath/etc/php.ini \
  && echo 'extension = "redis.so"' >> $setuppath/etc/php.ini \
  && make clean && rm /data/src -rf

RUN ln -s  /data/apps/php/bin/php /bin/php
#RUN ln -s  /data/apps/php/sbin/php-fpm /sbin/php-fpm

FROM php-base as php-builder
MAINTAINER lejianwen <84855512@qq.com>
ENV setuppath /data/apps/php

RUN mkdir /data/src/swoole -p && cd /data/src \
  && wget https://gitee.com/swoole/swoole/repository/archive/v4.5.2?format=tar.gz -O swoole.gz
RUN cd /data/src && tar -zxf swoole.gz -C ./swoole --strip-components 1 && cd swoole \
  && $setuppath/bin/phpize && ./configure --with-php-config=$setuppath/bin/php-config --enable-openssl --enable-http2 && make && make install \
  && echo 'extension = "swoole.so"' >> $setuppath/etc/php.ini \
  && make clean && rm /data/src -rf

FROM php-builder as php-builder2
WORKDIR /rootfs
#COPY copy_lib.sh /rootfs/
#RUN chmod +x /rootfs/copy_lib.sh
#RUN sh copy_lib.sh
RUN mkdir -p lib64 \
      &&  cp /lib64/libcrypt.so.1 ./lib64 \
    	&& cp /lib64/libz.so.1 ./lib64 \
    	&& cp /lib64/libresolv.so.2 ./lib64 \
    	&& cp /lib64/librt.so.1 ./lib64 \
    	&& cp /lib64/libpng15.so.15 ./lib64 \
    	&& cp /lib64/libjpeg.so.62 ./lib64 \
    	&& cp /lib64/libcurl.so.4 ./lib64 \
    	&& cp /lib64/libm.so.6 ./lib64 \
    	&& cp /lib64/libdl.so.2 ./lib64 \
    	&& cp /lib64/libnsl.so.1 ./lib64 \
    	&& cp /lib64/libxml2.so.2 ./lib64 \
    	&& cp /lib64/libssl.so.10 ./lib64 \
    	&& cp /lib64/libcrypto.so.10 ./lib64 \
    	&& cp /lib64/libfreetype.so.6 ./lib64 \
    	&& cp /lib64/libc.so.6 ./lib64 \
    	&& cp /lib64/libfreebl3.so ./lib64 \
    	&& cp /lib64/libpthread.so.0 ./lib64 \
    	&& cp /lib64/libidn.so.11 ./lib64 \
    	&& cp /lib64/libssh2.so.1 ./lib64 \
    	&& cp /lib64/libssl3.so ./lib64 \
    	&& cp /lib64/libsmime3.so ./lib64 \
    	&& cp /lib64/libnss3.so ./lib64 \
    	&& cp /lib64/libnssutil3.so ./lib64 \
    	&& cp /lib64/libplds4.so ./lib64 \
    	&& cp /lib64/libplc4.so ./lib64 \
    	&& cp /lib64/libnspr4.so ./lib64 \
    	&& cp /lib64/libgssapi_krb5.so.2 ./lib64 \
    	&& cp /lib64/libkrb5.so.3 ./lib64 \
    	&& cp /lib64/libk5crypto.so.3 ./lib64 \
    	&& cp /lib64/libcom_err.so.2 ./lib64 \
    	&& cp /lib64/liblber-2.4.so.2 ./lib64 \
    	&& cp /lib64/libldap-2.4.so.2 ./lib64 \
    	&& cp /lib64/ld-linux-x86-64.so.2 ./lib64 \
    	&& cp /lib64/liblzma.so.5 ./lib64 \
    	&& cp /lib64/libbz2.so.1 ./lib64 \
    	&& cp /lib64/libkrb5support.so.0 ./lib64 \
    	&& cp /lib64/libkeyutils.so.1 ./lib64 \
    	&& cp /lib64/libsasl2.so.3 ./lib64 \
    	&& cp /lib64/libselinux.so.1 ./lib64 \
    	&& cp /lib64/libpcre.so.1 ./lib64 \
    	&& cp /lib64/libnssckbi.so ./lib64 \
    	&& cp /lib64/libstdc++.so.6 ./lib64 \
        && cp /lib64/libgcc_s.so.1 ./lib64 \
    	&& cp -a /lib64/libnss*.so* ./lib64 \
    	&& cp -a /lib64/libsqlite3* ./lib64 \
    	&& cp -a /lib64/libsoftokn3* ./lib64 \
    	&& cp -a /lib64/libfreeblpriv3* ./lib64 \
      && echo `strip /data/apps/php/bin/*  > /dev/null` \
      && strip /data/apps/php/lib/php/extensions/no-debug-non-zts-20180731/*

FROM busybox
MAINTAINER lejianwen <84855512@qq.com>

RUN echo www:x:1000:1000:www:/:/bin/sh >> etc/passwd \
        && echo www:x:1000: >> etc/group
RUN mkdir /lib \
    && ln -s /lib /lib64 \
    && mkdir /data && touch /etc/resolv.conf

COPY --from=php-builder2 /etc/nsswitch.conf /etc/nsswitch.conf
COPY --from=php-builder2 /etc/pki /etc/pki
COPY --from=php-builder2 /rootfs/lib64/* /lib64/
COPY --from=php-builder2 /usr/local/lib/libzip.so.5 /usr/local/lib/
COPY --from=php-builder2 /data/ /data/

RUN ln -s  /data/apps/php/bin/php /bin/php
#RUN mkdir /sbin -p && ln -s  /data/apps/php/sbin/php-fpm /sbin/php-fpm

EXPOSE 9000
CMD ["php", "-v"]