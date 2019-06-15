# Trojan Docker

Dockerfile for building a trojan docker image.

## Build Trojan Docker Image

1. Clone this repository.

```bash
$ git clone https://github.com/trojan-gfw/trojan-docker.git
```

2. Build docker image with `docker build`.

```bash
$ docker build -t trojan .
```

If you want to change the version, use the `--build-arg` option

```bash
$ docker build -t trojan --build-arg VERSION=v1.12.2 .
```

## Pull Trojan Docker Image

Alternatively, you can pull the pre-built trojan image from docker hub.

```bash
$ docker pull trojangfw/trojan
```

Create trojan container from image.

**The `$HOST_CONFIG_DIR` directory should contain the `trojan.json` configuration file
and other configuration files (eg: certificate file)**

```bash
$ docker run -dt --name trojan -v $HOST_CONFIG_DIR:/config
```

View container logs

```bash
$ docker logs -f trojan
```
