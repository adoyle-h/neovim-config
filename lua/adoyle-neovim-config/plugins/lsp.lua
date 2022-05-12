local M = {
	'williamboman/nvim-lsp-installer',
	disable = false,

	requires = {
		'neovim/nvim-lspconfig',
		'j-hui/fidget.nvim',
		'lukas-reineke/lsp-format.nvim',
		{
			'antoinemadec/FixCursorHold.nvim',
			config = function() vim.g.cursorhold_updatetime = 100 end,
		},

		'jose-elias-alvarez/null-ls.nvim',
	},
}

local function configHighlight()
	-- LSP: Highlight symbol under cursor
	vim.cmd [[
		hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
		hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
		hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
	]]
end

local function configUI()
	local signs = { Error = '•', Warn = '•', Hint = '', Info = '' }
	for type, icon in pairs(signs) do
		local hl = 'DiagnosticSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	-- UI for nvim-lsp loading progress
	require('fidget').setup {}

	configHighlight()
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
	local opts = { noremap = true, silent = true }
	local keymap = vim.keymap.set

	keymap('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
	keymap('n', ']d', function() vim.diagnostic.goto_next() end, opts)
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	keymap('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
	keymap('n', 'gI', function() vim.lsp.buf.implementation() end, opts)
	keymap('n', 'gR', function() vim.lsp.buf.rename() end, opts)
	keymap('n', 'ga', function() vim.lsp.buf.code_action() end, opts)
	keymap('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	keymap('n', 'gh', function() vim.lsp.buf.hover() end, opts)
	keymap('n', 'gr', function() vim.lsp.buf.references() end, opts)
	keymap('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
	keymap('n', 'gt', function() vim.lsp.buf.type_definition() end, opts)
end

local lspSetupOptsMap = {
	sumneko_lua = function(opts)
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' }
				}
			}
		}
	end
}

local function configNullLSP()
	local null_ls = require('null-ls')

	null_ls.setup({
		debounce = 150,
		default_timeout = 3000,
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.code_actions.eslint_d,
			null_ls.builtins.diagnostics.eslint_d,
			null_ls.builtins.formatting.eslint_d,
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.completion.spell,
		},
	})
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
	configNullLSP()
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
		}
	}
	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		local ok, aerial = pcall(require, 'aerial')
		if ok then aerial.on_attach(client, bufnr) end

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
		local fn = lspSetupOptsMap[name]
		if fn then fn(opts) end
		lspconfig[name].setup(opts)
	end
end

return M
