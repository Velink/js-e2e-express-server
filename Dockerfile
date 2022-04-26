FROM alpine:latest

RUN apk update \
    && apk add curl gzip bash git \
    && curl https://releases.hashicorp.com/packer/1.6.2/packer_1.6.2_linux_amd64.zip | gunzip > /bin/ \
    && chmod 0770 /bin/packer