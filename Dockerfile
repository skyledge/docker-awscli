FROM alpine:3.8 

ENV AWS_CLI_VERSION 1.16.41

RUN apk --no-cache update && \
    apk --no-cache add bash && \
    apk --no-cache add python py-pip py-setuptools ca-certificates less && \
    pip --no-cache-dir install awscli==${AWS_CLI_VERSION} && \
    rm -rf /var/cache/apk/*

SHELL ["/bin/bash", "-c"]

WORKDIR /data
