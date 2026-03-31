.DEFAULT_GOAL := help

.PHONY: help submodules wire brew-install brew-bundle install

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*## "; printf "Available targets:\n"} /^[a-zA-Z0-9_.-]+:.*## / {printf "  %-14s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

submodules: ## Initialize and update git submodules
	git submodule update --init --recursive

wire: ## Create symlinks and local config directories
	@ln -sf "$(CURDIR)/zshrc" "$$HOME/.zshrc"
	@ln -sfn "$(CURDIR)/zshrc.d" "$$HOME/.zshrc.d"
	@ln -sf "$(CURDIR)/vim/vimrc" "$$HOME/.vimrc"
	@ln -sfn "$(CURDIR)/vim" "$$HOME/.vim"
	@ln -sf "$(CURDIR)/gitconfig" "$$HOME/.gitconfig"
	@ln -sf "$(CURDIR)/gitignore" "$$HOME/.gitignore"
	@ln -sf "$(CURDIR)/tmux.conf" "$$HOME/.tmux.conf"
	@if [ "$$(uname -s)" = "Darwin" ]; then \
		VSCODE_USER_DIR="$$HOME/Library/Application Support/Code/User"; \
	elif [ -n "$$XDG_CONFIG_HOME" ]; then \
		VSCODE_USER_DIR="$$XDG_CONFIG_HOME/Code/User"; \
	else \
		VSCODE_USER_DIR="$$HOME/.config/Code/User"; \
	fi; \
	mkdir -p "$$VSCODE_USER_DIR"; \
	ln -sf "$(CURDIR)/vscode/settings.json" "$$VSCODE_USER_DIR/settings.json"

brew-install: ## Install Homebrew if missing
	@command -v brew >/dev/null 2>&1 || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew-bundle: ## Install packages from Brewfile
	brew bundle

install: submodules wire brew-install brew-bundle ## Run full bootstrap flow
