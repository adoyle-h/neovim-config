local util = require('adoyle-neovim-config.util')

util.ensurePkg {
	url = 'https://github.com/adoyle-h/my-vim-snippets',
	dist = util.configPath('snippets'),
}

local function nullLSConfig()
	local has_null, nullLS = pcall(require, 'null-ls')
	if not has_null then return {} end

	local builtins = nullLS.builtins
	local codeActions = builtins.code_actions
	local diagnostics = builtins.diagnostics
	local formatting = builtins.formatting

	return {
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
	}
end

local function treesitterConfig()
	return {
		prefer_git = false,

		-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
		ensure_installed = { -- A list of parser names, or "all",
			-- LuaFormatter off
			'bash', 'beancount', 'bibtex', 'blueprint', 'c', 'clojure', 'cmake', 'comment', 'commonlisp',
			'cpp', 'css', 'cuda', 'dart', 'diff', 'dockerfile', 'dot', 'eex', 'elixir', 'elm', 'elvish',
			'erlang', 'fennel', 'fish', 'git_rebase', 'gitattributes', 'gitignore', 'glsl', 'go',
			'godot_resource', 'gomod', 'gowork', 'graphql', 'haskell', 'hcl', 'help', 'hjson', 'hlsl',
			'html', 'http', 'java', 'javascript', 'jsdoc', 'json', 'json5', 'jsonnet', 'julia', 'kotlin',
			'latex', 'llvm', 'lua', 'make', 'markdown', 'markdown_inline', 'perl', 'pioasm', 'proto',
			'python', 'racket', 'regex', 'rst', 'rust', 'scheme', 'scss', 'solidity', 'sparql', 'sql',
			'svelte', 'swift', 'teal', 'toml', 'tsx', 'twig', 'typescript', 'verilog', 'vim', 'vue',
			'wgsl', 'yaml',
			-- LuaFormatter on
		},

		ignore_install = { -- List of parsers to ignore installing (for "all")
			-- LuaFormatter off
			'agda', 'astro', 'c_sharp', 'cooklang', 'd', 'devicetree', 'embedded_template', 'jsonc',
			'foam', 'fortran', 'fusion', 'gdscript', 'gleam', 'glimmer', 'hack', 'heex', 'hocon',
			'lalrpop', 'ledger', 'm68k', 'menhir', 'meson', 'nickel', 'ninja', 'nix', 'ocaml',
			'ocaml_interface', 'ocamllex', 'pascal', 'php', 'phpdoc', 'prisma', 'pug', 'ql', 'qmljs',
			'r', 'rasi', 'rego', 'rnoweb', 'ruby', 'slint', 'supercollider', 'surface', 'sxhkdrc',
			'tiger', 'tlaplus', 'todotxt', 'turtle', 'v', 'vala', 'yang', 'zig'
			-- LuaFormatter on
		},
	}
end

local function masonInstallerConfig()
	return {
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
	}
end

---@diagnostic disable-next-line: unused-local
local function myPlugins(builtin, config)
	return {
		{ 'profiling', disable = true },
		{ 'zk', disable = false },
		{ 'node', disable = false },
		{ 'curl', disable = false },
		{ 'latex', disable = false },
		{ 'calendar', disable = false },
		{ 'todo', disable = false },
		{ 'zen', disable = false },
		{ 'onedarkpro', disable = false },
		{ 'noice', disable = true },
		{ 'nvim-treesitter/nvim-treesitter-context', disable = true },
		{ 'dmitmel/cmp-cmdline-history', disable = true },
	}
end

require('adoyle-neovim-config').setup {
	config = {
		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com'. Otherwise, remove this option.
			github = 'https://ghproxy.com',
		},

		-- pluginManager = { use = 'packer' }, -- 'vim-plug' or 'packer'
	},

	---@diagnostic disable-next-line: unused-local
	configFn = function(config)
		-- This user config will override default config. Below config is an example just for my personal usage.
		return {
			vim = {
				opt = {
					colorcolumn = { 81, 101 }, -- highlight columns. See ":h 'cc'"
				},
			},

			treesitter = treesitterConfig(),
			nullLS = nullLSConfig(),
			['mason-installer'] = masonInstallerConfig(),
		}
	end,

	-- @param [opts.onlyPlugins] {string[]|nil}
	-- It's useful for debug. Defaults to nil.
	-- If set empty table, all builtin and user-defined plugins are disabled.
	-- If set non-empty table, only these plugins are not disabled.
	-- onlyPlugins = { 'alpha', 'adoyle-h/alpha-nvim' },

	-- Add your plugins or override plugin default options.
	-- More examples at ./lua/adoyle-neovim-config/plugins.lua
	plugins = myPlugins,
}
