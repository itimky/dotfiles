PHONY_TARGETS := $(shell sed -n 's/^\([A-Za-z0-9][A-Za-z0-9_.-]*\):.*/\1/p' $(MAKEFILE_LIST) | sort -u)
.PHONY: $(PHONY_TARGETS)

install:
	@$(MAKE) -C "$${DOTFILES}" install

wire-local:
	@mkdir -p ./.devcontainer
	@cp "$${DOTFILES}/devcontainer/devcontainer.json" "./.devcontainer/devcontainer.json"
	@ln -sf "$${DOTFILES}/devcontainer/docker-compose.yaml" "./.devcontainer/docker-compose.yaml"
	@ln -sf "$${DOTFILES}/devcontainer/Dockerfile" "./.devcontainer/Dockerfile"
	@ln -sf "$${DOTFILES}/devcontainer/Makefile" "./.devcontainer/Makefile"
	@ln -sf "$${DOTFILES}/devcontainer/README.md" "./.devcontainer/README.md"
