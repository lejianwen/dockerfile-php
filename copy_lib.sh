#!/bin/sh

# ldd php
echo 'sh run'
mkdir -p lib64 \
  && cp /lib64/libcrypt.so.1 ./lib64 \
	&& cp /lib64/libz.so.1 ./lib64 \
	&& cp /lib64/libresolv.so.2 ./lib64 \
	&& cp /lib64/librt.so.1 ./lib64 \
	&& cp /lib64/libpng15.so.15 ./lib64 \
	&& cp /lib64/libjpeg.so.62 ./lib64 \
	&& cp /lib64/libwebp.so.4 ./lib64 \
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
  && cp /lib64/libonig.so.5 ./lib64 \
	&& cp -a /lib64/libnss*.so* ./lib64 \
	&& cp -a /lib64/libsqlite3* ./lib64 \
	&& cp -a /lib64/libsoftokn3* ./lib64 \
	&& cp -a /lib64/libfreeblpriv3* ./lib64 \
	&& cp /lib64/libzip.so.5 ./lib64 \
  && echo `strip /data/apps/php/bin/*  > /dev/null` \
  && strip /data/apps/php/sbin/php-fpm \
  && strip /data/apps/php/lib/php/extensions/no-debug-non-zts-20190902/* \
  && sed -i 's/user = nobody/user = www/' /data/apps/php/etc/php-fpm.d/www.conf \
  && sed -i 's/group = nobody/group = www/' /data/apps/php/etc/php-fpm.d/www.conf