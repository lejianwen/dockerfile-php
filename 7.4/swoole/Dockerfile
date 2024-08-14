FROM lejianwen/php:7.4
MAINTAINER lejianwen <84855512@qq.com>
ENV setuppath /data/apps/php

RUN mkdir /data/src/swoole -p && cd /data/src \
  && wget https://gitee.com/swoole/swoole/repository/archive/v4.5.2?format=tar.gz -O swoole.gz
RUN cd /data/src && tar -zxf swoole.gz -C ./swoole --strip-components 1 && cd swoole \
  && $setuppath/bin/phpize && ./configure --with-php-config=$setuppath/bin/php-config --enable-openssl --enable-http2 && make && make install \
  && echo 'extension = "swoole.so"' >> $setuppath/etc/php.ini \
  && make clean && rm /data/src -rf

EXPOSE 9000
CMD ["php", "-v"]
