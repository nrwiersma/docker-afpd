FROM alpine:3.4

MAINTAINER Nicholas Wiersma <nick@wiersma.co.za>

ENV NETATALK 3.1.10

RUN apk add --no-cache acl-dev build-base cracklib-dev db-dev krb5-dev \
                       libevent-dev tdb-dev openssl-dev openldap-dev \
                       libgcrypt-dev linux-pam-dev avahi-dev \
    && wget -O- http://ufpr.dl.sourceforge.net/project/netatalk/netatalk/$NETATALK/netatalk-$NETATALK.tar.gz | tar -zx \
    && cd netatalk-$NETATALK \
    && ./configure --enable-krbV-uam --with-cracklib --enable-quota --with-tdb --with-pam-confdir=/etc/pam.d \
    && make \
    && make install \
    && cd .. \
    && rm -rf netatalk-$NETATALK \
    && apk del acl-dev build-base cracklib-dev db-dev krb5-dev \
               libevent-dev tdb-dev openssl-dev openldap-dev \
               libgcrypt-dev linux-pam-dev avahi-dev \
    && apk add --no-cache acl cracklib db krb5 \
               libevent tdb openssl openldap \
               libgcrypt linux-pam

RUN apk add --no-cache avahi

COPY afpd.conf /etc/netatalk/afpd.conf
COPY afpd.service /etc/avahi/services/afpd.service
COPY entrypoint.sh /entrypoint.sh

VOLUME /media

EXPOSE 548
EXPOSE 5353/udp

ENTRYPOINT ["/entrypoint.sh"]
