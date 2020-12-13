FROM 0x01be/base as build

WORKDIR /gaw
ARG REVISION=main
RUN apk add --no-cache --virtual gaw-build-dependencies \
    git \
    build-base \
    autoconf \
    automake \
    gtk+3.0-dev \
    alsa-lib \
    alsa-lib-dev &&\
    git clone --depth 1 --branch ${REVISION} https://github.com/StefanSchippers/xschem-gaw.git /gaw &&\
    ./configure --prefix=/opt/gaw &&\
    make
RUN make install

FROM 0x01be/base

COPY --from=build /opt/gaw/ /opt/gaw/

