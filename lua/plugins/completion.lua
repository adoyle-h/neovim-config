local fn = vim.fn
local api = vim.api

local sources = {
	-- You can specify multiple source arrays. The sources are grouped in the order you specify,
	-- and the groups are displayed as a fallback, like chain completion.
	{
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
	{
		{ name = 'path' },
		{ name = 'buffer' },
		{ name = 'spell' },
	},
}

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

local function configFormating()
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
				-- so that you can provide more controls on popup customization.
				-- See [#30](https://github.com/onsails/lspkind-nvim/pull/30)
				before = function (entry, vim_item)
					return vim_item
				end
			})
		}

end

local function has_words_before()
	local line, col = table.unpack(api.nvim_win_get_cursor(0))
	return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function feedkey(key, mode)
	api.nvim_feedkeys(api.nvim_replace_termcodes(key, true, true, true), mode, true)
end


---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
---@param dir number 1 for forward, -1 for backward; defaults to 1
---@return boolean true if a jumpable luasnip field is found while inside a snippet
local function jumpable(dir)
	local luasnip = require'luasnip'

	local win_get_cursor = vim.api.nvim_win_get_cursor
	local get_current_buf = vim.api.nvim_get_current_buf

	local function inside_snippet()
		-- for outdated versions of luasnip
		if not luasnip.session.current_nodes then
			return false
		end

		local node = luasnip.session.current_nodes[get_current_buf()]
		if not node then
			return false
		end

		local snip_begin_pos, snip_end_pos = node.parent.snippet.mark:pos_begin_end()
		local pos = win_get_cursor(0)
		pos[1] = pos[1] - 1 -- LuaSnip is 0-based not 1-based like nvim for rows
		return pos[1] >= snip_begin_pos[1] and pos[1] <= snip_end_pos[1]
	end

	---sets the current buffer's luasnip to the one nearest the cursor
	---@return boolean true if a node is found, false otherwise
	local function seek_luasnip_cursor_node()
		-- for outdated versions of luasnip
		if not luasnip.session.current_nodes then
			return false
		end

		local pos = win_get_cursor(0)
		pos[1] = pos[1] - 1
		local node = luasnip.session.current_nodes[get_current_buf()]
		if not node then
			return false
		end

		local snippet = node.parent.snippet
		local exit_node = snippet.insert_nodes[0]

		-- exit early if we're past the exit node
		if exit_node then
			local exit_pos_end = exit_node.mark:pos_end()
			if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end
		end

		node = snippet.inner_first:jump_into(1, true)
		while node ~= nil and node.next ~= nil and node ~= snippet do
			local n_next = node.next
			local next_pos = n_next and n_next.mark:pos_begin()
			local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
			or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

			-- Past unmarked exit node, exit early
			if n_next == nil or n_next == snippet.next then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end

			if candidate then
				luasnip.session.current_nodes[get_current_buf()] = node
				return true
			end

			local ok
			ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
			if not ok then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end
		end

		-- No candidate, but have an exit node
		if exit_node then
			-- to jump to the exit node, seek to snippet
			luasnip.session.current_nodes[get_current_buf()] = snippet
			return true
		end

		-- No exit node, exit from snippet
		snippet:remove_from_jumplist()
		luasnip.session.current_nodes[get_current_buf()] = nil
		return false
	end

	if dir == -1 then
		return inside_snippet() and luasnip.jumpable(-1)
	else
		return inside_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable()
	end
end

local function configMapping(cmp)

	local selectUp = cmp.mapping({
		c = function()
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				feedkey('<Up>', 'n')
			end
		end,

		i = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end
	})

	local selectDown = cmp.mapping({
		c = function()
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				feedkey('<Down>', 'n')
			end
		end,

		i = function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end
	})

	local luasnip = require('luasnip')

	-- return cmp.mapping.preset.insert({
	--   ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	return cmp.mapping.preset.insert {

		['<CR>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if entry then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			else
				fallback()
			end
		end, {'i'}),

		['<Tab>'] = cmp.mapping({
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end,

			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end,

			-- i = function(fallback)
			--   if cmp.visible() then
			--     cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
			--   elseif luasnip.expand_or_jumpable() then
			--     luasnip.expand_or_jump()
			--   elseif has_words_before() then
			--     cmp.complete()
			--   else
			--     fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			--   end
			-- end,

			s = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		}),


		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {'i', 's'}),

		-- ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
		-- ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),

		['<Down>'] = selectDown,
		['<C-n>'] = selectDown,
		['<Up>'] = selectUp,
		['<C-p>'] = selectUp,

		-- scroll preview
		['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i'}),
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i'}),

		-- ['<C-c>'] = cmp.mapping.abort(),

		-- ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),

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

	addSource({name = 'tabnine'})
end

local M = {
	nil,
	disable = false,

	requires = {
		'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
		'hrsh7th/cmp-buffer', -- buffer source for nvim-cmp
		'hrsh7th/cmp-path', -- path source for nvim-cmp
		'f3fora/cmp-spell',
		'hrsh7th/cmp-cmdline',
		{'ray-x/cmp-treesitter', config = function() addSource({name = 'treesitter'}) end},
		'onsails/lspkind.nvim',
		'hrsh7th/nvim-cmp',

		{
			requires = {
				'rafamadriz/friendly-snippets',
				'L3MON4D3/LuaSnip',
				'saadparwaiz1/cmp_luasnip',
			},
		},

		'justinj/vim-react-snippets',
		'David-Kunz/cmp-npm',
		{'tzachar/cmp-tabnine', run = './install.sh', config = configTabnine, disable = false},
		{'ray-x/lsp_signature.nvim', config = configFuncSignature},
	},
}

function M.config()
	local cmp = require('cmp')

	-- vim.cmd 'set completeopt=menu,menuone,noselect'

	local present, luasnip = pcall(require, "luasnip")
	if not present then
		vim.notify('luasnip not found', 'warn', {title = '[Plug=completion]'})
		return
	end

	cmp.setup({
		mapping = configMapping(cmp),
		formatting = configFormating(),
		sources = cmp.config.sources(table.unpack(sources)),

		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
	})

	require('luasnip.loaders.from_vscode').lazy_load()

	configCmdLine(cmp)
	configFileType(cmp)
end

return M
