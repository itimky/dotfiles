FROM mcr.microsoft.com/devcontainers/base:ubuntu
RUN apt update && apt upgrade -y
RUN chsh -s $(which zsh) vscode
WORKDIR /home/vscode
USER vscode
RUN NONINTERACTIVE=1 \
  /usr/bin/env bash -c \
  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV PATH=${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${PATH}
RUN mkdir -p .cache .local/share .codex
WORKDIR /mnt/workspace
