local config = require('adoyle-neovim-config.config').config
local util = require('adoyle-neovim-config.util')

local M_NLSP = {
	'tamago324/nlsp-settings.nvim',
	requires = {},
	config = function()
		require('nlspsettings').setup {
			-- For global settings,
			config_home = vim.fn.stdpath('config') .. '/lsp-settings',
			-- For local project, put settings file in {project}/.lsp-settings/{server_name}.yaml.
			local_settings_dir = '.nlsp-settings',
			local_settings_root_markers_fallback = { '.git' },
			append_default_schemas = true,
			loader = 'yaml',
		}
	end,
}

-- null-ls is an attempt to bridge that gap and simplify the process of creating,
-- sharing, and setting up LSP sources using pure Lua.
local M_NullLS = {
	'jose-elias-alvarez/null-ls.nvim',
	requires = { 'jayp0521/mason-null-ls.nvim' },
	config = function()
		local null_ls = require('null-ls')
		local nullLSConfig = config.lsp.nullLS
		local sources = nullLSConfig.sources(null_ls.builtins) or {}

		local has_gitsigns = pcall(require, 'gitsigns')
		if has_gitsigns then table.insert(sources, null_ls.builtins.code_actions.gitsigns) end

		local lspFormat = require('lsp-format')

		local opts = util.merge(nullLSConfig, {
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method('textDocument/formatting') then
					-- If null-ls client is a formatter, register the client to lsp-format.
					-- So we can use lsp-format to trigger null-ls formatter when execute ":w".
					lspFormat.on_attach(client, bufnr)
				end
			end,
		})

		null_ls.setup(opts)

		require('mason-null-ls').setup { automatic_installation = false }

		vim.api.nvim_create_autocmd('User', {
			pattern = 'MasonNullLsUpdateCompleted',
			callback = function()
				vim.schedule(function()
					print 'mason-null-ls has finished'
				end)
			end,
		})
	end,
}

local M_GotoPreview = {
	'rmagatti/goto-preview',
	config = function()
		require('goto-preview').setup {
			width = 100, -- Width of the floating window
			height = 15, -- Height of the floating window
			border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' }, -- Border characters of the floating window
			default_mappings = false, -- Bind default mappings
			debug = false, -- Print debug information
			opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
			resizing_mappings = false, -- Binds arrow keys to resizing the floating window.

			post_open_hook = function() -- A function taking two arguments, a buffer and a window to be ran as a hook.
				vim.wo.cc = '';
			end,

			-- references = { -- Configure the telescope UI for slowing the references cycling window.
			--   telescope = telescope.themes.get_dropdown({ hide_preview = false })
			-- };

			-- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
			focus_on_open = true, -- Focus the floating window when opening it.
			dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
			force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
			bufhidden = 'wipe', -- the bufhidden option to set on the floating window. See :h bufhidden
		}
	end,

	commands = function()
		return {
			{ 'CleanPreviews', require('goto-preview').close_all_win, { desc = 'close all preview windows' } },
		}
	end,

	keymaps = function()
		local preview = require('goto-preview')
		return {
			{ 'n', 'gd', preview.goto_preview_definition, { desc = 'goto_preview_definition' } },
			{ 'n', 'gt', preview.goto_preview_type_definition, { desc = 'goto_preview_type_definition' } },
			{ 'n', 'gi', preview.goto_preview_implementation, { desc = 'goto_preview_implementation' } },
			{ 'n', 'gr', preview.goto_preview_references, { desc = 'goto_preview_references' } },
		}
	end,
}

local M_MasonToolInstaller = {
	'WhoIsSethDaniel/mason-tool-installer.nvim',

	defaultConfig = {
		{ 'lsp' },
		{
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

			-- set a delay (in ms) before the installation starts. This is only
			-- effective if run_on_start is set to true.
			-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
			startDelay = 2000, -- 2 second delay

		},
	},

	config = function()
		require('mason-tool-installer').setup {
			ensure_installed = config.lsp.ensureInstalled,
			auto_update = config.lsp.autoUpdate,
			run_on_start = config.lsp.runOnStart,
			start_delay = config.lsp.startDelay,
		}

		vim.api.nvim_create_autocmd('User', {
			pattern = 'MasonToolsUpdateCompleted',
			callback = function()
				vim.schedule(function()
					print 'mason-tool-installer has finished'
				end)
			end,
		})
	end,
}

