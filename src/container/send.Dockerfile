FROM alpine:3.16

RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update
RUN apk add --no-cache openssl dumb-init ca-certificates wget wput@testing
RUN update-ca-certificates

WORKDIR /xbox

COPY /util/docker-init.sh /opt/docker-init.sh
COPY /util/send.sh /opt/send.sh

ENV DOCKERIZE=true

ENTRYPOINT ["/opt/docker-init.sh"]
CMD ["/opt/send.sh"]
