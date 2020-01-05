FROM alpine:3.9

ARG VERSION='v1.14.0'
RUN apk update
RUN apk upgrade
RUN apk add --no-cache --virtual .build-deps \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
        git \
        bash \
    && git clone --branch=${VERSION} https://github.com/trojan-gfw/trojan.git \
    && (cd trojan && cmake . && make -j $(nproc) && strip -s trojan \
    && mv trojan /usr/local/bin) \
    && rm -rf trojan \
    && apk del .build-deps \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
CMD /configure.sh
