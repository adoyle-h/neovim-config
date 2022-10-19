local config = require('adoyle-neovim-config.config').config
local colors = config.colors
local util = require('adoyle-neovim-config.util')

local M = { 'neovim/nvim-lspconfig' }

M.highlights = {
	LspWindowBorder = { fg = colors.cyan },
	LspInfoTitle = { fg = colors.lightGreen }, -- Client name
	LspInfoList = { fg = colors.lightGreen }, -- Server name list
	LspInfoFiletype = { fg = colors.purple }, -- `filetypes` area
	LspInfoTip = { link = 'Comment' }, -- Tip
	LspInfoBorder = { fg = colors.blue }, -- Window border
}

M.defaultConfig = {
	{ 'lsp' },
	{
		masonLspconfig = { automatic_installation = false },

		-- Change lsp.setup(opts). Format: {['lsp_name'] = settings}
		-- ":h lspconfig-all" or https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		-- for LSP configs provided by nvim-lspconfig
		setup = {
			tsserver = {
				filetypes = { -- limit tsserver only .ts files
					'typescript',
					'typescriptreact',
					'typescript.tsx',
				},
			},

			-- sumneko_lua = {
			-- 	-- You can write lsp.settings in lua. Or write it to lsp-settings/<lsp_name>.yaml file (See nlsp features).
			-- 	-- If have the same key, the value in the YAML file will take precedence.
			-- 	settings = { Lua = { diagnostics = { globals = {} } } },
			-- },
		},

		diagnostic = { -- :h vim.diagnostic.config
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				wrap = true,
				max_width = 120,
				max_height = 20,
				focusable = false,
				source = 'always', -- 'always' or 'if_many'. -- Show source in diagnostics
				prefix = ' ',
				scope = 'cursor',

				close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },

				border = { -- See the border property of ":h nvim_open_win"
					{ '╭', 'LspWindowBorder' },
					{ '─', 'LspWindowBorder' },
					{ '╮', 'LspWindowBorder' },
					{ '│', 'LspWindowBorder' },
					{ '╯', 'LspWindowBorder' },
					{ '─', 'LspWindowBorder' },
					{ '╰', 'LspWindowBorder' },
					{ '│', 'LspWindowBorder' },
				},

				-- border = {
				--   { '╔', 'LspWindowBorder' },
				--   { '═', 'LspWindowBorder' },
				--   { '╗', 'LspWindowBorder' },
				--   { '║', 'LspWindowBorder' },
				--   { '╝', 'LspWindowBorder' },
				--   { '═', 'LspWindowBorder' },
				--   { '╚', 'LspWindowBorder' },
				--   { '║', 'LspWindowBorder' },
				-- },
			},
		},
	},
}

local function configDiagnostic()
	vim.diagnostic.config(config.lsp.diagnostic)

	-- Show line diagnostics automatically in hover window
	-- The CursorHold autocmd is triggered when updatetime. Use https://github.com/antoinemadec/FixCursorHold.nvim to fix it
	vim.api.nvim_create_autocmd('CursorHold', {
		callback = function()
			vim.diagnostic.open_float()
		end,
	})
end

local function setDefaultBorder()
	local border = config.lsp.diagnostic.float.border
	require('lspconfig.ui.windows').default_options.border = border -- This line maybe not work
	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help,
		{ border = border })
end

function M.config()
	configDiagnostic()
	setDefaultBorder()

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
			autostart = true,
			flags = {
				debounce_text_changes = 150, -- This is default in neovim 0.7+
			},
		})

		-- :h lspconfig-setup
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
		signs[hl] = { text = icon, texthl = hl, numhl = hl }
	end

	return signs
end

M.keymaps = require('adoyle-neovim-config.plugins.lsp.keymaps')

return M
