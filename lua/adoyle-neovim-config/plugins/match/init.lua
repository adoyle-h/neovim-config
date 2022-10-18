local M = { 'match', desc = 'Match quotes, parenthesis, brackets, pairs etc.' }

M.requires = {
	{
		'kylechui/nvim-surround',
		desc = 'mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, tags etc.',
		config = function(config)
			require('nvim-surround').setup(config.surround)
		end,

		defaultConfig = { 'surround', {} },
	},

	{
		'windwp/nvim-autopairs',

		config = function(config)
			local conf = config.autopairs
			require('nvim-autopairs').setup(conf.opts)

			local has_cmp, cmp = pcall(require, 'cmp')
			if has_cmp then
				local cmp_autopairs = require('nvim-autopairs.completion.cmp')
				cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done(conf.confirm))
			end
		end,

		defaultConfig = {
			'autopairs',
			{
				opts = {
					disable_filetype = { 'TelescopePrompt', 'neo-tree', 'neo-tree-popup' },
					disable_in_macro = false, -- disable when recording or executing a macro
					disable_in_visualblock = false, -- disable when insert after visual block mode
					-- ignored_next_char = [=[[%w%%%'%[%"%.]]=],
					enable_moveright = true,
					enable_afterquote = true, -- add bracket pairs after quote
					enable_check_bracket_line = true, --- check bracket in same line
					enable_bracket_in_quote = true,
					enable_abbr = false, -- trigger abbreviation
					break_undo = true, -- switch for basic rule break undo sequence
					check_ts = false,
					map_cr = false,
					map_bs = true, -- map the <BS> key
					map_c_h = false, -- Map the <C-h> key to delete a pair
					map_c_w = false, -- map <c-w> to delete a pair if possible
				},

				confirm = {
					filetypes = {
						-- -- "*" is a alias to all filetypes
						-- ['*'] = {
						-- 	['('] = {
						-- 		kind = { cmp.lsp.CompletionItemKind.Function, cmp.lsp.CompletionItemKind.Method },
						-- 		handler = handlers['*'],
						-- 	},
						-- },
						--
						-- lua = {
						-- 	['('] = {
						-- 		kind = { cmp.lsp.CompletionItemKind.Function, cmp.lsp.CompletionItemKind.Method },
						-- 		---@param char string
						-- 		---@param item item completion
						-- 		---@param bufnr buffer number
						-- 		handler = function(char, item, bufnr)
						-- 			-- Your handler function. Inpect with print(vim.inspect{char, item, bufnr})
						-- 		end,
						-- 	},
						-- },
						--
						-- tex = false, -- Disable for tex
					},

				},
			},
		},
	},

	{
		'windwp/nvim-ts-autotag',

		config = function(config)
			require('nvim-ts-autotag').setup(config.autotag)
		end,

		defaultConfig = {
			'autotag',
			{
				filetypes = {
					-- LuaFormatter off
					'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte',
					'vue', 'tsx', 'jsx', 'rescript', 'xml', 'php', 'markdown', 'glimmer', 'handlebars', 'hbs',
					-- LuaFormatter on
				},

				skip_tags = {
					-- LuaFormatter off
					'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot', 'input', 'keygen',
					'link', 'meta', 'param', 'source', 'track', 'wbr', 'menuitem',
					-- LuaFormatter on
				},
			},
		},
	},

	{
		'steelsojka/pears.nvim',
		desc = 'Auto complete pairs. Auto remove empty pairs. Support tags.',
		disable = true, -- BUG: <C-r>" in insert mode with pairs content will make all texts messy
		config = function()
			require('pears').setup(function(conf)
				conf.preset 'tag_matching'
			end)
		end,
		defaultConfig = { 'pears', {} },
	},

	require('adoyle-neovim-config.plugins.match.matchup'),
}

return M
