.DEFAULT_GOAL := help

.PHONY: \
	help \
	base-wire base-install install-base \
	dev-wire dev-install install-dev \
	install-etc \
	local-wire \
	devcontainer-wire devcontainer-install

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*## "; printf "Available targets:\n"} /^[a-zA-Z0-9_.-]+:.*## / {printf "  %-14s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

base-wire: ## Wire dotfiles to the home directory
	# Wire zsh
	@ln -sf "$(CURDIR)/base/zsh.rc" "$${HOME}/.zshrc"; \
	ln -sfn "$(CURDIR)/base/zshrc.d" "$${HOME}/.zshrc.d"
	# Wire git
	@mkdir -p "$${HOME}/.config"; \
	ln -sfn "$(CURDIR)/base/git" "$${HOME}/.config/git"
	# Wire tmux
	@ln -sf "$(CURDIR)/base/tmux.conf" "$${HOME}/.tmux.conf"
	# Wire vim
	@ln -sf "$(CURDIR)/base/vim.rc" "$${HOME}/.vimrc"; \
	ln -sfn "$(CURDIR)/base/vim" "$${HOME}/.vim"

base-install: ## Download and install base tools
	# Download vim plugins
	@git submodule update --init --recursive
	# Try install Homebrew
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "💬 Homebrew is not installed, installing..."; \
		NONINTERACTIVE=1 /usr/bin/env bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		echo "🟢 Homebrew has been installed."; \
	else \
		echo "⏭️ Homebrew is already installed, skipped."; \
	fi
	# Install brew packages
	@brew bundle --file "$(CURDIR)/base/Brewfile"
	# Try install Oh My Zsh
	@if [ ! -d "$${HOME}/.oh-my-zsh" ]; then \
		echo "💬 Oh My Zsh is not installed, installing..."; \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
		echo "🟢 Oh My Zsh has been installed."; \
	else \
		echo "⏭️ Oh My Zsh is already installed, skipped."; \
	fi

install-base: base-wire base-install

dev-wire: # Wire dotfiles to the home directory
	# VSCode
	@if [ "$$(uname -s)" = "Darwin" ]; then \
		VSCODE_USER_DIR="$${HOME}/Library/Application Support/Code/User"; \
	else \
		echo "🔴 Unsupported OS for VSCode configuration, aborted."; \
		exit 1; \
	fi; \
	mkdir -p "$${VSCODE_USER_DIR}"; \
	ln -sf "$(CURDIR)/dev/vscode/settings.json" "$${VSCODE_USER_DIR}/settings.json"

dev-install: # Download and install dev tools
	# Install brew packages
	@brew bundle --file "$(CURDIR)/dev/Brewfile"

install-dev: dev-wire dev-install

install-etc:
	# Install brew packages
	@brew bundle --file "$(CURDIR)/etc/Brewfile"

local-wire: ## Wire dotfiles to current directory
	# DevContainers
	@mkdir -p ./.devcontainer; \
	ln -sf "$${DOTFILES}/dev/devcontainer/devcontainer.json" ./.devcontainer/devcontainer.json; \
	ln -sf "$${DOTFILES}/dev/devcontainer/docker-compose.yaml" ./.devcontainer/docker-compose.yaml; \
	ln -sf "$${DOTFILES}/dev/devcontainer/Dockerfile" ./.devcontainer/Dockerfile

local-install: ## Download and install current directory tools
	# Try install tools via mise
	@mise install
	# Try install pnpm packages
	@ mise exec -c 'if command -v pnpm >/dev/null 2>&1; then \
		echo "💬 pnpm is installed, installing dependencies..."; \
		pnpm install --frozen-lockfile --config.confirmModulesPurge=false; \
		echo "🟢 pnpm dependencies have been installed."; \
	else \
		echo "⏭️ pnpm is not installed, skipped."; \
	fi'

# 	  pnpm config -g set store-dir /shared/pnpm-store; \
# 		pnpm config -g set virtual-store-dir /local/node_modules/.pnpm; \
# 		pnpm config -g set modules-dir /local/node_modules/; \
