PHONY_TARGETS := $(shell sed -n 's/^\([A-Za-z0-9][A-Za-z0-9_.-]*\):.*/\1/p' $(MAKEFILE_LIST) | sort -u)
.PHONY: $(PHONY_TARGETS)

try-add-git-worktree:
	# Try add git worktree
	@set -e; \
	trap 'code=$$?; if [ $$code -ne 0 ]; then echo "⚠️ Failed to add Git worktree, skipped."; exit 0; fi' EXIT; \
	if [ ! -e "$${DOTGIT}" ]; then \
		echo "⏭️ $${DOTGIT} is not available, skipped."; \
	elif git --git-dir="$${DOTGIT}" rev-parse --verify --quiet "refs/heads/$${WORKTREE_BRANCH}" >/dev/null; then \
		echo "💬 Adding Git worktree at $${WORKTREE_DIR} for branch $${WORKTREE_BRANCH}..."; \
		mkdir -p "$${WORKTREE_DIR}"; \
		git --git-dir="$${DOTGIT}" worktree add -f "$${WORKTREE_DIR}" "$${WORKTREE_BRANCH}"; \
		echo "🟢 Git worktree has been added."; \
	else \
		echo "💬 Creating branch $${WORKTREE_BRANCH} and adding Git worktree at $${WORKTREE_DIR}..."; \
		mkdir -p "$${WORKTREE_DIR}"; \
		git --git-dir="$${DOTGIT}" worktree add -b "$${WORKTREE_BRANCH}" "$${WORKTREE_DIR}"; \
		echo "🟢 Git worktree has been added."; \
	fi

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
		try-add-git-worktree \
		try-install-worktree-tools \
		try-install-worktree-deps

wire-local:
	@mkdir -p ./.devcontainer
	@ln -sf "$${DOTFILES}/devcontainer/devcontainer.json" "./.devcontainer/devcontainer.json"
	@ln -sf "$${DOTFILES}/devcontainer/docker-compose.yaml" "./.devcontainer/docker-compose.yaml"
	@ln -sf "$${DOTFILES}/devcontainer/Dockerfile" "./.devcontainer/Dockerfile"
	@ln -sf "$${DOTFILES}/devcontainer/Makefile" "./.devcontainer/Makefile"
	@ln -sf "$${DOTFILES}/devcontainer/README.md" "./.devcontainer/README.md"
