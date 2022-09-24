local config = require('adoyle-neovim-config.config').config
local color = config.color
local util = require('adoyle-neovim-config.util')

local M = {
	'nvim-telescope/telescope.nvim',
	disable = false,
	requires = {
		'nvim-telescope/telescope-ui-select.nvim', -- improve the default vim.ui interfaces, like lsp.buf.code_action
	},
}

local function configMapping()
	return {
		i = {
			-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
			['<C-s>'] = 'select_horizontal',
			['<C-j>'] = 'move_selection_next',
			['<C-k>'] = 'move_selection_previous',
			-- ['<C-u>'] = false,
			-- ['<C-d>'] = false,
			['<C-b>'] = 'results_scrolling_up',
			['<C-f>'] = 'results_scrolling_down',
		},

		n = { ['<C-b>'] = 'results_scrolling_up', ['<C-f>'] = 'results_scrolling_down' },
	}
end

function M.config()
	local telescope = require('telescope')
	local action_state = require('telescope.actions.state')
	local actions = require('telescope.actions')
	local api = vim.api

	telescope.setup {
		defaults = {
			prompt_prefix = ' ',

			scroll_strategy = 'limit',

			-- Defines the command that will be used for `live_grep` and `grep_string` pickers.
			-- Hint: Make sure that color is currently set to `never` because we do not yet interpret color codes
			-- Hint 2: Make sure that these options are in your changes arguments:
			--   "--no-heading", "--with-filename", "--line-number", "--column"
			-- because we need them so the ripgrep output is in the correct format.
			vimgrep_arguments = {
				'rg',
				'--color=never',
				'--no-heading',
				'--with-filename',
				'--line-number',
				'--column',
				'--smart-case',
			},

			path_display = {
				shorten = {
					len = 2, -- shorten into 2 letters
					exclude = { 1, -2, -1 }, -- exclude the first, the last and last second words in path
				},
			},

			-- :h telescope.layout
			layout_config = {
				bottom_pane = {
					height = 25,
					-- prompt_position valid values: top or bottom
					prompt_position = 'top',
				},

				center = { height = 0.4, prompt_position = 'top', width = 0.8 },

				cursor = { height = 0.4, width = 0.8 },

				horizontal = { height = 0.9, prompt_position = 'bottom', width = 0.9 },

				vertical = { height = 0.9, prompt_position = 'bottom', width = 0.8 },
			},

			mappings = configMapping(),
		},

		pickers = {
			find_files = {
				hidden = true,
				theme = 'dropdown',
				path_display = {},
				layout_config = { width = 0.8 },
			},

			oldfiles = { layout_strategy = 'vertical', path_display = {} },

			git_files = { path_display = {} },

			highlights = {
				theme = 'dropdown',
				mappings = {
					i = {
						['<CR>'] = function(prompt_bufnr)
							local entry = action_state.get_selected_entry(prompt_bufnr)
							actions.close(prompt_bufnr)
							local text = api.nvim_replace_termcodes(vim.fn.printf(':hi %s ', entry.value), true, false,
								true)
							api.nvim_feedkeys(text, 't', true)
						end,
					},
				},
			},

			buffers = { theme = 'dropdown' },

			live_grep = {
				theme = 'dropdown',

				layout_config = { anchor = 'S', prompt_position = 'bottom', width = 0.8 },
			},

			current_buffer_fuzzy_find = {
				theme = 'dropdown',
				layout_config = { anchor = 'S', prompt_position = 'bottom', width = 0.8 },
			},

			spell_suggest = { layout_strategy = 'cursor' },

			diagnostics = { theme = 'dropdown', layout_config = { width = 0.8 } },

			lsp_references = {
				theme = 'dropdown',
				layout_config = { anchor = 'S', prompt_position = 'bottom', width = 0.8 },

				preview = {
					filetype_hook = function(filepath, bufnr, opts)
						vim.api.nvim_win_set_option(opts.winid, 'number', true)
						return true
					end,
				},
			},

		},

		extensions = {
			['ui-select'] = { layout_config = { width = 0.4, height = 16 } },

			aerial = {
				-- Display symbols as <root>.<parent>.<symbol>
				show_nesting = true,
			},
		},
	}

	telescope.load_extension('ui-select')

	local has_notify = pcall(require, 'notify')
	if has_notify then telescope.load_extension('notify') end

	local has_aerial = pcall(require, 'aerial')
	if has_aerial then telescope.load_extension('aerial') end
end

