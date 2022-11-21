# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.238.0/containers/alpine/.devcontainer/base.Dockerfile


# [Choice] Alpine version: 3.15, 3.14, 3.13
ARG VARIANT="3.15"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-alpine-${VARIANT}

# Terraform
RUN apk update \
    && apk add --no-cache terraform

# tflint
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# gcloud
RUN apk --update add openjdk7-jre python3
RUN curl -o /opt/gcloud-cli.tgz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-391.0.0-linux-x86_64.tar.gz ;\
    cd /opt/ ; tar -zxf gcloud-cli.tgz ;\
    ./google-cloud-sdk/install.sh -q
ENV PATH="/opt/google-cloud-sdk/bin:$PATH"

# Golang
RUN apk add go go-doc
# RUN /usr/bin/go get -u -v golang.org/x/tools/cmd/gopls 2>&1
#RUN gcloud components install app-engine-java kubectl