local M_Mason = {
	'williamboman/mason.nvim', -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
	defaultConfig = {
		{ 'lsp' },
		{
			-- Whether to automatically check for new versions when opening the :Mason window.
			checkOutdatedPackagesOnOpen = false,
		},
	},

	config = function()
		local symbolMap = config.symbolMap

		require('mason').setup {
			ui = {
				-- Whether to automatically check for new versions when opening the :Mason window.
				check_outdated_packages_on_open = config.lsp.checkOutdatedPackagesOnOpen,

				-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
				border = 'single',

				icons = {
					-- The list icon to use for installed packages.
					package_installed = symbolMap.INSTALLED,
					-- The list icon to use for packages that are installing, or queued for installation.
					package_pending = symbolMap.PENDING,
					-- The list icon to use for packages that are not installed.
					package_uninstalled = symbolMap.UNINSTALLED,
				},

				keymaps = {
					-- Keymap to expand a package
					toggle_package_expand = '<Tab>',
					-- Keymap to install the package under the current cursor position
					install_package = '<CR>',
					-- Keymap to reinstall/update the package under the current cursor position
					update_package = 'u',
					-- Keymap to check for new version for the package under the current cursor position
					check_package_version = 'c',
					-- Keymap to update all installed packages
					update_all_packages = 'U',
					-- Keymap to check which installed packages are outdated
					check_outdated_packages = 'C',
					-- Keymap to uninstall a package
					uninstall_package = 'x',
					-- Keymap to cancel a package installation
					cancel_installation = '<C-c>',
					-- Keymap to apply language filter
					apply_language_filter = '<M-f>',
				},
			},

			-- The directory in which to install packages.
			install_root_dir = vim.fn.stdpath('data') .. '/mason',

			pip = {
				-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
				-- and is not recommended.
				--
				-- Example: { "--proxy", "https://proxyserver" }
				install_args = {},
			},

			-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when

			-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
			-- packages that are requested to be installed will be put in a queue.
			max_concurrent_installers = 4,

			github = {
				-- The template URL to use when downloading assets from GitHub.
				-- The placeholders are the following (in order):
				-- 1. The repository (e.g. "rust-lang/rust-analyzer")
				-- 2. The release version (e.g. "v0.3.0")
				-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
				download_url_template = util.proxyGithub('https://github.com/%s/releases/download/%s/%s'),
			},
		}

	end,
}

local M = {
	nil,

	requires = {
		M_Mason,
		M_MasonToolInstaller,
		M_NullLS,
		M_GotoPreview,
		M_NLSP,

		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
		'lukas-reineke/lsp-format.nvim',
		{
			'j-hui/fidget.nvim',
			desc = 'nvim-lsp loading progress',
			config = function()
				require('fidget').setup {}
			end,
		},
		{
			-- This plugin is not needed after https://github.com/neovim/neovim/pull/20198
			'antoinemadec/FixCursorHold.nvim',
			config = function()
				vim.g.cursorhold_updatetime = 100
			end,
		},
	},
}

local function configDiagnostic()
	vim.diagnostic.config {
		virtual_text = false,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			-- Show source in diagnostics
			source = 'always', -- Or 'if_many'
		},
	}

	-- Show line diagnostics automatically in hover window
	-- The CursorHold autocmd is triggered when updatetime. Use https://github.com/antoinemadec/FixCursorHold.nvim to fix it
	vim.api.nvim_create_autocmd('CursorHold', {
		callback = function()
			vim.diagnostic.open_float(nil, {
				width = 100,
				max_height = 20,
				focusable = false,
				close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
				border = config.lsp.diagnosticBorder,
				source = 'always',
				prefix = ' ',
				scope = 'cursor',
			})
		end,
	})
end

