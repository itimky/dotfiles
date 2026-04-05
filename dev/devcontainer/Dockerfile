FROM mcr.microsoft.com/devcontainers/base:noble
RUN chsh -s $(which zsh) vscode
USER vscode
RUN curl https://mise.run | sh
RUN NONINTERACTIVE=1 \
  /usr/bin/env bash -c \
  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV PATH=${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${PATH}
RUN mkdir -p \
  ~/.cache \
  ~/.codex \
  ~/.local \
  /home/linuxbrew/.linuxbrew 
