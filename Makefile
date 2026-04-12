PHONY_TARGETS := $(shell sed -n 's/^\([A-Za-z0-9][A-Za-z0-9_.-]*\):.*/\1/p' $(MAKEFILE_LIST) | sort -u)
.PHONY: $(PHONY_TARGETS)
.DEFAULT_GOAL := help

help:
	@printf "Available targets:\n"
	@printf "  %s\n" $(PHONY_TARGETS)

download-vim-plugins:
	# Download vim plugins
	@git submodule update --init --recursive

download-homebrew:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "💬 Homebrew is not installed, installing..."; \
		NONINTERACTIVE=1 /usr/bin/env bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		echo "🟢 Homebrew has been installed."; \
	else \
		echo "⏭️ Homebrew is already installed, skipped."; \
	fi

download-oh-my-zsh:
	# Try install Oh My Zsh
	@if [ ! -d "$${HOME}/.oh-my-zsh" ]; then \
		echo "💬 Oh My Zsh is not installed, installing..."; \
		KEEP_ZSHRC=yes sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
		echo "🟢 Oh My Zsh has been installed."; \
	else \
		echo "⏭️ Oh My Zsh is already installed, skipped."; \
	fi

brew-bundle:
	# Install brew packages
	brew bundle --file "$(CURDIR)/src/Brewfile"

wire-git:
	# Wire git
	@mkdir -p "$${HOME}/.config"; \
	ln -sfn "$(CURDIR)/src/git" "$${HOME}/.config/git"

wire-zsh:
	# Wire zsh
	@ln -sf "$(CURDIR)/src/zshenv" "$${HOME}/.zshenv"; \
	ln -sf "$(CURDIR)/src/zshrc" "$${HOME}/.zshrc"

wire-vim:
	# Wire vim
	@ln -sf "$(CURDIR)/src/vim/vimrc" "$${HOME}/.vimrc"; \
	ln -sfn "$(CURDIR)/src/vim" "$${HOME}/.vim"

install: \
	wire-git \
	download-homebrew \
	brew-bundle \
	download-oh-my-zsh \
	wire-zsh \
	download-vim-plugins \
	wire-vim

brew-bundle-client:
	brew bundle --file "$(CURDIR)/src/Brewfile.client"

brew-bundle-gnu:
	brew bundle --file "$(CURDIR)/src/Brewfile.gnu"

brew-bundle-workstation:
	brew bundle --file "$(CURDIR)/src/Brewfile.workstation"

brew-bundle-xyz:
	brew bundle --file "$(CURDIR)/src/Brewfile.xyz"

wire-vscode:
	VSCODE_USER_DIR="$${HOME}/Library/Application Support/Code/User"; \
	@mkdir -p "$${VSCODE_USER_DIR}"; \
	ln -sf "$(CURDIR)/src/vscode/settings.json" "$${VSCODE_USER_DIR}/settings.json"

install-all: \
	install \
	brew-bundle-client \
	brew-bundle-workstation \
	wire-vscode \
	brew-bundle-xyz
