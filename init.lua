require('adoyle-neovim-config').setup {
	config = {
		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/').
			-- Otherwise, remove this option.
			github = 'https://ghproxy.com/',
		},
	},

	configFn = function(config)
		-- This user config will override default config. Below config is an example just for my personal usage.

		local builtins = require('null-ls').builtins
		local codeActions = builtins.code_actions
		local diagnostics = builtins.diagnostics
		local formatting = builtins.formatting

		return {
			vim = {
				opt = {
					colorcolumn = { 81, 101 }, -- highlight columns. See ":h 'cc'"
				},
			},

			treesitter = {
				prefer_git = false,
				ensure_installed = {}, -- A list of parser names, or "all",
				ignore_install = { -- List of parsers to ignore installing (for "all")
					-- LuaFormatter off
					'agda', 'rasi', 'r', 'd', 'v', 'slint', 'c_sharp', 'phpdoc', 'ruby', 'php', 'jsonc',
					-- LuaFormatter on
				},
			},

			nullLS = {
				-- Available null-ls sources list
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
				-- How to config null-ls sources:
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
				sources = {
					codeActions.eslint_d,
					codeActions.shellcheck,

					diagnostics.eslint_d,
					-- diagnostics.shellcheck, -- It is duplicated with bashls

					-- Formatters run in the order in which you register them.
					formatting.eslint_d.with {
						-- eslint_d is a daemon so that it will cache eslint and eslint-plugins.
						-- You may need to run "eslint_d restart" or kill eslint_d process to update cache while in trouble.
						-- See https://github.com/mantoni/eslint_d.js#what-if-eslint-or-a-plugin-is-updated
						-- The eslint_d filepath is ~/.local/share/nvim/mason/bin/eslint_d
						prefer_local = 'node_modules/.bin',
					},

					-- formatting.prettierd.with {
					--     disabled_filetypes = { 'markdown' },
					--     prefer_local = 'node_modules/.bin',
					-- },

					-- formatting.shfmt, -- not good
					formatting.lua_format,
				},
			},

			lsp = {
				-- a list of all tools you want to ensure are installed upon start;
				-- Package Index: https://github.com/williamboman/mason.nvim/blob/main/PACKAGES.md
				ensureInstalled = {
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
			},
		}
	end,

	noPlugins = false, -- If true, all builtin and user-defined plugins will not be loaded

	-- Add your plugins or override plugin default options.
	-- More examples at ./lua/adoyle-neovim-config/plugins.lua
	plugins = { --
		{ 'profiling', disable = true },
		{ 'zk', disable = false },
		{ 'node', disable = false },
		{ 'curl', disable = false },
		{ 'funny', disable = false },
		{ 'latex', disable = false },
		{ 'calendar', disable = false },
		{ 'todo', disable = false },
		{ 'zen', disable = false },
		{ 'olimorris/onedarkpro.nvim', disable = false },
		{ 'nvim-treesitter/nvim-treesitter-context', disable = true },
	},
}
