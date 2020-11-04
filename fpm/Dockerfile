FROM centos:7
MAINTAINER lejianwen <84855512@qq.com>

WORKDIR /data

ADD buildBefore.sh /data/buildBefore.sh
RUN chmod +x /data/*.sh
RUN /data/buildBefore.sh

ADD buildNoCli.sh /data/buildNoCli.sh
RUN chmod +x /data/*.sh
RUN /data/buildNoCli.sh

EXPOSE 9000
CMD ["php-fpm", "--nodaemonize", "--fpm-config", "/data/apps/php/etc/php-fpm.conf"]
