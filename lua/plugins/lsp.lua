local M = {
	'williamboman/nvim-lsp-installer',
	disable = false,

	requires = {
		'neovim/nvim-lspconfig',
		'j-hui/fidget.nvim',
		'lukas-reineke/lsp-format.nvim',
		'ray-x/lsp_signature.nvim',
		{
			'antoinemadec/FixCursorHold.nvim',
			config = function() vim.g.cursorhold_updatetime = 100 end,
		},
	},
}

local function setupHighlight()
	-- LSP: Highlight symbol under cursor
	vim.cmd [[
		hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
		hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
		hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
	]]
end

function M.config()
	require('lsp_signature').setup{
		debug = false, -- set to true to enable debug logging
		log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
		-- default is  ~/.cache/nvim/lsp_signature.log
		verbose = false, -- show debug line number

		bind = true, -- This is mandatory, otherwise border config won't get registered.
		-- If you want to hook lspsaga or other signature handler, pls set to false
		doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
		-- set to 0 if you DO NOT want any API comments be shown
		-- This setting only take effect in insert mode, it does not affect signature help in normal
		-- mode, 10 by default

		floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

		floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
		-- will set to true when fully tested, set to false will use whichever side has more space
		-- this setting will be helpful if you do not want the PUM and floating win overlap

		floating_window_off_x = 0, -- adjust float windows x position.
		floating_window_off_y = 1, -- adjust float windows y position.


		fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
		hint_enable = true, -- virtual hint enable
		hint_prefix = "🐼 ",  -- Panda for parameter
		hint_scheme = "String",
		hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
		max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
		-- to view the hiding contents
		max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
		handler_opts = {
			border = "rounded"   -- double, rounded, single, shadow, none
		},

		always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

		auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
		extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
		zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

		padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

		transparency = nil, -- disabled by default, allow floating win transparent value 1~100
		shadow_blend = 36, -- if you using shadow as border use this set the opacity
		shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
		timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
		toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
	}


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

	vim.diagnostic.config{
		virtual_text = false,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			-- Show source in diagnostics
			source = "always",  -- Or "if_many"
		},
	}

	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap = true, silent = true }
	-- vim.api.nvim_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
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

	lspconfig.sumneko_lua.setup {
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' }
				}
			}
		}
	}

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
	-- The CursorHold autocmd is triggered when updatetime. Use https://github.com/antoinemadec/FixCursorHold.nvim to fix it
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

	-- UI for nvim-lsp loading progress
	require("fidget").setup {}

	setupHighlight()
end

return M
