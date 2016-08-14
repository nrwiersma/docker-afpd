#!/bin/sh

if [ -r /users ];
then
    while IFS=":" read line val
    do
        adduser -D -H $line
    done < /users

    chpasswd --encrypted < /users
fi

sed -i '/rlimit-nproc/d' /etc/avahi/avahi-daemon.conf
avahi-daemon -D

exec netatalk -d
