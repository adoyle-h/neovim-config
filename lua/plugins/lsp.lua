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
				server_installed = '✓',
				server_pending = '➜',
				server_uninstalled = '✗'
			},

			keymaps = {
				install_server = '<CR>',
				toggle_server_expand = '<Tab>',
			},
		}
	}

	-- Set border for LSPInstaller popup window
	vim.api.nvim_create_autocmd('FileType', {
		pattern = 'lsp-installer',
		callback = function()
			vim.api.nvim_win_set_config(0, { border = 'rounded' })
		end,
	})
end

local function configKeyMaps()
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_set_keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end


function M.config()
	vim.diagnostic.config{
		virtual_text = false,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			-- Show source in diagnostics
			source = 'always',  -- Or 'if_many'
		},
	}

	local lspFormat = require 'lsp-format'
	lspFormat.setup {}
	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		lspFormat.on_attach(client, bufnr)
	end


	local installer = require('nvim-lsp-installer')
	configLSPInstaller(installer)

	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	local servers = installer.get_installed_servers()
	local lspconfig = require('lspconfig')
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

	for _, server in pairs(servers) do
		lspconfig[server.name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			flags = {
				-- This will be the default in neovim 0.7+
				debounce_text_changes = 150,
			}
		}
	end

	lspconfig.sumneko_lua.setup {
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' }
				}
			}
		}
	}

	configKeyMaps()
	configUI()
end

return M
