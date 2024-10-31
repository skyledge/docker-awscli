FROM node:22-alpine3.20

#ENV AWS_CLI_VERSION 1.27.136
ENV DOCKER_VERSION 27.0.1

RUN echo "http://dl-2.alpinelinux.org/alpine/v3.20/main" > /etc/apk/repositories
RUN echo "http://dl-2.alpinelinux.org/alpine/v3.20/community" >> /etc/apk/repositories

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

RUN apk --no-cache update && apk --no-cache add wget python3 py3-pip py3-setuptools bash tar ca-certificates less jq

RUN wget -q https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz -O /tmp/docker.tar.gz && \
    tar -xzf /tmp/docker.tar.gz -C /tmp/ && \
    cp /tmp/docker/docker* /usr/local/bin && \
    chmod +x /usr/local/bin/docker*

#ENV VIRTUAL_ENV=/opt/venv
#ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Set up a virtual environment and install awscli there
#RUN python3 -m venv $VIRTUAL_ENV && \
#    . $VIRTUAL_ENV/bin/activate && \
#    pip install --no-cache-dir awscli==${AWS_CLI_VERSION}

RUN wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install


# Install ecs-deploy
RUN wget https://raw.githubusercontent.com/silinternational/ecs-deploy/master/ecs-deploy -O /usr/local/bin/ecs-deploy && \
    chmod +x /usr/local/bin/ecs-deploy

# Clean up
RUN rm -rf /var/cache/apk/*

SHELL ["/bin/bash", "-c"]

WORKDIR /data
