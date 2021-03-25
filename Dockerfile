FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.13

LABEL maintainer="Adam Beardwood"

RUN apk add --update --no-cache curl composer php7-dom php7-gd php7-tokenizer

RUN \
 echo "**** install grav ****" && \
 mkdir -p /app/grav && \
 cd /app/grav && \
 composer create-project getgrav/grav /app/grav && \
 cd /app/grav && \
 bin/gpm install admin

COPY root/ /

EXPOSE 80

VOLUME /config