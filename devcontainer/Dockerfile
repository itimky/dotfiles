FROM mcr.microsoft.com/devcontainers/base:noble
RUN apt-get update && yes | unminimize && apt-get upgrade -y
RUN chsh -s $(which zsh) vscode
WORKDIR /home/vscode
USER vscode
RUN NONINTERACTIVE=1 \
  /usr/bin/env bash -c \
  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV PATH=${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${PATH}
RUN mkdir -p .cache .local/share
RUN mkdir -p .codex .local/share/codex && \
  touch .local/share/codex/auth.json .local/share/codex/config.toml && \
  ln -srf .local/share/codex/auth.json .codex/auth.json && \
  ln -srf .local/share/codex/config.toml .codex/config.toml
WORKDIR /mnt/workspace
