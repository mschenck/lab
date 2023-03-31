FROM        centos:7
MAINTAINER  Michael Schenck <mschenck@gmail.com>

ENV         DDBASEURL http://downloads.sourceforge.net/project/ddclient/ddclient
ENV         DDVERSION 3.8.3

RUN         yum -y install wget bzip2 perl
RUN         wget ${DDBASEURL}/ddclient-${DDVERSION}.tar.bz2 \
            -O /opt/ddclient-${DDVERSION}.tar.bz2 && \
            cd /opt ; tar -jxf /opt/ddclient-${DDVERSION}.tar.bz2
RUN         mkdir -p /var/cache/ddclient

VOLUME      /etc/ddclient
ENTRYPOINT  /opt/ddclient-${DDVERSION}/ddclient -foreground -daemon 86400 -ssl -retry
