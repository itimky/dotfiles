try-install-workspace-tools:
	# Try install tools via mise
	@mise install

try-install-workspace-deps:
	# Try install pnpm packages
	@ mise exec -c 'if command -v pnpm >/dev/null 2>&1; then \
		echo "💬 pnpm is installed, installing dependencies..."; \
		pnpm config -g set store-dir ~/.local/share/pnpm; \
		pnpm install --frozen-lockfile --config.confirmModulesPurge=false; \
		echo "🟢 pnpm dependencies have been installed."; \
	else \
		echo "⏭️ pnpm is not installed, skipped."; \
	fi'

install-workspace: \
	try-install-workspace-tools \
	try-install-workspace-deps

# 	  pnpm config -g set store-dir /shared/pnpm-store; \
# 		pnpm config -g set virtual-store-dir /local/node_modules/.pnpm; \
# 		pnpm config -g set modules-dir /local/node_modules/; \
