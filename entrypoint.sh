#!/bin/sh

if [ -r /users ];
then
    while IFS=":" read username pass
    do
        adduser -D -H $username

        if [ ! -d "/home/$username" ]; then
            mkdir /home/$username
        fi

        chown $username:$username /home/$username
    done < /users

    chpasswd --encrypted < /users
fi

sed -i '/rlimit-nproc/d' /etc/avahi/avahi-daemon.conf
sed -i 's/#enable-dbus=yes/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf
avahi-daemon -D

exec netatalk -d
