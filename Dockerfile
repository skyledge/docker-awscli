FROM node:10-alpine 

ENV AWS_CLI_VERSION 1.16.41
ENV DOCKER_VERSION 18.06.1

RUN echo "http://dl-2.alpinelinux.org/alpine/v3.8/main" > /etc/apk/repositories
RUN echo "http://dl-2.alpinelinux.org/alpine/v3.8/community" >> /etc/apk/repositories

# install chromium
RUN apk -U --no-cache \
    --allow-untrusted add \
    zlib-dev \
    chromium \
    xvfb \
    wait4ports \
    xorg-server \
    dbus \
    ttf-freefont \
    grep \ 
    udev
    


ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/

RUN apk --no-cache update && apk --no-cache add wget && \
    wget -q https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz -O /tmp/docker.tar.gz && \
    tar -xzf /tmp/docker.tar.gz -C /tmp/ && \
    cp /tmp/docker/docker* /usr/local/bin && \
    chmod +x /usr/local/bin/docker*

RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools bash tar ca-certificates less jq && \
    pip --no-cache-dir install awscli==${AWS_CLI_VERSION} && \
    rm -rf /var/cache/apk/* && \
    wget https://raw.githubusercontent.com/silinternational/ecs-deploy/master/ecs-deploy -O /usr/local/bin/ecs-deploy && \
    chmod +x /usr/local/bin/ecs-deploy

SHELL ["/bin/bash", "-c"]

WORKDIR /data
