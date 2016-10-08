#!/bin/sh

if [ -r /users ];
then
    while IFS=":" read username name
    do
        adduser -D -H $username

        if [ ! -d "/home/$username" ]; then
            mkdir /home/$username
        fi

        chown $username:$username /home/$username

        sed -i "s/$username:\(.*\):Linux User/$username:\1:$name/g" /etc/passwd
    done < /names

    chpasswd --encrypted < /users
fi

sed -i '/rlimit-nproc/d' /etc/avahi/avahi-daemon.conf
sed -i 's/#enable-dbus=yes/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf
avahi-daemon -D

exec netatalk -d

nrwiersma:x:1000:1000:Nicholas Wiersma,,,:/home/nrwiersma:
nrwiersma:x:1000:1000:Nicholas Wiersma,,,:/home/nrwiersma:
