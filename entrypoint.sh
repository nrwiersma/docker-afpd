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

exec netatalk -d
