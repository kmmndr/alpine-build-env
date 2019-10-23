FROM alpine:edge

RUN apk add --no-cache \
  alpine-sdk \
  coreutils \
  cmake \
  vim

RUN adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D builder \
 && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY init-alpine-build-env.sh /usr/local/bin/init-alpine-build-env
RUN chmod +x /usr/local/bin/init-alpine-build-env

RUN mkdir -p /var/cache/distfiles
RUN chmod 777 /var/cache/distfiles

VOLUME ["/home/builder"]
WORKDIR /home/builder

USER builder
