local config = require('adoyle-neovim-config.config').global

-- null-ls is an attempt to bridge that gap and simplify the process of creating, sharing, and setting up LSP sources using pure Lua.
local M_NullLS = {
	'jose-elias-alvarez/null-ls.nvim',
	config = function()
		local null_ls = require('null-ls')
		local sources = {
			null_ls.builtins.code_actions.eslint_d,
			null_ls.builtins.diagnostics.eslint_d,
			null_ls.builtins.completion.spell,

			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.eslint_d,
			null_ls.builtins.formatting.prettierd,
		}

		local has_gitsigns = pcall(require, 'gitsigns')
		if has_gitsigns then
			table.insert(sources, null_ls.builtins.code_actions.gitsigns)
		end

		null_ls.setup({
			debounce = 150,
			default_timeout = 3000,
			sources = sources,
		})
	end
}

local M_GotoPreview = {
	'rmagatti/goto-preview',
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
			nnoremap gc <cmd>lua require('goto-preview').close_all_win()<CR>
			" Only set if you have telescope installed
			nnoremap gr <cmd>lua require('goto-preview').goto_preview_references()<CR>
		]]
	end
}

local M = {
	'williamboman/nvim-lsp-installer', -- Use :LspInstallInfo to install/upgrade/uninstall lsp
	disable = false,

	requires = {
		M_NullLS,
		M_GotoPreview,
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
	-- local signs = { Error = '•', Warn = '•', Hint = '•', Info = '•' }
	local symbolMap = config.symbolMap
	local signs = { Error = symbolMap.ERROR, Warn = symbolMap.WARN, Hint = symbolMap.HINT, Info = symbolMap.INFO }
	for type, icon in pairs(signs) do
		local hl = 'DiagnosticSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
end

local function configLSPInstaller(installer)
	-- In order for nvim-lsp-installer to register the necessary hooks at the right moment,
	-- make sure you call the .setup() function before you set up any servers with lspconfig!
	installer.setup {
		-- ensure these servers are always installed
		ensure_installed = {},

		-- automatically detect which servers to install (based on which servers are set up via lspconfig)
		automatic_installation = true,

		install_root_dir = vim.fn.stdpath('data') .. '/lsp_servers',

		ui = {
			icons = {
				server_installed = '',
				server_pending = '',
				server_uninstalled = ''
			},

			keymaps = {
				install_server = '<CR>',
				uninstall_server = 'x',
				toggle_server_expand = '<Tab>',
			},
		}
	}
end

local function configKeyMaps()
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local keymap = vim.keymap.set

	keymap('n', '[d', function() vim.diagnostic.goto_prev() end, { noremap = true, silent = true, desc = ':h vim.diagnostic.goto_prev' })
	keymap('n', ']d', function() vim.diagnostic.goto_next() end, { noremap = true, silent = true, desc = ':h vim.diagnostic.goto_next' })
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	keymap('n', 'gD', function() vim.lsp.buf.declaration() end, { noremap = true, silent = true, desc = ':h vim.lsp.buf.declaration' })
	keymap('n', 'gR', function() vim.lsp.buf.rename() end, { noremap = true, silent = true, desc = ':h vim.lsp.buf.rename' })
	keymap('n', 'ga', function() vim.lsp.buf.code_action() end, { noremap = true, silent = true, desc = ':h vim.lsp.buf.code_action' })
	keymap('n', 'gh', function() vim.lsp.buf.hover() end, { noremap = true, silent = true, desc = ':h vim.lsp.buf.hover' })
	keymap('n', 'gs', function() vim.lsp.buf.signature_help() end, { noremap = true, silent = true, desc = ':h vim.lsp.buf.signature_help' })
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
				focusable = false,
				close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
				border = 'rounded',
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

	local installer = require('nvim-lsp-installer')
	configLSPInstaller(installer)

	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	local servers = installer.get_installed_servers()
	local lspconfig = require('lspconfig')
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

	local lspFormat = require('lsp-format')
	lspFormat.setup {
		javascript = {
			order = { 'eslint_d', 'prettierd' },
		},
	}

	local has_aerial, aerial = pcall(require, 'aerial')
	local has_navic, navic = pcall(require, 'nvim-navic')

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		if has_aerial then aerial.on_attach(client, bufnr) end
		if has_navic then navic.attach(client, bufnr) end

		lspFormat.on_attach(client, bufnr)
	end

	for _, server in pairs(servers) do
		local name = server.name
		local opts = {
			capabilities = capabilities,
			on_attach = on_attach,
			flags = {
				-- This will be the default in neovim 0.7+
				debounce_text_changes = 150,
			}
		}
		local fn = config.lsp[name]
		if fn then fn(opts) end
		lspconfig[name].setup(opts)
	end
end

return M
