local util = require('adoyle-neovim-config.util')

local M = {
	'nvim-telescope/telescope.nvim',
	requires = {
		{
			'keyvchan/telescope-find-pickers.nvim',
			desc = 'Find all pickers available (includes builtins and extensions)',
		},
	},
}

function M.config(config)
	local telescope = require('telescope')

	telescope.setup(config.telescope.main)
	telescope.load_extension('find_pickers')

	if pcall(require, 'notify') then telescope.load_extension('notify') end
end

M.defaultConfig = function(config)
	local action_state = require('telescope.actions.state')
	local actions = require('telescope.actions')
	local previewers = require('telescope.previewers')
	local api = vim.api

	local file_ignore_patterns = {}
	util.tbl_concat(file_ignore_patterns, config.ignore.fileSearch.files)
	for _, value in pairs(config.ignore.fileSearch.directories) do
		file_ignore_patterns[#file_ignore_patterns + 1] = value:gsub('%.', '%%.') .. '/' -- test ./lua/adoyle-neovim-config/plugins/git/sign.lua
	end

	return {
		{ 'telescope', 'main' },
		{
			defaults = {
				prompt_prefix = ' ',
				scroll_strategy = 'limit',
				layout_strategy = 'vertical',
				sorting_strategy = 'ascending',
				preview = true,
				dynamic_preview_title = true,

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
					'--trim',
					-- '--ignore-vcs',
					-- '--ignore-parent',
				},

				-- A table of lua regex that define the files that should be ignored.
				-- Example: { "^scratch/" } -- ignore all files in scratch directory
				-- Example: { "%.npz" } -- ignore all npz files
				-- See: https://www.lua.org/manual/5.1/manual.html#5.4.1 for more information about lua regex
				-- Note: `file_ignore_patterns` will be used in all pickers that have a file associated.
				-- This might lead to the problem that lsp_ pickers aren't displaying results
				-- because they might be ignored by `file_ignore_patterns`.
				-- For example, setting up node_modules as ignored will never show node_modules in any results,
				-- even if you are interested in lsp_ results.
				--
				-- If you only want `file_ignore_patterns` for `find_files` and `grep_string`/`live_grep`
				-- it is suggested that you setup `gitignore` and have fd and or ripgrep installed
				-- because both tools will not show `gitignore`d files on default.
				file_ignore_patterns = file_ignore_patterns,

				path_display = {
					shorten = {
						len = 2, -- shorten into 2 letters
						exclude = { 1, -2, -1 }, -- exclude the first, the last and last second words in path
					},
				},

				-- :h telescope.layout
				layout_config = {
					center = { height = 0.4, prompt_position = 'top', width = 0.8, preview_cutoff = 0 },

					cursor = { --
						height = { 0.4, min = 6, max = 10 },
						width = { 0.4, min = 10, max = 30 },
						preview_cutoff = 0,
					},

					horizontal = {
						height = { 0.8, min = 30, max = 80 },
						width = { 0.94, min = 100, max = 130 },
						preview_width = 80,
						prompt_position = 'bottom',
						preview_cutoff = 0,
					},

					vertical = {
						preview_height = { 0.4, min = 10, max = 30 },
						height = { 0.8, min = 30, max = 80 },
						width = { 0.8, min = 80, max = 130 },
						preview_cutoff = 0,
						prompt_position = 'top', -- 'top' or 'bottom'
					},
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

			file_previewer = previewers.vim_buffer_cat.new({
				---@diagnostic disable-next-line: unused-local
				dynamic_title = function(self, entry)
					return entry.path
				end,
			}),

			pickers = {

				find_files = {
					hidden = true,
					path_display = {}, -- Display full filepath
					layout_config = {},
				},

				oldfiles = {
					path_display = {}, -- Display full filepat
				},

				commands = { layout_config = { width = { 0.9, min = 80, max = 130 } } },

				help_tags = { layout_strategy = 'horizontal' },

				git_files = {
					path_display = {}, -- Display full filepat
				},

				highlights = {
					theme = 'dropdown',
					mappings = {
						i = {
							['<CR>'] = function(prompt_bufnr)
								local entry = action_state.get_selected_entry(prompt_bufnr)
								actions.close(prompt_bufnr)
								local text = api.nvim_replace_termcodes(string.format(':hi %s ', entry.value), true, false,
									true)
								api.nvim_feedkeys(text, 't', true)
							end,
						},
					},
				},

				buffers = {},

				live_grep = {},

				current_buffer_fuzzy_find = {},

				spell_suggest = { layout_strategy = 'cursor' },

				diagnostics = {},

			},

			extensions = {},
		},
	}
end

return M
