# docker-srtla

*NOTE:* This is a work in progress. There are no published docker images for this yet.

Example `docker-compose.yml` to start the sender:

``` yaml
version: '2'
services:
  srtla-sender:
    build: ../src/docker-srtla
    container_name: srtla-sender
    restart: always
    network_mode: host
    environment:
      - SRTLA_MODE=send
      - SRTLA_LISTEN_PORT=1940
      - SRTLA_SRTLA_HOST=10.0.0.1
      - SRTLA_SRTLA_PORT=1941
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /vols/srtla/config:/config
```

and for the receiver:

``` yaml
version: '2'
services:
  srtla-receiver:
    build: ../src/docker-srtla
    container_name: srtla-receive
    restart: always
    ports:
      - "1941:1941/udp"
    environment:
      - SRTLA_MODE=receive
      - SRTLA_LISTEN_PORT=1941
      - SRTLA_SRT_HOST=10.0.0.2
      - SRTLA_SRT_PORT=1935
    volumes:
      - /etc/localtime:/etc/localtime:ro
```
