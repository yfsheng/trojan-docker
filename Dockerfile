FROM alpine:3.9
WORKDIR /app
RUN apk add --no-cache --virtual .build-deps \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
        git \
    && git clone --branch=v1.12.0 https://github.com/trojan-gfw/trojan.git repo \
    && cd repo \
    && cmake . \
    && make \
    && strip -s trojan \
    && mv trojan .. \
    && cd .. \
    && rm -rf repo \
    && apk del .build-deps \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c
WORKDIR /config
EXPOSE 443
CMD ["/app/trojan", "config.json"]
