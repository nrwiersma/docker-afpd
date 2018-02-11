FROM alpine:3.4

MAINTAINER Nicholas Wiersma <nick@wiersma.co.za>

ENV NETATALK 3.1.11

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

COPY afpd.conf /etc/netatalk/afpd.conf
COPY entrypoint.sh /entrypoint.sh

VOLUME /media

EXPOSE 548

ENTRYPOINT ["/entrypoint.sh"]
