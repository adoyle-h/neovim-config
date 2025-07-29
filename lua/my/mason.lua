return {
	-- a list of all tools you want to ensure are installed upon start;
	-- Package Index: https://github.com/williamboman/mason.nvim/blob/main/PACKAGES.md
	ensure_installed = {
		-- { 'golangci-lint', version = '1.47.0' }, -- you can pin a tool to a particular version
		-- { 'bash-language-server', auto_update = true }, -- you can turn off/on auto_update per tool
		'actionlint', -- github action
		'alex',
		'bash-debug-adapter',
		'bash-language-server',
		'dockerfile-language-server',
		'editorconfig-checker',
		'hadolint', -- Dockerfile linter, validate inline bash, written in Haskell
		'html-lsp',
		'lua-language-server',
		'luaformatter', -- #formatter Create .lua-format file in project, https://github.com/Koihik/LuaFormatter#style-configure-fil
		'marksman', -- markdown
		'shellcheck',
		-- 'shfmt', -- #Formatter A shell formatter (sh/bash/mksh)
		'taplo', -- #LSP TOML
		'texlab', -- LTeX Language Server
		'vim-language-server',
		'write-good',
		'yaml-language-server', -- #LSP
		'yamlfmt', -- #Formatter
	},
}
