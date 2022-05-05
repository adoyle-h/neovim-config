local M = {
	'hrsh7th/nvim-cmp',
	disable = false,

	requires = {
		'SirVer/ultisnips',
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
		'onsails/lspkind.nvim',
	},
}

function SetFormating(cmp)
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
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function SetMapping(cmp)
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
				elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
					vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
					vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
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
				elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
					return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
					return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
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
					vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
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
					vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
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

function SetCmdLine(cmp)
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

function SetSources(cmp)
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

function M.config()
	local cmp = require('cmp')

	cmp.setup({
		mapping = SetMapping(cmp),
		formatting = SetFormating(cmp),
		sources = SetSources(cmp),

		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				-- vim.fn["vsnip#anonymous"](args.body) For `vsnip` users.
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},

		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
	})

	SetCmdLine(cmp)

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

return M
