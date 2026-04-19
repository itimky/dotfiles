PHONY_TARGETS := $(shell sed -n 's/^\([A-Za-z0-9][A-Za-z0-9_.-]*\):.*/\1/p' $(MAKEFILE_LIST) | sort -u)
.PHONY: $(PHONY_TARGETS)

try-install-worktree-tools:
	# Try install tools via mise
	@cd "$${WORKTREE_DIR}" && mise install

try-install-worktree-deps:
	# Try install pnpm packages
	@cd "$${WORKTREE_DIR}" && mise exec -c 'if command -v pnpm >/dev/null 2>&1; then \
		echo "💬 pnpm is installed, installing dependencies..."; \
		pnpm config -g set store-dir ~/.local/share/pnpm; \
		pnpm install --frozen-lockfile --config.confirmModulesPurge=false; \
		echo "🟢 pnpm dependencies have been installed."; \
	else \
		echo "⏭️ pnpm is not installed, skipped."; \
	fi'

reinstall-dotfiles:
	@$(MAKE) -C "$${DOTFILES}" install

install: \
		reinstall-dotfiles \
		try-install-worktree-tools \
		try-install-worktree-deps

wire-local:
	@mkdir -p ./.devcontainer
	@ln -sf "$${DOTFILES}/devcontainer/devcontainer.json" "./.devcontainer/devcontainer.json"
	@ln -sf "$${DOTFILES}/devcontainer/docker-compose.yaml" "./.devcontainer/docker-compose.yaml"
	@ln -sf "$${DOTFILES}/devcontainer/Dockerfile" "./.devcontainer/Dockerfile"
	@ln -sf "$${DOTFILES}/devcontainer/Makefile" "./.devcontainer/Makefile"
	@ln -sf "$${DOTFILES}/devcontainer/README.md" "./.devcontainer/README.md"
