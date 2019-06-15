FROM alpine:3.9

# If you want to change the version, use the `--build-arg VERSION=xxxx` option
ARG VERSION='v1.12.2'

ENV VERSION ${VERSION}

RUN set -ex \
    # Update system components to keep the latest version
    && apk upgrade \
    # Install build dependencies
    && apk add --virtual .build-deps \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
        git \
    # Get trojan source code and checkout the specified branch
    && git clone --branch=${VERSION} https://github.com/trojan-gfw/trojan.git \
    # Build and install
    && (cd trojan && cmake . && make -j $(nproc) && strip -s trojan \
    && mv trojan /usr/local/bin) \
    # Add runtime dependencies
    && apk add --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c \
    # Clean up
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* trojan

EXPOSE 443

# Users need to mount `/config` to customize the configuration file and certs
VOLUME /config
WORKDIR /config

# CMD command allow users to easily overwrite it
CMD ["trojan", "trojan.json"]
