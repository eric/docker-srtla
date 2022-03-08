FROM debian:buster as build

RUN apt-get clean && apt-get update && \
    apt-get install -y make git build-essential 

# Create appuser
ENV USER=appuser
ENV UID=10001

# See https://stackoverflow.com/a/55757473/12429735
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"


RUN mkdir -p /src && \
  cd /src && \
  git clone https://github.com/BELABOX/srtla.git && \
  cd srtla && \
  make

RUN mkdir /tmp/tmp && chmod 1777 /tmp/tmp

############################
# STEP 2 build a small image
############################
FROM debian:buster

RUN apt-get update && \
    apt-get install -y jq && \
    apt-get clean && \
    mkdir /app

# Copy our static executable
COPY --from=build /src/srtla/srtla_send /src/srtla/srtla_rec /app/
#COPY --from=build /src/srtla/srtla_rec /app/

COPY srtla /app/

VOLUME /config

ENTRYPOINT ["/app/srtla"]
