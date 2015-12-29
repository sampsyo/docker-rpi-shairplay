FROM dduportal/rpi-alpine
MAINTAINER Adrian Sampson <adrian@radbox.org>

# Install the build dependencies.
RUN apk add --update \
        build-base \
        autoconf \
        automake \
        libtool \
        git \
        libltdl \
        libao-dev \
        avahi-dev \
        avahi-compat-libdns_sd && \
    rm -rf /var/cache/apk/*

# Clone and build the package.
RUN git clone https://github.com/juhovh/shairplay.git
RUN cd shairplay && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

# Put the AirPort encryption key in the home directory.
RUN cp shairplay/airport.key airport.key

# TODO Remove the build dependencies. Delete the source.

# The AirPlay ports.
EXPOSE 3689/tcp
EXPOSE 5000-5005/tcp
EXPOSE 6000-6005/udp

CMD ["shairplay", "--ao_devicename=default", "--apname=Raspberry Pi"]
