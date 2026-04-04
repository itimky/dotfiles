FROM mcr.microsoft.com/devcontainers/base:noble
RUN chsh -s $(which zsh) vscode
USER vscode
RUN curl https://mise.run | sh
RUN NONINTERACTIVE=1 \
  /usr/bin/env bash -c \
  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN mkdir -p /home/linuxbrew/.linuxbrew ~/.cache ~/.codex
ENV HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV PATH=${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${PATH}