M.keymaps = function()
	local tb = require('telescope.builtin')
	local opts = { silent = true }

	local map = {

		{ 'n', '<space>;', ':Telescope builtin<cr>', opts },

		{ 'n', '<space>M', ':Telescope man_pages<cr>', opts },

		{ 'n', '<space>f', ':Telescope find_files<cr>', opts },

		{
			'v',
			'<space>f',
			function()
				local text = util.getVisualSelection()
				tb.find_files({ default_text = text })
			end,
			{ silent = true, desc = 'Find files with selection' },
		},

		{ 'n', '<space>?', ':Telescope current_buffer_fuzzy_find<cr>', opts },
		{
			'v',
			'<space>?',
			function()
				local text = util.getVisualSelection()
				tb.current_buffer_fuzzy_find({ default_text = text })
			end,
			{ silent = true, desc = 'Search in current file with selection' },
		},

		{ 'n', '<space>/', ':Telescope live_grep<cr>', opts },
		{
			'v',
			'<space>/',
			function()
				local text = util.getVisualSelection()
				tb.live_grep({ default_text = text })
			end,
			{ silent = true, desc = 'Global search content with selection' },
		},

		{ 'n', '<space>p', ':Telescope commands<cr>', opts },
		{
			'v',
			'<space>p',
			function()
				local text = util.getVisualSelection()
				tb.commands({ default_text = text })
			end,
			{ silent = true, desc = 'List commands with selection' },
		},

		-- Press '<Enter>' to execute command immediately.
		-- Press '<Ctrl-e>' to edit command in terminal mode.
		-- See https://github.com/nvim-telescope/telescope.nvim/pull/656/files
		{ 'n', '<space>c', ':Telescope command_history<cr>', opts },
		{
			'v',
			'<space>c',
			function()
				local text = util.getVisualSelection()
				tb.command_history({ default_text = text })
			end,
			{ silent = true, desc = 'List command history with selection' },
		},

		{ 'n', '<space>h', ':Telescope help_tags<cr>', opts },
		{
			'v',
			'<space>h',
			function()
				local text = util.getVisualSelection()
				tb.help_tags({ default_text = text })
			end,
			{ silent = true, desc = 'List help documents with selection' },
		},

		{ 'n', '<space>H', ':Telescope highlights<cr>', opts },
		{
			'v',
			'<space>H',
			function()
				local text = util.getVisualSelection()
				tb.highlights({ default_text = text })
			end,
			{ silent = true, desc = 'List highlights with selection' },
		},

		{ 'n', '<space>k', ':Telescope keymaps<cr>', opts },
		{
			'v',
			'<space>k',
			function()
				local text = util.getVisualSelection()
				tb.keymaps({ default_text = text })
			end,
			{ silent = true, desc = 'List keymaps with selection' },
		},

		-- {'n', '<space>b', ':Telescope buffers<cr>', opts}, -- Use :Neotree buffers instead.
		{ 'n', '<space>d', ':Telescope diagnostics<cr>', opts },
		{ 'n', '<space>s', ':Telescope search_history<cr>', opts },
		{ 'n', '<space>S', ':Telescope spell_suggest<cr>', opts },
		{ 'n', '<space>j', ':Telescope jumplist<cr>', opts },
		{ 'n', '<space>v', ':Telescope vim_options<cr>', opts },
		{ 'n', '<space>y', ':Telescope registers<cr>', opts },
		{ 'n', '<space>r', ':Telescope oldfiles<cr>', opts },

		-- Override lsp keymaps. Use rmagatti/goto-preview instead.
		-- {'n', 'gi', ':Telescope lsp_implementations<cr>', opts},
		-- {'n', 'gd', ':Telescope lsp_definitions jump_type=split<cr>', opts},
		-- {'n', 'gr', ':Telescope lsp_references<cr>', opts},
		-- {'n', 'gt', ':Telescope lsp_type_definitions<cr>', opts},

	}

	local has_notify = pcall(require, 'notify')
	if has_notify then table.insert(map, { 'n', '<space>n', ':Telescope notify<cr>', opts }) end

	return map
end

M.highlights = {
	{ 'TelescopeResultsBorder', { fg = color.white, bg = 'none' } },
	{ 'TelescopePreviewBorder', { fg = color.white, bg = 'none' } },
	{ 'TelescopePromptBorder', { fg = color.white, bg = 'none' } },
	{ 'TelescopeBorder', { fg = color.blue, bg = 'none' } },
	{ 'TelescopePromptPrefix', { fg = color.blue, bg = 'none' } },
	{ 'TelescopeSelection', { fg = 'none', bg = color.grey1 } },
	{ 'TelescopeSelectionCaret', { fg = color.blue, bg = 'none' } },
	{ 'TelescopeMatching', { fg = color.orange, bg = 'none', underline = true } },
}

return M
