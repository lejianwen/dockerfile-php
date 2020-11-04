FROM lejianwen/php:7.4 as php-builder
MAINTAINER lejianwen <84855512@qq.com>
WORKDIR /rootfs
COPY copy_lib.sh /data/copy_lib.sh
RUN chmod +x /data/copy_lib.sh
RUN /data/copy_lib.sh
RUN rm /data/*.sh -rf

FROM busybox
MAINTAINER lejianwen <84855512@qq.com>

RUN echo www:x:1000:1000:www:/:/bin/sh >> etc/passwd \
        && echo www:x:1000: >> etc/group
RUN mkdir /lib \
    && ln -s /lib /lib64 \
    && mkdir /data && touch /etc/resolv.conf

COPY --from=php-builder /etc/nsswitch.conf /etc/nsswitch.conf
COPY --from=php-builder /etc/pki /etc/pki
COPY --from=php-builder /rootfs/lib64/* /lib64/
COPY --from=php-builder /data/ /data/

RUN ln -s  /data/apps/php/bin/php /bin/php
RUN mkdir /sbin -p && ln -s  /data/apps/php/sbin/php-fpm /sbin/php-fpm

EXPOSE 9000
CMD ["php", "-v"]

