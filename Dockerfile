FROM node:22-alpine3.20

ENV DOCKER_VERSION=27.0.1 \
    CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

# Configure Alpine repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.20/main" > /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.20/community" >> /etc/apk/repositories

# Install all dependencies in a single layer to reduce image size
RUN apk -U --no-cache --allow-untrusted add \
    bash \
    ca-certificates \
    chromium \
    dbus \
    git \
    grep \
    jq \
    less \
    python3 \
    py3-pip \
    py3-setuptools \
    tar \
    ttf-freefont \
    udev \
    wget \
    xorg-server \
    xvfb \
    wait4ports \
    zlib-dev \
    && rm -rf /var/cache/apk/*

# Install Docker CLI
RUN wget -q https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz -O /tmp/docker.tar.gz && \
    tar -xzf /tmp/docker.tar.gz -C /tmp/ && \
    cp /tmp/docker/docker* /usr/local/bin && \
    chmod +x /usr/local/bin/docker* && \
    rm -rf /tmp/docker*

# Install AWS CLI and ecs-deploy
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir awscli && \
    ln -s /opt/venv/bin/aws /usr/local/bin/aws && \
    wget -q https://raw.githubusercontent.com/silinternational/ecs-deploy/master/ecs-deploy -O /usr/local/bin/ecs-deploy && \
    chmod +x /usr/local/bin/ecs-deploy

SHELL ["/bin/bash", "-c"]

WORKDIR /data
