FROM mcr.microsoft.com/devcontainers/base:noble
RUN apt-get update && yes | unminimize && apt-get upgrade -y
RUN chsh -s $(which zsh) vscode
USER vscode
RUN NONINTERACTIVE=1 \
  /usr/bin/env bash -c \
  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV PATH=${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${PATH}
RUN mkdir -p \
  /home/vscode/.cache \
  /home/vscode/.codex \
  /home/vscode/.codex-shared \
  /home/vscode/.local
RUN touch /home/vscode/.codex-shared/auth.json && \
  ln -sf /home/vscode/.codex-shared/auth.json /home/vscode/.codex/auth.json
