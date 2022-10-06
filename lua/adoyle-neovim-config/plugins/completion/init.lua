local config = require('adoyle-neovim-config.config').config
local colors = config.colors
local kindSymbolMap = config.kindSymbolMap
local api = vim.api

-- You can specify multiple source arrays. The sources are grouped in the order you specify,
-- and the groups are displayed as a fallback, like chain completion.
local sources = {
	{ { name = 'nvim_lsp' }, { name = 'snippy' }, { name = 'buffer' }, { name = 'path' } },
	{ { name = 'spell' } },
}

local function configFormating()
	return {
		-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua#L42-L47
		fields = { 'kind', 'abbr', 'menu' }, -- fields see ":h complete-items"
		format = function(entry, item)
			-- vim_item.kind = string.format("%s %s", kindSymbolMap[vim_item.kind], vim_item.kind)
			item.kind = kindSymbolMap[item.kind]

			local srcName = entry.source.name
			item.menu = ({
				buffer = 'BUF',
				nvim_lsp = 'LSP',
				nvim_lua = 'LUA',
				path = 'PATH',
				npm = 'NPM',
				neorg = 'ORG',
				tabnine = 'TABN',
				snippy = 'SNIP',
			})[srcName] or srcName

			local MAX_LABEL_WIDTH = 30
			local abbr = item.abbr

			if #abbr > MAX_LABEL_WIDTH then
				item.abbr = vim.fn.strcharpart(abbr, 0, MAX_LABEL_WIDTH) .. '…'
			end

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

local function configCmdLineSources(cmp)
	for _, cmd_type in pairs({ '/', '?' }) do
		-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(cmd_type, {
			-- mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = 'buffer' }, { name = 'path' } },
		})
	end

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		-- mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({ { name = 'path' }, { name = 'cmdline' } }),
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({ { name = 'git' }, { name = 'buffer' }, { name = 'path' } }),
	})
end

local function addSource(src)
	local lastSrcGroup = sources[#sources]
	table.insert(lastSrcGroup, src)
end

local M = {
	'hrsh7th/nvim-cmp',

	requires = {
		'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
		'hrsh7th/cmp-buffer', -- buffer source for nvim-cmp
		'hrsh7th/cmp-path', -- path source for nvim-cmp
		'f3fora/cmp-spell',
		'hrsh7th/cmp-cmdline',
		{
			'ray-x/cmp-treesitter',
			config = function()
				addSource({ name = 'treesitter' })
			end,
		},
		'David-Kunz/cmp-npm',
		'petertriho/cmp-git',

		require('adoyle-neovim-config.plugins.completion.tabnine'),
		require('adoyle-neovim-config.plugins.completion.hover'),
		require('adoyle-neovim-config.plugins.completion.snippet'),
	},
}

M.highlights = {
	{ 'MenuSelectLine', { bg = colors.menu.selectBG } },
	{ 'CmpFloatBorder', { fg = colors.grey, bg = colors.black } },
	{ 'PmenuThumb', { bg = colors.grey3 } }, -- cmp scrollbar thumb
}

function M.config()
	local cmp = require('cmp')

	if pcall(require, 'cmp_tabnine') then addSource { name = 'tabnine' } end

	local opts = {
		mapping = configMapping(cmp),
		formatting = configFormating(),
		sources = cmp.config.sources(table.unpack(sources)),

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

	configCmdLineSources(cmp)
end

return M
