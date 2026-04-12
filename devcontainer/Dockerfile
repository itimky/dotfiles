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
RUN mkdir -p .cache .local
RUN mkdir -p .codex .codex-shared && \
  touch .codex-shared/auth.json .codex-shared/config.toml && \
  ln -srf .codex-shared/auth.json .codex/auth.json && \
  ln -srf .codex-shared/config.toml .codex/config.toml
