.PHONY: help check install install-lua-ls install-clangd install-typos-lsp install-basedpyright install-dockerls install-jsonls install-marksman install-azure-pipelines-ls install-cmake-ls install-starlark-lsp

INSTALL_DIR := $(HOME)/.local/bin
LSP_DATA_DIR := $(HOME)/.local/share/nvim-lsp

help:
	@echo "Available targets:"
	@echo "  make check          - Check if package managers are installed"
	@echo "  make install        - Install all LSPs"
	@echo "  make install-<lsp>  - Install specific LSP"
	@echo ""
	@echo "LSPs:"
	@echo "  - lua-ls (lua_ls)"
	@echo "  - clangd"
	@echo "  - typos-lsp"
	@echo "  - basedpyright"
	@echo "  - dockerls"
	@echo "  - jsonls"
	@echo "  - marksman"
	@echo "  - azure-pipelines-ls"
	@echo "  - cmake-ls"
	@echo "  - starlark-lsp"

check:
	@echo "Checking package managers..."
	@command -v pipx >/dev/null 2>&1 || (echo "❌ pipx not found" && exit 1)
	@command -v npm >/dev/null 2>&1 || (echo "❌ npm not found" && exit 1)
	@command -v cargo >/dev/null 2>&1 || (echo "❌ cargo not found" && exit 1)
	@command -v wget >/dev/null 2>&1 || (echo "❌ wget not found" && exit 1)
	@command -v unzip >/dev/null 2>&1 || (echo "❌ unzip not found" && exit 1)
	@echo "✓ All package managers found"

install: check install-lua-ls install-clangd install-typos-lsp install-basedpyright install-dockerls install-jsonls install-marksman install-azure-pipelines-ls install-cmake-ls install-starlark-lsp
	@echo "✓ All LSPs installed"

# Lua Language Server (GitHub release)
install-lua-ls:
	@echo "Installing lua-language-server..."
	@mkdir -p $(LSP_DATA_DIR)/lua-ls
	@cd $(LSP_DATA_DIR)/lua-ls && \
		wget -q --show-progress https://github.com/LuaLS/lua-language-server/releases/latest/download/lua-language-server-$$(uname -s | tr '[:upper:]' '[:lower:]')-x64.tar.gz -O lua-ls.tar.gz && \
		tar -xzf lua-ls.tar.gz && \
		rm lua-ls.tar.gz
	@mkdir -p $(INSTALL_DIR)
	@ln -sf $(LSP_DATA_DIR)/lua-ls/bin/lua-language-server $(INSTALL_DIR)/lua-language-server
	@echo "✓ lua-language-server installed"

# Clangd (GitHub release)
install-clangd:
	@echo "Installing clangd..."
	@mkdir -p $(LSP_DATA_DIR)/clangd
	@cd $(LSP_DATA_DIR)/clangd && \
		wget -q --show-progress https://github.com/clangd/clangd/releases/latest/download/clangd-linux-$$(uname -m).zip -O clangd.zip && \
		unzip -q -o clangd.zip && \
		rm clangd.zip
	@mkdir -p $(INSTALL_DIR)
	@ln -sf $(LSP_DATA_DIR)/clangd/clangd_*/bin/clangd $(INSTALL_DIR)/clangd
	@echo "✓ clangd installed"

# Typos LSP (cargo)
install-typos-lsp:
	@echo "Installing typos-lsp..."
	@cargo install typos-lsp --locked
	@echo "✓ typos-lsp installed"

# BasedPyright (pipx)
install-basedpyright:
	@echo "Installing basedpyright..."
	@pipx install basedpyright
	@echo "✓ basedpyright installed"

# Docker Language Server (npm)
install-dockerls:
	@echo "Installing dockerfile-language-server-nodejs..."
	@npm install -g dockerfile-language-server-nodejs
	@echo "✓ dockerfile-language-server-nodejs installed"

# JSON Language Server (npm)
install-jsonls:
	@echo "Installing vscode-langservers-extracted..."
	@npm install -g vscode-langservers-extracted
	@echo "✓ vscode-langservers-extracted installed"

# Marksman (GitHub release)
install-marksman:
	@echo "Installing marksman..."
	@mkdir -p $(LSP_DATA_DIR)/marksman
	@cd $(LSP_DATA_DIR)/marksman && \
		wget -q --show-progress https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64 -O marksman && \
		chmod +x marksman
	@mkdir -p $(INSTALL_DIR)
	@ln -sf $(LSP_DATA_DIR)/marksman/marksman $(INSTALL_DIR)/marksman
	@echo "✓ marksman installed"

# Azure Pipelines Language Server (npm)
install-azure-pipelines-ls:
	@echo "Installing azure-pipelines-language-server..."
	@npm install -g azure-pipelines-language-server
	@echo "✓ azure-pipelines-language-server installed"

# CMake Language Server (pipx)
install-cmake-ls:
	@echo "Installing cmake-language-server..."
	@pipx install cmake-language-server
	@echo "✓ cmake-language-server installed"

# Starlark LSP (cargo)
install-starlark-lsp:
	@echo "Installing starlark-rust..."
	@cargo install --git https://github.com/facebookexperimental/starlark-rust starlark --locked
	@echo "✓ starlark installed"
