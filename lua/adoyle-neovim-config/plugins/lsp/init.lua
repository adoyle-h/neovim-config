local config = require('adoyle-neovim-config.config').config
local colors = config.colors
local util = require('adoyle-neovim-config.util')

local M = {
	nil,

	requires = {
		require('adoyle-neovim-config.plugins.lsp.mason'),
		require('adoyle-neovim-config.plugins.lsp.mason-installer'),
		require('adoyle-neovim-config.plugins.lsp.null-ls'),
		require('adoyle-neovim-config.plugins.lsp.preview'),
		require('adoyle-neovim-config.plugins.lsp.nlsp'),
		require('adoyle-neovim-config.plugins.lsp.fidget'),
		require('adoyle-neovim-config.plugins.lsp.format'),

		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',

		{
			-- This plugin is not needed after https://github.com/neovim/neovim/pull/20198
			'antoinemadec/FixCursorHold.nvim',
			config = function()
				vim.g.cursorhold_updatetime = 100
			end,
		},
	},

	highlights = {
		{ 'LspWindowBorder', { fg = colors.cyan } },
		{ 'LspInfoTitle', { fg = colors.lightGreen } }, -- Client name
		{ 'LspInfoList', { fg = colors.lightGreen } }, -- Server name list
		{ 'LspInfoFiletype', { fg = colors.purple } }, -- `filetypes` area
		{ 'LspInfoTip', { link = 'Comment' } }, -- Tip
		{ 'LspInfoBorder', { fg = colors.blue } }, -- Window border
	},
}

M.defaultConfig = {
	{ 'lsp' },
	{
		-- See the border property of ":h nvim_open_win"
		winBorder = {
			{ '╭', 'LspWindowBorder' },
			{ '─', 'LspWindowBorder' },
			{ '╮', 'LspWindowBorder' },
			{ '│', 'LspWindowBorder' },
			{ '╯', 'LspWindowBorder' },
			{ '─', 'LspWindowBorder' },
			{ '╰', 'LspWindowBorder' },
			{ '│', 'LspWindowBorder' },
		},

		-- winBorder = {
		--   { '╔', 'LspWindowBorder' },
		--   { '═', 'LspWindowBorder' },
		--   { '╗', 'LspWindowBorder' },
		--   { '║', 'LspWindowBorder' },
		--   { '╝', 'LspWindowBorder' },
		--   { '═', 'LspWindowBorder' },
		--   { '╚', 'LspWindowBorder' },
		--   { '║', 'LspWindowBorder' },
		-- },

		masonLspconfig = { automatic_installation = false },

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

	},
}

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
				border = config.lsp.winBorder,
				source = 'always',
				prefix = ' ',
				scope = 'cursor',
			})
		end,
	})
end

local function setBorder()
	-- set default border
	local border = config.lsp.winBorder
	require('lspconfig.ui.windows').default_options.border = border -- This line maybe not work
	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help,
		{ border = border })
end

function M.config()
	configDiagnostic()
	setBorder()

	local has_format, lspFormat = pcall(require, 'lsp-format')
	local has_aerial, aerial = pcall(require, 'aerial')
	local has_navic, navic = pcall(require, 'nvim-navic')

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		if has_aerial then aerial.on_attach(client, bufnr) end
		if has_navic then navic.attach(client, bufnr) end
		if has_format then lspFormat.on_attach(client, bufnr) end
	end

	local masonLspconfig = require('mason-lspconfig')
	masonLspconfig.setup(config.lsp.masonLspconfig)

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

return M
