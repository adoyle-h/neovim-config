local _config = require('adoyle-neovim-config.config').config
local colors = _config.colors
local kindSymbolMap = _config.kindSymbolMap
local api = vim.api

local function configFormating(conf)
	return {
		-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua#L42-L47
		fields = conf.menu.fields, -- fields see ":h complete-items"
		format = function(entry, item)
			-- vim_item.kind = string.format("%s %s", kindSymbolMap[vim_item.kind], vim_item.kind)
			item.kind = kindSymbolMap[item.kind]

			local srcName = entry.source.name
			item.menu = conf.menu.kindLabels[srcName] or srcName:upper()

			local maxAbbrWidth = conf.menu.maxAbbrWidth
			local abbr = item.abbr

			if #abbr > maxAbbrWidth then item.abbr = vim.fn.strcharpart(abbr, 0, maxAbbrWidth) .. '…' end

			return item
		end,
	}
end

local function has_words_before()
	local line, col = table.unpack(api.nvim_win_get_cursor(0))
	return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') ==
		       nil
end

local function feedkey(key, mode)
	api.nvim_feedkeys(api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local function configMapping(cmp)
	local snippy = require('snippy')
	local useFallback = function(fallback)
		fallback()
	end

	-- SelectBehavior : { Insert = "insert", Select = "select" }
	-- :lua print(vim.inspect(require('cmp').SelectBehavior))
	local behavior = cmp.SelectBehavior.Insert

	local selectNext = {
		i = function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = behavior })
			elseif snippy.can_jump(1) then
				snippy.next()
			elseif snippy.can_expand(1) then
				snippy.expand()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end,

		s = function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = behavior })
			elseif snippy.can_jump(1) then
				snippy.next()
			elseif snippy.can_expand(1) then
				snippy.expand()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end,

		c = function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = behavior })
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end,
	}

	local selectPrev = {
		i = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = behavior })
			elseif snippy.can_jump(-1) then
				snippy.previous()
			else
				fallback()
			end
		end,

		s = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = behavior })
			elseif snippy.can_jump(-1) then
				snippy.previous()
			else
				fallback()
			end
		end,

		c = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = behavior })
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end,
	}

	local selectPrevOrHistoryPrev = { c = useFallback }
	selectPrevOrHistoryPrev.i = selectPrev.i
	selectPrevOrHistoryPrev.s = selectPrev.s

	local selectNextOrHistoryNext = { c = useFallback }
	selectNextOrHistoryNext.i = selectNext.i
	selectNextOrHistoryNext.s = selectNext.s

	local selectPageUp = cmp.mapping(function()
		local i = 8
		if cmp.visible() then
			while i > 0 do
				cmp.select_prev_item({ behavior = behavior })
				i = i - 1
			end
		else
			feedkey(i .. '<Up>', 'n')
		end
	end, { 'i', 'c', 's' })

	local selectPageDown = cmp.mapping(function()
		local i = 8
		if cmp.visible() then
			while i > 0 do
				cmp.select_next_item({ behavior = behavior })
				i = i - 1
			end
		else
			feedkey(i .. '<Down>', 'n')
		end
	end, { 'i', 'c', 's' })

	local confirm = cmp.mapping(function(fallback)
		if cmp.visible() then
			local entry = cmp.get_selected_entry()
			if entry then
				-- :lua print(vim.inspect(require('cmp').ConfirmBehavior))
				-- { Insert = "insert", Replace = "replace" }
				cmp.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false, -- If select = true, automatically select the first item when completion.
				}
			else
				fallback()
			end
		else
			fallback()
		end
	end, { 'i', 'c', 's' })

	return cmp.mapping.preset.insert {
		['<CR>'] = confirm,
		['<Down>'] = selectNext,
		['<Up>'] = selectPrev,
		['<C-n>'] = selectNextOrHistoryNext,
		['<C-p>'] = selectPrevOrHistoryPrev,

		['<Tab>'] = selectNext,
		['<S-Tab>'] = selectPrev,
		['<C-j>'] = selectNext,
		['<C-k>'] = selectPrev,
		['<C-f>'] = selectPageDown,
		['<C-b>'] = selectPageUp,
		['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 's' }), -- scroll preview up
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 's' }), -- scroll preview down
		['<M-c>'] = cmp.mapping.abort(),
	}