M.defaultConfig = {
	{ 'lsp' },
	{
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

		diagnosticBorder = { -- See the border property of ":h nvim_open_win"
			{ '╭', 'DiagnosticBorder' },
			{ '─', 'DiagnosticBorder' },
			{ '╮', 'DiagnosticBorder' },
			{ '│', 'DiagnosticBorder' },
			{ '╯', 'DiagnosticBorder' },
			{ '─', 'DiagnosticBorder' },
			{ '╰', 'DiagnosticBorder' },
			{ '│', 'DiagnosticBorder' },
		},

		-- diagnosticBorder = {
		--   { '╔', 'DiagnosticBorder' },
		--   { '═', 'DiagnosticBorder' },
		--   { '╗', 'DiagnosticBorder' },
		--   { '║', 'DiagnosticBorder' },
		--   { '╝', 'DiagnosticBorder' },
		--   { '═', 'DiagnosticBorder' },
		--   { '╚', 'DiagnosticBorder' },
		--   { '║', 'DiagnosticBorder' },
		-- },

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
	},
}

function M.config()
	configDiagnostic()

	local lspFormat = require('lsp-format')
	lspFormat.setup(config.lsp.format)

	local has_aerial, aerial = pcall(require, 'aerial')
	local has_navic, navic = pcall(require, 'nvim-navic')

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		if has_aerial then aerial.on_attach(client, bufnr) end
		if has_navic then navic.attach(client, bufnr) end

		lspFormat.on_attach(client, bufnr)
	end

	local masonLspconfig = require('mason-lspconfig')
	masonLspconfig.setup { automatic_installation = false }

	-- It only list LSP packages. Not includes DAP/Linter/Formatter packages and null-ls.
	local servers = masonLspconfig.get_installed_servers()
	local lspconfig = require('lspconfig')
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
		                                                                 .make_client_capabilities())
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	for _, name in pairs(servers) do
		local opts = config.lsp.setup[name] or {}
		if type(opts) == 'function' then opts = opts(lspconfig) or {} end

		opts = util.merge(opts, {
			capabilities = capabilities,
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 150, -- This is default in neovim 0.7+
			},
		})

		lspconfig[name].setup(opts)
	end

	-- set default border
	local border = config.lsp.defaultBorder
	require('lspconfig.ui.windows').default_options.border = border -- This line maybe not work
	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help,
		{ border = border })

end

M.signs = function()
	local symbolMap = config.symbolMap
	local map = {
		Error = symbolMap.ERROR,
		Warn = symbolMap.WARN,
		Hint = symbolMap.HINT,
		Info = symbolMap.INFO,
	}

	local signs = {}

	for type, icon in pairs(map) do
		local hl = 'DiagnosticSign' .. type
		table.insert(signs, { hl, { text = icon, texthl = hl, numhl = hl } })
	end

	return signs
end

M.keymaps = {
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions

	{ 'n', '<M-m>', ':Mason<CR>', { silent = true } },

	{
		'n',
		'[d',
		function()
			vim.diagnostic.goto_prev()
		end,
		{ silent = true, desc = ':h vim.diagnostic.goto_prev' },
	},

	{
		'n',
		']d',
		function()
			vim.diagnostic.goto_next()
		end,
		{ silent = true, desc = ':h vim.diagnostic.goto_next' },
	},

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	{
		'n',
		'gD',
		function()
			vim.lsp.buf.declaration()
		end,
		{ silent = true, desc = ':h vim.lsp.buf.declaration' },
	},

	{
		'n',
		'gR',
		function()
			vim.lsp.buf.rename()
		end,
		{ silent = true, desc = ':h vim.lsp.buf.rename' },
	},

	{
		'n',
		'gc',
		function()
			vim.lsp.buf.code_action()
		end,
		{ silent = true, desc = ':h vim.lsp.buf.code_action' },
	},

	{
		'n',
		'gh',
		function()
			vim.lsp.buf.hover()
		end,
		{ silent = true, desc = ':h vim.lsp.buf.hover' },
	},

	{
		'n',
		'gs',
		function()
			vim.lsp.buf.signature_help()
		end,
		{ silent = true, desc = ':h vim.lsp.buf.signature_help' },
	},

	{ 'n', 'gF', vim.lsp.buf.format, { silent = true, desc = ':h vim.lsp.buf.format' } },
}

return M
