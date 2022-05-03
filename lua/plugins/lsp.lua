local M = {
	'williamboman/nvim-lsp-installer',
	disable = false,

	requires = {
		'neovim/nvim-lspconfig',
		'j-hui/fidget.nvim',
		'lukas-reineke/lsp-format.nvim',
	},
}

function M.config()
	local installer = require("nvim-lsp-installer")

	-- In order for nvim-lsp-installer to register the necessary hooks at the right moment,
	-- make sure you call the .setup() function before you set up any servers with lspconfig!
	installer.setup {
		-- ensure these servers are always installed
		ensure_installed = {},
		-- automatically detect which servers to install (based on which servers are set up via lspconfig)
		automatic_installation = true,
		install_root_dir = vim.fn.stdpath("data") .. "/lsp_servers",
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗"
			},

			keymaps = {
				install_server = "<CR>",
				toggle_server_expand = "<Tab>",
			},
		}
	}

	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

	local lspFormat = require "lsp-format"
	lspFormat.setup {}

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		lspFormat.on_attach(client, bufnr)

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	end


	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	local servers = installer.get_installed_servers()
	local lspconfig = require("lspconfig")
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

	-- Highlight symbol under cursor
	vim.api.nvim_create_augroup('lsp_document_highlight', {})
	vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
		group = 'lsp_document_highlight',
		buffer = 0,
		callback = vim.lsp.buf.document_highlight,
	})
	vim.api.nvim_create_autocmd('CursorMoved', {
		group = 'lsp_document_highlight',
		buffer = 0,
		callback = vim.lsp.buf.clear_references,
	})

	-- Show line diagnostics automatically in hover window
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			vim.diagnostic.open_float(nil, {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = 'rounded',
				source = 'always',
				prefix = ' ',
				scope = 'cursor',
			})
		end
	})

	local signs = { Error = "•", Warn = "•", Hint = "", Info = "" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	local icons = {
		Class = " ",
		Color = " ",
		Constant = " ",
		Constructor = " ",
		Enum = "了 ",
		EnumMember = " ",
		Field = " ",
		File = " ",
		Folder = " ",
		Function = " ",
		Interface = "ﰮ ",
		Keyword = " ",
		Method = "ƒ ",
		Module = " ",
		Property = " ",
		Snippet = "﬌ ",
		Struct = " ",
		Text = " ",
		Unit = " ",
		Value = " ",
		Variable = " ",
	}
	local kinds = vim.lsp.protocol.CompletionItemKind
	for i, kind in ipairs(kinds) do
		kinds[i] = icons[kind] or kind
	end

	require("fidget").setup {}
end

return M
