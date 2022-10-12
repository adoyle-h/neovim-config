local config = require('adoyle-neovim-config.config').config
local colors = config.colors

local M = {
	'telescope',

	requires = {
		'nvim-telescope/telescope.nvim',
		'nvim-telescope/telescope-ui-select.nvim', -- improve the default vim.ui interfaces, like lsp.buf.code_action
		require('adoyle-neovim-config.plugins.telescope.emoji'),
		require('adoyle-neovim-config.plugins.telescope.tab'),
		require('adoyle-neovim-config.plugins.telescope.env'),
	},

	keymaps = require('adoyle-neovim-config.plugins.telescope.keymaps'),
}

M.highlights = {
	{ 'TelescopeResultsBorder', { fg = colors.white, bg = 'none' } },
	{ 'TelescopePreviewBorder', { fg = colors.white, bg = 'none' } },
	{ 'TelescopePromptBorder', { fg = colors.white, bg = 'none' } },
	{ 'TelescopeBorder', { fg = colors.blue, bg = 'none' } },
	{ 'TelescopePromptPrefix', { fg = colors.blue, bg = 'none' } },
	{ 'TelescopeSelection', { fg = 'none', bg = colors.darkBlue } },
	{ 'TelescopeSelectionCaret', { fg = colors.blue, bg = 'none' } },
	{ 'TelescopeMatching', { fg = colors.orange, bg = 'none', underline = true } },
}

function M.config()
	local telescope = require('telescope')

	telescope.setup(config.telescope.main)

	telescope.load_extension('ui-select')

	if pcall(require, 'notify') then telescope.load_extension('notify') end
end

M.defaultConfig = function()
	local action_state = require('telescope.actions.state')
	local actions = require('telescope.actions')
	local api = vim.api

	return {
		{ 'telescope', 'main' },
		{
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
					-- '--ignore-vcs',
					-- '--ignore-parent',
				},

				file_ignore_patterns = config.ignore.fileSearch.names,

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

				mappings = {
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
				},
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

			extensions = { ['ui-select'] = { layout_config = { width = 0.4, height = 16 } } },
		},
	}
end

return M
