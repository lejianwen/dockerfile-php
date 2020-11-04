FROM centos:7
MAINTAINER lejianwen <84855512@qq.com>

WORKDIR /data

ADD buildBefore.sh /data/buildBefore.sh
RUN chmod +x /data/*.sh
RUN /data/buildBefore.sh

ADD build.sh /data/build.sh
RUN chmod +x /data/*.sh
RUN /data/build.sh

EXPOSE 9000
CMD ["php", "-v"]