end

local M = {
	'completion',

	requires = {
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
		'hrsh7th/cmp-buffer', -- buffer source for nvim-cmp
		'hrsh7th/cmp-path', -- path source for nvim-cmp
		'f3fora/cmp-spell',
		'hrsh7th/cmp-cmdline',
		'David-Kunz/cmp-npm',
		'petertriho/cmp-git',
		'ray-x/cmp-treesitter',

		require('adoyle-neovim-config.plugins.completion.copilot'),
		require('adoyle-neovim-config.plugins.completion.tabnine'),
		require('adoyle-neovim-config.plugins.completion.hover'),
		require('adoyle-neovim-config.plugins.completion.snippet'),
	},

	highlights = {
		MenuSelectLine = { bg = '#012867' },
		CmpFloatBorder = { fg = colors.grey, bg = colors.black },
		PmenuThumb = { bg = colors.grey3 }, -- cmp scrollbar thumb
	},
}

function M.config(config)
	local cmp = require('cmp')
	local conf = config.completion
	local sources = conf.sources.normal

	if pcall(require, 'cmp_tabnine') then table.insert(sources, { name = 'tabnine', group_index = 1 }) end
	if pcall(require, 'cmp_copilot') then table.insert(sources, { name = 'copilot', group_index = 1 }) end
	if pcall(require, 'cmp_treesitter') then
		table.insert(sources, { name = 'treesitter', group_index = 2 })
	end

	local opts = {
		mapping = configMapping(cmp),
		formatting = configFormating(conf),
		sources = sources,

		snippet = {
			expand = function(args)
				require('snippy').expand_snippet(args.body)
			end,
		},

		window = {
			-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/window.lua
			completion = cmp.config.window.bordered({
				winhighlight = 'Normal:Normal,FloatBorder:CmpFloatBorder,CursorLine:MenuSelectLine,Search:None',
			}),

			documentation = cmp.config.window.bordered({
				winhighlight = 'Normal:Normal,FloatBorder:CmpFloatBorder,CursorLine:MenuSelectLine,Search:None',
			}),
		},
	}

	cmp.setup(opts)

	for _, cmd_type in pairs({ '/', '?' }) do
		cmp.setup.cmdline(cmd_type, {
			-- mapping = cmp.mapping.preset.cmdline(),
			sources = conf.sources.search,
		})
	end

	cmp.setup.cmdline(':', {
		-- mapping = cmp.mapping.preset.cmdline(),
		sources = conf.sources.cmdline,
	})

	for ft, props in pairs(conf.filetypes) do
		-- Set configuration for specific filetype.
		cmp.setup.filetype(ft, props)
	end
end

M.defaultConfig = function()
	return {
		'completion',
		{
			-- You can specify multiple source arrays. The sources are grouped in the group_index order you specify,
			-- and the groups are displayed as a fallback, like chain completion.
			-- See ":h cmp-config.sources" for full source properties.
			sources = {
				normal = {
					{ name = 'nvim_lsp', group_index = 1 },
					{ name = 'snippy', group_index = 1 },
					{ name = 'buffer', group_index = 1 },
					{ name = 'path', group_index = 1 },
					{ name = 'spell', group_index = 2 },
				},

				search = { -- Use buffer source for `/` and '?' (if you enabled `native_menu`, this won't work anymore).
					{ name = 'buffer', group_index = 1 },
					{ name = 'path', group_index = 1 },
				},

				cmdline = { -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
					{ name = 'path', group_index = 1 },
					{ name = 'cmdline', group_index = 1 },
				},
			},

			filetypes = {
				gitcommit = {
					sources = {
						{ name = 'git', group_index = 1 },
						{ name = 'buffer', group_index = 1 },
						{ name = 'path', group_index = 1 },
					},
				},
			},

			menu = {
				fields = { 'kind', 'abbr', 'menu' },

				kindLabels = {
					buffer = 'BUF',
					nvim_lsp = 'LSP',
					nvim_lua = 'LUA',
					neorg = 'ORG',
					tabnine = 'TABN',
					copilot = 'COPI',
					snippy = 'SNIP',
					treesitter = 'TREE',
					cmdline = 'CMD',
				},

				maxAbbrWidth = 30,
			},
		},
	}
end

return M
