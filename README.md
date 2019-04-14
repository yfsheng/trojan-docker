# Trojan Docker

Dockerfile for building a trojan docker image.

## Build Trojan Docker Image

1. Clone this repository.

```bash
$ git clone https://github.com/trojan-gfw/trojan-docker.git
```

2. Build docker image with `docker build`.

```bash
$ docker build -t="trojan" .
```

## Pull Trojan Docker Image

Alternatively, you can pull the pre-built trojan image from docker hub.

```bash
$ docker pull trojangfw/trojan
```

Create trojan container from image.

```bash
$ docker run -it --name="trojan" -v $HOST_CONFIG_PATH:/config -p 443:443 trojangfw/trojan
```
