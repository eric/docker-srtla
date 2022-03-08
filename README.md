# docker-srtla

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
      - SRTLA_SRTLA_HOST=10.0.0.1
      - SRTLA_SRTLA_PORT=1940

    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /vols/srtla/config:/config
```

