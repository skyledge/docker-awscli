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

Pull the latest image from Docker Hub:

```bash
docker pull skyledge/docker-awscli:latest
```

Or pin to a specific version:

```bash
docker pull skyledge/docker-awscli:<version>
```

Run AWS CLI commands:

```bash
docker run --rm -v ~/.aws:/root/.aws skyledge/docker-awscli:latest aws s3 ls
```

## Supported Platforms

Images are built for the following platforms:

- `linux/amd64`
- `linux/arm64`

## Publishing a New Release

Builds and pushes are fully automated via the **Build and Push Multi-Arch Docker Image** GitHub Actions workflow. A new image is built and pushed to Docker Hub automatically whenever a tag is pushed to the repository.

### Steps to Release

1. **Create and push a new tag**

   ```bash
   git tag <version>
   git push origin <version>
   ```

2. **GitHub Actions takes over**

   The workflow will:
   - Build the image for both `linux/amd64` and `linux/arm64` using Docker Buildx and QEMU
   - Push the image to Docker Hub tagged as both `skyledge/docker-awscli:<version>` and `skyledge/docker-awscli:latest`

### Required Repository Secrets

The following secrets must be configured in the repository's **Settings → Secrets and variables → Actions**:

| Secret | Description |
|---|---|
| `DOCKERHUB_USERNAME` | Docker Hub username |
| `DOCKERHUB_TOKEN` | Docker Hub Personal Access Token with **Write** permissions |

> **Note:** To create a Personal Access Token, go to Docker Hub → Account Settings → Security → Personal Access Tokens.

## Building Locally

To build the image locally for testing:

```bash
docker buildx build --platform linux/amd64,linux/arm64 \
  -t skyledge/docker-awscli:<version> \
  .
```

To build and load a single-platform image for immediate local use:

```bash
docker buildx build --platform linux/amd64 \
  -t skyledge/docker-awscli:<version> \
  --load .
```
