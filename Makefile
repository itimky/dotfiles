.DEFAULT_GOAL := help
XDG_CONFIG_HOME ?= $(HOME)/.config
PHONY_TARGETS := $(shell sed -n 's/^\([A-Za-z0-9][A-Za-z0-9_.-]*\):.*/\1/p' $(MAKEFILE_LIST) | sort -u)
.PHONY: $(PHONY_TARGETS)

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

create-xdg-config-home:
	@mkdir -p "$(XDG_CONFIG_HOME)"

wire-git: create-xdg-config-home
	# Wire git
	@ln -sfn "$(CURDIR)/src/git" "$(XDG_CONFIG_HOME)/git"

wire-zsh: create-xdg-config-home
	# Wire zsh
	@ln -sfn "$(CURDIR)/src/zsh" "$(XDG_CONFIG_HOME)/zsh"; \
	ln -sf "$(XDG_CONFIG_HOME)/zsh/.zshenv" "$${HOME}/.zshenv"

wire-vim: create-xdg-config-home
	# Wire vim
	@ln -sfn "$(CURDIR)/src/vim" "$(XDG_CONFIG_HOME)/vim"

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
	@VSCODE_USER_DIR="$${HOME}/Library/Application Support/Code/User"; \
	mkdir -p "$${VSCODE_USER_DIR}"; \
	ln -sf "$(CURDIR)/src/vscode/settings.json" "$${VSCODE_USER_DIR}/settings.json"

install-all: \
	install \
	brew-bundle-client \
	brew-bundle-workstation \
	wire-vscode \
	brew-bundle-xyz
