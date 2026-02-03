# Docker AWS CLI

A lightweight Docker image for running AWS CLI commands in CI/CD pipelines. Built on Alpine Linux with Node.js and Google Chrome support.

## Features

- **AWS CLI** - Latest version installed via Python virtual environment
- **Docker CLI** - Version 27.0.1 for Docker-in-Docker operations
- **Node.js 22** - Built on official Node.js Alpine base image
- **Google Chrome** - Chromium browser for headless operations
- **ECS Deploy** - Automated ECS deployment tool included
- **Development Tools** - Bash, Git, jq, and other essential utilities

## Quick Start

Pull the image from Docker Hub:

```bash
docker pull skyledge/docker-awscli:<version>
```

Run AWS CLI commands:

```bash
docker run --rm -v ~/.aws:/root/.aws skyledge/docker-awscli:<version> aws s3 ls
```

## Building the Image

### Prerequisites

- Docker with buildx support
- Docker Hub account with write permissions

### Build Steps

1. **Login to Docker Hub**

   ```bash
   docker login -u <username>
   ```

   > **Note:** Use a Personal Access Token (PAT) from Docker Hub → Account Settings → Security → Personal Access Tokens. Ensure the token has **Write** permissions.

2. **Build the Image**

   Build for linux/amd64 platform:

   ```bash
   docker buildx build --platform linux/amd64 -t docker-awscli:<version> .
   ```

3. **Tag the Image**

   ```bash
   docker image tag docker-awscli:<version> skyledge/docker-awscli:<version>
   ```

4. **Push to Docker Hub**

   ```bash
   docker push skyledge/docker-awscli:<version>
   ```

### Multi-Platform Build (Optional)

To build for multiple platforms:

```bash
docker buildx build --platform linux/amd64,linux/arm64 \
  -t skyledge/docker-awscli:<version> \
  --push .
```
