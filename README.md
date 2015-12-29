rpi-shairplay via Docker
========================

This is a Docker container for running [Shairplay][] on a [Raspberry Pi][]. It compiles the tool from source (using the master branch on GitHub).

Build:

    docker build -t rpi-shairport .

Run:

    docker run --device /dev/snd -v /var/run/dbus:/var/run/dbus --net=host --restart=unless-stopped --detach=true -t rpi-shairplay

This container currently uses host networking (`--net=host`) because the AirPlay protocol seems to use dynamic UDP ports.

The container does not include [Avahi][]. It should be run on the host or in another container. To communicate with Avahi, we give this container access to `/var/run/dbus`.

[Avahi]: http://www.avahi.org/
[Shairplay]: https://github.com/juhovh/shairplay
[Raspberry Pi]: http://raspberrypi.org/
