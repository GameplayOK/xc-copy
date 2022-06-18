FROM alpine:3.16

RUN apk update
RUN apk add --no-cache openssl dumb-init ca-certificates wget
RUN update-ca-certificates

WORKDIR /xbox

COPY /util/docker-init.sh /opt/docker-init.sh
COPY /util/receive.sh /opt/receive.sh

ENV DOCKERIZE=true

ENTRYPOINT ["/opt/docker-init.sh"]
CMD ["/opt/receive.sh"]
