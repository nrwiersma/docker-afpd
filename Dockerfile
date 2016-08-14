FROM alpine:3.4

MAINTAINER Nicholas Wiersma <nick@wiersma.co.za>

ENV NETATALK 3.1.8

RUN apk add --no-cache acl-dev build-base cracklib-dev db-dev krb5-dev libevent-dev tdb-dev \
    && wget -O- http://ufpr.dl.sourceforge.net/project/netatalk/netatalk/$NETATALK/netatalk-$NETATALK.tar.gz | tar -zx \
    && cd netatalk-$NETATALK \
    && ./configure --enable-debug --enable-krbV-uam --with-cracklib \
    && make \
    && make install \
    && apk del build-base \
    && cd .. \
    && rm -rf netatalk-$NETATALK

RUN apk add --no-cache avahi

COPY afpd.conf /etc/netatalk/afpd.conf
COPY afpd.service /etc/avahi/services/afpd.service
COPY entrypoint.sh /entrypoint.sh

VOLUME /media

EXPOSE 548
EXPOSE 5353/udp

ENTRYPOINT ["/entrypoint.sh"]
