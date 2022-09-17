local config = require('adoyle-neovim-config.config').config
local util = require('adoyle-neovim-config.util')


local M_NLSP = {
	'tamago324/nlsp-settings.nvim',
	disable = true,
	requires = {},
	config = function()
		local nlspsettings = require('nlspsettings')

		nlspsettings.setup {
			-- For global settings,
			config_home = vim.fn.stdpath('config') .. '/lsp-settings',
			-- For local project, put settings file in {project}/.lsp-settings/{server_name}.yaml.
			local_settings_dir = ".nlsp-settings",
			local_settings_root_markers_fallback = { '.git' },
			append_default_schemas = true,
			loader = 'yaml',
		}
	end
}


-- null-ls is an attempt to bridge that gap and simplify the process of creating,
-- sharing, and setting up LSP sources using pure Lua.
local M_NullLS = {
	'jose-elias-alvarez/null-ls.nvim',
	disable = false,
	requires = {
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require('null-ls')
		local sources = config.lsp.nullLS.sources(null_ls.builtins) or {}

		local has_gitsigns = pcall(require, 'gitsigns')
		if has_gitsigns then
			table.insert(sources, null_ls.builtins.code_actions.gitsigns)
		end

		null_ls.setup {
			debounce = 150,
			default_timeout = 3000,
			sources = sources,
		}


		require('mason-null-ls').setup {
			automatic_installation = false,
		}

		require('mason-null-ls').check_install(true)

		vim.api.nvim_create_autocmd('User', {
			pattern = 'MasonNullLsUpdateCompleted',
			callback = function()
				vim.schedule(function() print 'mason-null-ls has finished' end)
			end,
		})
	end
}

local M_GotoPreview = {
	'rmagatti/goto-preview',
	disable = false,
	config = function()
		require('goto-preview').setup {
			width = 100; -- Width of the floating window
			height = 15; -- Height of the floating window
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }; -- Border characters of the floating window
			default_mappings = false; -- Bind default mappings
			debug = false; -- Print debug information
			opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
			resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
			post_open_hook = function()
				vim.wo.cc = '';
			end; -- A function taking two arguments, a buffer and a window to be ran as a hook.

			-- references = { -- Configure the telescope UI for slowing the references cycling window.
			--   telescope = telescope.themes.get_dropdown({ hide_preview = false })
			-- };

			-- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
			focus_on_open = true; -- Focus the floating window when opening it.
			dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
			force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
			bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
		}

		vim.cmd [[
			nnoremap gd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
			nnoremap gt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
			nnoremap gi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
			nnoremap gr <cmd>lua require('goto-preview').goto_preview_references()<CR>
		]]

		vim.api.nvim_create_user_command('CleanPreviews', function()
			require('goto-preview').close_all_win()
		end, {})
	end
}

local M_MasonToolInstaller = {
	'WhoIsSethDaniel/mason-tool-installer.nvim',
	disable = false,
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
				vim.schedule(function() print 'mason-tool-installer has finished' end)
			end,
		})

	end
}

local M_Mason = {
	'williamboman/mason.nvim', -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
	disable = false,
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
					apply_language_filter = '<C-f>',
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


	end
}

local M = {
	nil,
	disable = false,

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
			end
		},

		{
			'antoinemadec/FixCursorHold.nvim',
			config = function() vim.g.cursorhold_updatetime = 100 end,
		},
	},
}

local function configUI()
	local symbolMap = config.symbolMap
	local signs = { Error = symbolMap.ERROR, Warn = symbolMap.WARN, Hint = symbolMap.HINT, Info = symbolMap.INFO }
	for type, icon in pairs(signs) do
		local hl = 'DiagnosticSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
end

local function configKeyMaps()
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local keymap = vim.keymap.set

	keymap('n', '[d', function() vim.diagnostic.goto_prev() end,
		{ noremap = true, silent = true, desc = ':h vim.diagnostic.goto_prev' })
	keymap('n', ']d', function() vim.diagnostic.goto_next() end,
		{ noremap = true, silent = true, desc = ':h vim.diagnostic.goto_next' })
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	keymap('n', 'gD', function() vim.lsp.buf.declaration() end,
		{ noremap = true, silent = true, desc = ':h vim.lsp.buf.declaration' })
	keymap('n', 'gR', function() vim.lsp.buf.rename() end, { noremap = true, silent = true, desc = ':h vim.lsp.buf.rename' })
	keymap('n', 'gc', function() vim.lsp.buf.code_action() end,
		{ noremap = true, silent = true, desc = ':h vim.lsp.buf.code_action' })
	keymap('n', 'gh', function() vim.lsp.buf.hover() end, { noremap = true, silent = true, desc = ':h vim.lsp.buf.hover' })
	keymap('n', 'gs', function() vim.lsp.buf.signature_help() end,
		{ noremap = true, silent = true, desc = ':h vim.lsp.buf.signature_help' })
	keymap('n', 'gF', vim.lsp.buf.formatting, { noremap = true, silent = true, desc = ':h vim.lsp.buf.formatting' })
	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)


end

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
				border = config.diagnosticBorder,
				source = 'always',
				prefix = ' ',
				scope = 'cursor',
			})
		end
	})
end

function M.config()
	configDiagnostic()
	configKeyMaps()
	configUI()

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
	masonLspconfig.setup {
		automatic_installation = false,
	}

	local servers = masonLspconfig.get_installed_servers()
	local lspconfig = require('lspconfig')
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	for _, name in pairs(servers) do
		local opts = config.lsp.setup[name] or {}
		if type(opts) == 'function' then
			opts = opts(lspconfig) or {}
		end

		opts = util.merge(opts, {
			capabilities = capabilities,
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 150, -- This is default in neovim 0.7+
			}
		})

		lspconfig[name].setup(opts)
	end


	require('lspconfig.ui.windows').default_options.border = config.lsp.defaultBorder
	-- lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
	--   autostart = false,
	--   handlers = {
	--   },
	-- })
end

return M
