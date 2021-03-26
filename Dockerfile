FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.13

LABEL maintainer="Adam Beardwood"

ARG GRAV_RELEASE

RUN apk add --update --no-cache curl composer php7-dom php7-gd php7-tokenizer php7-opcache php7-pecl-apcu php7-pecl-yaml unzip

RUN \
 echo "**** install grav ****" && \
 if [ -z ${GRAV_RELEASE+x} ]; then \
	GRAV_RELEASE=$(curl -sX GET "https://api.github.com/repos/getgrav/grav/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 curl -o \
 /tmp/grav.zip -L \
	"https://getgrav.org/download/core/grav-admin/${GRAV_RELEASE}" && \
 mkdir -p \
	/grav && \
 unzip -q \
 	/tmp/grav.zip -d /app && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

COPY root/ /

EXPOSE 80

VOLUME /config