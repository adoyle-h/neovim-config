return {
	-- a list of all tools you want to ensure are installed upon start;
	-- Package Index: https://github.com/williamboman/mason.nvim/blob/main/PACKAGES.md
	ensure_installed = {
		-- { 'golangci-lint', version = '1.47.0' }, -- you can pin a tool to a particular version
		-- { 'bash-language-server', auto_update = true }, -- you can turn off/on auto_update per tool
		'actionlint', -- github action
		'alex',
		'ansible-language-server',
		'arduino-language-server',
		'bash-debug-adapter',
		'bash-language-server',
		'buf',
		'buf-language-server',
		-- 'chrome-debug-adapter',
		'css-lsp',
		'delve', -- #DAP Delve is a debugger for the Go programming language.
		'dockerfile-language-server',
		'dot-language-server',
		'editorconfig-checker',
		'elixir-ls',
		-- 'erlang-ls',
		'esbonio', -- #LSP for Sphinx-doc
		'rstcheck', -- #Linter for reStructuredText
		'eslint_d', -- #null-ls
		'fixjson', -- #Formatter A JSON file fixer/formatter for humans using (relaxed) JSON5
		'gopls',
		'hadolint', -- Dockerfile linter, validate inline bash, written in Haskell
		'html-lsp',
		'json-lsp', -- #LSP
		'lelwel', -- rust
		'lemminx', -- XML Language Server
		'lua-language-server',
		'luaformatter', -- #formatter Create .lua-format file in project, https://github.com/Koihik/LuaFormatter#style-configure-fil
		'marksman', -- markdown
		'prettierd', -- #null-ls
		'pyright',
		'python-lsp-server',
		'shellcheck',
		-- 'shfmt', -- #Formatter A shell formatter (sh/bash/mksh)
		'sqlfluff', -- #Linter SQLFluff is a dialect-flexible and configurable SQL linter
		'sqls', -- #LSP
		'taplo', -- #LSP TOML
		'texlab', -- LTeX Language Server
		'typescript-language-server',
		'vim-language-server',
		'write-good',
		'yaml-language-server', -- #LSP
		'yamlfmt', -- #Formatter
	},
}
