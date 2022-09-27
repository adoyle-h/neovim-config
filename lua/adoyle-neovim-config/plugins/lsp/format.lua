return {
	'lukas-reineke/lsp-format.nvim',

	defaultConfig = {
		{ 'lsp', 'format' },
		{
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

	config = function()
		local config = require('adoyle-neovim-config.config').config
		local lspFormat = require('lsp-format')
		lspFormat.setup(config.lsp.format)
	end,

	keymaps = { --
		{ 'n', 'gF', vim.lsp.buf.format, { silent = true, desc = ':h vim.lsp.buf.format' } },
	},
}
