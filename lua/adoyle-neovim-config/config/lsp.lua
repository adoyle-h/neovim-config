return {
	-- a list of all tools you want to ensure are installed upon start;
	-- Package Index: https://github.com/williamboman/mason.nvim/blob/main/PACKAGES.md
	ensureInstalled = {
		'lua-language-server', -- package name
		'luaformatter', -- Create .lua-format file in project, https://github.com/Koihik/LuaFormatter#style-configure-file
		-- { 'golangci-lint', version = '1.47.0' }, -- you can pin a tool to a particular version
		-- { 'bash-language-server', auto_update = true }, -- you can turn off/on auto_update per tool
	},

	-- if set to true this will check each tool for updates. If updates
	-- are available the tool will be updated. This setting does not
	-- affect :MasonToolsUpdate or :MasonToolsInstall.
	autoUpdate = false,

	-- automatically install / update on startup. If set to false nothing
	-- will happen on startup. You can use :MasonToolsInstall or
	-- :MasonToolsUpdate to install tools and check for updates.
	runOnStart = true,

	-- Whether to automatically check for new versions when opening the :Mason window.
	checkOutdatedPackagesOnOpen = false,

	-- set a delay (in ms) before the installation starts. This is only
	-- effective if run_on_start is set to true.
	-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
	startDelay = 2000, -- 2 second delay

	defaultBorder = { -- or 'single' or 'rounded'
		{ '╭', 'LspWindowBorder' },
		{ '─', 'LspWindowBorder' },
		{ '╮', 'LspWindowBorder' },
		{ '│', 'LspWindowBorder' },
		{ '╯', 'LspWindowBorder' },
		{ '─', 'LspWindowBorder' },
		{ '╰', 'LspWindowBorder' },
		{ '│', 'LspWindowBorder' },
	},

	-- Change lsp.setup(opts). Format: {['lsp_name'] = settings}
	-- ":h lspconfig-all" or https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	-- for LSP configs provided by nvim-lspconfig
	setup = {
		-- You can write LSP settings in lua. Or write it to lsp-settings/<lsp_name>.yaml file.
		-- If have the same key, the value in the YAML file will take precedence.

		tsserver = {
			filetypes = { -- limit tsserver only .ts files
				'typescript',
				'typescriptreact',
				'typescript.tsx',
			},
		},

		-- sumneko_lua = {
		--   settings = {
		--     Lua = {
		--       diagnostics = {
		--         globals = {}
		--       }
		--     }
		--   }
		-- },
	},

	-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md#options
	nullLS = {
		debug = false,
		debounce = 150,
		default_timeout = 3000,

		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md#diagnostics_format-string
		diagnostics_format = '[#{c}] #{m}',

		-- should_attach = function(bufnr)
		--   return not vim.api.nvim_buf_get_name(bufnr):match('^gitsigns://')
		-- end,

		-- Available null-ls sources list
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
		-- How to config null-ls sources:
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
		sources = function(builtins)
			return { builtins.completion.spell }
		end,
	},

	format = { -- :h lsp-format
		-- ['null-ls'] = {
		--   sync = true
		-- },

		lua = {
			exclude = { -- exclude is a table of LSP servers that should not format the buffer.
				'sumneko_lua',
			},
		},

		-- ":h lspconfig-all" for LSP configs provided by nvim-lspconfig
		javascript = {
			-- order: (table|nil) List of client names. Formatting is requested from clients
			-- in the following order: first all clients that are not in the order list,
			-- then the remaining clients in the order as they occur in the order list.
			-- Use :LspInfo to see the clients.
			order = { 'null-ls', 'eslint', 'prettier' },
		},
	},
}
