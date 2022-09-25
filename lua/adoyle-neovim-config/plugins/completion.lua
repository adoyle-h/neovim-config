local config = require('adoyle-neovim-config.config').config
local color = config.color
local kindSymbolMap = config.kindSymbolMap
local fn = vim.fn
local api = vim.api

local LspSignature = {
	'ray-x/lsp_signature.nvim',

	config = function()
		require('lsp_signature').setup(config.completion.signature)
	end,

	defaultConfig = {
		{ 'completion', 'signature' },
		{
			verbose = false, -- show debug line number
			debug = false, -- set to true to enable debug logging
			-- default log_path is ~/.cache/nvim/lsp_signature.log
			log_path = fn.stdpath('cache') .. '/lsp_signature.log', -- log dir when debug is on

			-- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
			-- set to 0 if you DO NOT want any API comments be shown
			-- This setting only take effect in insert mode, it does not affect signature help in normal
			-- mode, 10 by default
			doc_lines = 10,

			floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

			-- try to place the floating above the current line when possible Note:
			-- will set to true when fully tested, set to false will use whichever side has more space
			-- this setting will be helpful if you do not want the PUM and floating win overlap
			floating_window_above_cur_line = true,
			floating_window_off_x = 0, -- adjust float windows x position.
			floating_window_off_y = 0, -- adjust float windows y position.

			fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
			hint_enable = true, -- virtual hint enable
			hint_prefix = '🐼 ', -- Panda for parameter
			hint_scheme = 'String',
			hi_parameter = 'LspSignatureActiveParameter', -- how your parameter will be highlight

			-- max height of signature floating_window, if content is more than max_height,
			-- you can scroll down to view the hiding contents
			max_height = 12,
			max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width

			-- -- This is mandatory, otherwise border config won't get registered.
			-- -- If you want to hook lspsaga or other signature handler, pls set to false
			bind = false,

			-- handler_opts = {
			--   border = 'rounded' -- double, rounded, single, shadow, none
			-- },

			always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
			auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
			extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
			zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
			padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
			transparency = nil, -- disabled by default, allow floating win transparent value 1~100
			shadow_blend = 36, -- if you using shadow as border use this set the opacity
			shadow_guibg = config.color.black, -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
			timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
			toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
		},
	},
}

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

local function configTabnine()
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

	addSource({ name = 'tabnine' })
end

local M = {
	'hrsh7th/nvim-cmp',
	disable = false,

	requires = {
		LspSignature,
		{
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
				{ 'tzachar/cmp-tabnine', run = './install.sh', config = configTabnine, disable = false },
			},
		},

		{
			requires = {
				'justinj/vim-react-snippets',
				'rafamadriz/friendly-snippets',
				'honza/vim-snippets',
				'dcampos/nvim-snippy',
				'dcampos/cmp-snippy',
			},
		},
	},
}

M.highlights = {
	{ 'MenuSelectLine', { bg = color.menu.selectBG } },
	{ 'CmpFloatBorder', { fg = color.grey, bg = color.black } },
	{ 'PmenuThumb', { bg = color.grey3 } }, -- cmp scrollbar thumb
}

function M.config()
	local cmp = require('cmp')

	vim.opt.completeopt = {
		'menu', -- Use a popup menu to show the possible completions.
		'menuone', -- Use the popup menu also when there is only one match.
		'noselect', -- Do not select a match in the menu, force the user to select one from the menu.
		'noinsert', -- Do not insert any text for a match until the user selects a match from the menu.
	}

	require('snippy').setup { scopes = config.snippets.scopes }

	cmp.setup({
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
	})

	configCmdLineSources(cmp)
end

return M
