# Docker afpd container

A Docker container serving AppleTalk Filing Protocol with mDNS server

## Configuring Shares

Shares can be configured by mounting an afpd.conf file into ```/usr/local/etc/afp.conf```.

Documentation for the afpd.conf can be found in [Netatalk's documentation](http://netatalk.sourceforge.net/3.0/htmldocs/afp.conf.5.html).

## Ports

Ports 548 and 5353/udp are exposed and should be mounted to the host ports

## Example

```
    docker run --detach
               -v /path/to/local/afpd.conf:/usr/local/etc/afp.conf
               -p 548:548
               -p 5353:5353/udp
               afpd:latest
```
