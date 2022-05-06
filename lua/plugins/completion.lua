local fn = vim.fn
local api = vim.api

local function configFuncSignature()
	require('lsp_signature').setup{
		debug = false, -- set to true to enable debug logging
		log_path = fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
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
end

local function configFormating(cmp)
	local lspkind = require('lspkind')

	return {
		format = lspkind.cmp_format({
			mode = 'symbol', -- show only symbol annotations. Options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			maxwidth = 50, -- prevent the popup from showing more than provided characters

			-- default symbol map
			-- 'default' (requires nerd-fonts font) or
			-- 'codicons' for codicon preset (requires vscode-codicons font)
			preset = 'default',

			-- symbol_map = {
				--   Text = "",
				--   Method = "",
				--   Function = "",
				--   Constructor = "",
				--   Field = "ﰠ",
				--   Variable = "",
				--   Class = "ﴯ",
				--   Interface = "",
				--   Module = "",
				--   Property = "ﰠ",
				--   Unit = "塞",
				--   Value = "",
				--   Enum = "",
				--   Keyword = "",
				--   Snippet = "",
				--   Color = "",
				--   File = "",
				--   Reference = "",
				--   Folder = "",
				--   EnumMember = "",
				--   Constant = "",
				--   Struct = "פּ",
				--   Event = "",
				--   Operator = "",
				--   TypeParameter = ""
				-- },

				-- The function below will be called before any actual modifications from lspkind
				-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
				before = function (entry, vim_item)
					return vim_item
				end
			})
		}

end

local t = function(str)
	return api.nvim_replace_termcodes(str, true, true, true)
end

local function configMapping(cmp)
	-- return cmp.mapping.preset.insert({
	--   ['<C-e>'] = cmp.mapping.abort(),
	--   ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	return {
		["<Tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				else
					cmp.complete()
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				elseif fn["UltiSnips#CanJumpForwards"]() == 1 then
					api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if fn["UltiSnips#CanJumpForwards"]() == 1 then
					api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
				else
					fallback()
				end
			end
		}),
		["<S-Tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				else
					cmp.complete()
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				elseif fn["UltiSnips#CanJumpBackwards"]() == 1 then
					return api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if fn["UltiSnips#CanJumpBackwards"]() == 1 then
					return api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
				else
					fallback()
				end
			end
		}),
		['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
		['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
		['<C-n>'] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					api.nvim_feedkeys(t('<Down>'), 'n', true)
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end
		}),
		['<C-p>'] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					api.nvim_feedkeys(t('<Up>'), 'n', true)
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end
		}),
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
		['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
		['<CR>'] = cmp.mapping({
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end
		}),
	}
end

local function configCmdLine(cmp)
	for _, cmd_type in ipairs({ '/', '?' }) do
		-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(cmd_type, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})
	end

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' },
		})
	})
end

local function configSources(cmp)
	return cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'path' },
		{ name = 'buffer' },
		{ name = 'spell' },
	}, {
		{ name = 'cmp_tabnine' },
	})
end

local function configFileType(cmp)
	-- cmp.setup.filetype('json', {
	--   sources = cmp.config.sources({
	--     { name = 'nvim_lsp' },
	--     { name = 'ultisnips' },
	--     { name = 'path' },
	--     { name = 'buffer' },
	--     { name = 'npm', keyword_length = 4 },
	--   })
	-- })


	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
		}, {
			{ name = 'buffer' },
		})
	})
end

local M = {
	'',
	disable = false,

	requires = {
		{
			'SirVer/ultisnips', config = function()
				UltiSnipsSnippetsDir = fn.stdpath('config') .. '/UltiSnips'
			end,
		},
		-- vim-snippets depends on ultisnips
		'honza/vim-snippets',
		'justinj/vim-react-snippets',
		'ahmedelgabri/vim-ava-snippets',
		'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
		'hrsh7th/cmp-buffer', -- buffer source for nvim-cmp
		'hrsh7th/cmp-path', -- path source for nvim-cmp
		'f3fora/cmp-spell',
		'hrsh7th/cmp-cmdline',
		-- 'dmitmel/cmp-cmdline-history',
		"quangnguyen30192/cmp-nvim-ultisnips",
		'David-Kunz/cmp-npm',
		{ 'tzachar/cmp-tabnine', run = './install.sh' },
		'hrsh7th/nvim-cmp',
		'onsails/lspkind.nvim',
		{'ray-x/lsp_signature.nvim', config = configFuncSignature},
	},
}

function M.config()
	local cmp = require('cmp')

	cmp.setup({
		-- mapping = configMapping(cmp),
		formatting = configFormating(cmp),
		sources = configSources(cmp),

		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				-- vim.fn["vsnip#anonymous"](args.body) For `vsnip` users.
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},

		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
	})

	require('cmp_tabnine.config'):setup({
		max_lines = 1000,
		max_num_results = 20,
		sort = true,
		run_on_every_keystroke = true,
		snippet_placeholder = '..',
		ignored_file_types = { -- default is not to ignore
			-- uncomment to ignore in lua:
			-- lua = true
		},
		show_prediction_strength = true,
	})

	configCmdLine(cmp)
	configFileType(cmp)
end

return M
