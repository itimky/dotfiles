.DEFAULT_GOAL := help

.PHONY: \
	help \
	submodules \
	wire-zsh \
	wire-git \
	wire-tmux \
	wire-vim \
	brew-install \
	brew-bundle \
	install \
	wire-vscode \
	wire-devcontainer \
	brew-bundle-dev \
	install-dev \
	brew-bundle-etc \
	install-etc \
	devcontainer-init \
	devcontainer-install

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*## "; printf "Available targets:\n"} /^[a-zA-Z0-9_.-]+:.*## / {printf "  %-14s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

submodules: ## Initialize and update git submodules
	git submodule update --init --recursive

wire-zsh:
	@ln -sf "$(CURDIR)/zshrc" "$${HOME}/.zshrc"
	@ln -sfn "$(CURDIR)/zshrc.d" "$${HOME}/.zshrc.d"

wire-git:
	@mkdir -p "$${HOME}/.config"
	@ln -sfn "$(CURDIR)/git" "$${HOME}/.config/git"

wire-tmux:
	@ln -sf "$(CURDIR)/tmux.conf" "$${HOME}/.tmux.conf"

wire-vim:
	@ln -sf "$(CURDIR)/vim/vimrc" "$${HOME}/.vimrc"
	@ln -sfn "$(CURDIR)/vim" "$${HOME}/.vim"

brew-install: ## Install Homebrew if missing
	@if [ ! -x "$(command -v brew)" ]; then \
		/usr/bin/env bash -c "yes | $$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "Homebrew is already installed, skipping."; \
	fi

brew-bundle:
	@brew bundle

install: submodules brew-install brew-bundle
	@if [ ! -d "$${HOME}/.oh-my-zsh" ]; then \
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
	else \
		echo "Oh My Zsh is already installed, skipping."; \
	fi
	$(MAKE) wire-zsh wire-git wire-tmux wire-vim

wire-vscode:
	@if [ "$$(uname -s)" = "Darwin" ]; then \
		VSCODE_USER_DIR="$${HOME}/Library/Application Support/Code/User"; \
	elif [ -n "$${XDG_CONFIG_HOME}" ]; then \
		VSCODE_USER_DIR="$${XDG_CONFIG_HOME}/Code/User"; \
	else \
		VSCODE_USER_DIR="$${HOME}/.config/Code/User"; \
	fi; \
	mkdir -p "$${VSCODE_USER_DIR}"; \
	ln -sf "$(CURDIR)/vscode/settings.json" "$${VSCODE_USER_DIR}/settings.json"

wire-devcontainer:
	@mkdir -p ./.devcontainer
	@ln -sf "$${DOTFILES}/devcontainer/devcontainer.json" ./.devcontainer/devcontainer.json
	@ln -sf "$${DOTFILES}/devcontainer/docker-compose.yaml" ./.devcontainer/docker-compose.yaml
	@ln -sf "$${DOTFILES}/devcontainer/Dockerfile" ./.devcontainer/Dockerfile

brew-bundle-dev:
	@brew bundle --file Brewfile.dev

install-dev: wire-vscode wire-devcontainer brew-bundle-dev

brew-bundle-etc:
	@brew bundle --file Brewfile.etc

install-etc: brew-bundle-etc

devcontainer-init: wire-zsh wire-git wire-vim
	@mise install

devcontainer-install:
	@mise exec -c 'if command -v pnpm >/dev/null 2>&1; then \
	  pnpm config -g set store-dir /shared/pnpm-store; \
		pnpm config -g set virtual-store-dir /local/node_modules/.pnpm; \
		pnpm config -g set modules-dir /local/node_modules/; \
		pnpm install --frozen-lockfile --config.confirmModulesPurge=false; \
	else \
		echo "skipping pnpm install"; \
	fi'
