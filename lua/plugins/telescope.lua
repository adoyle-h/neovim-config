local M = {
	'nvim-telescope/telescope.nvim',
	disable = false,
	requires = {},
}

local function configHighlight()
	vim.cmd	[[
		hi TelescopeResultsBorder guifg=#CED3DC guibg=none guisp=none
		hi TelescopePreviewBorder guifg=#CED3DC guibg=none guisp=none
		hi TelescopeResultsBorder guifg=#CED3DC guibg=none guisp=none
		hi TelescopePromptBorder guifg=#CED3DC guibg=none guisp=none
		hi TelescopeBorder guifg=#87AFD7 guibg=none guisp=none
		hi TelescopePromptPrefix guifg=#87AFD7 guibg=none guisp=none
		hi TelescopeSelection guifg=none guibg=#18191B guisp=none
	]]
end

local function configMapping()
	vim.cmd [[
		" nnoremap <leader>uh :lua require('telescope.builtin').find_files()<cr>
		nnoremap <space>; :Telescope builtin<cr>
		nnoremap <space>f :Telescope find_files hidden=true<cr>
		nnoremap <space>g :Telescope current_buffer_fuzzy_find<cr>
		nnoremap <space>G :Telescope live_grep<cr>
		nnoremap <space>b :Telescope buffers<cr>
		nnoremap <space>p :Telescope commands<cr>
		nnoremap <space>D :Telescope diagnostics<cr>
		nnoremap <space>h :Telescope help_tags<cr>
		nnoremap <space>c :Telescope command_history<cr>
		nnoremap <space>s :Telescope search_history<cr>
		nnoremap <space>S :Telescope spell_suggest layout_strategy=cursor<cr>
		nnoremap <space>j :Telescope jumplist<cr>
		nnoremap <space>v :Telescope vim_options<cr>
		nnoremap <space>r :Telescope registers<cr>
		nnoremap <space>k :Telescope keymaps<cr>
	]]

	return {
		i = {
			-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
			["<C-s>"] = "select_horizontal",
			["<C-j>"] = "move_selection_next",
			["<C-k>"] = "move_selection_previous",
			-- clear inputs
			-- ["<C-u>"] = false,
			-- ["<C-d>"] = false,
			["<C-b>"] = 'results_scrolling_up',
			["<C-f>"] = 'results_scrolling_down',
		},

		n = {
			["<C-b>"] = 'results_scrolling_up',
			["<C-f>"] = 'results_scrolling_down',
		},
	}
end

function M.config()
	require('telescope').setup {
		defaults = {
			prompt_prefix = ' ',

			-- :h telescope.layout
			layout_config = {
				bottom_pane = {
					height = 25,
					preview_cutoff = 120,
					-- prompt_position valid values: top or bottom
					prompt_position = "top"
				},

				center = {
					height = 0.4,
					preview_cutoff = 40,
					prompt_position = "top",
					width = 0.6
				},

				cursor = {
					height = 0.4,
					preview_cutoff = 40,
					width = 0.8
				},

				horizontal = {
					height = 0.9,
					preview_cutoff = 120,
					prompt_position = "bottom",
					width = 0.9
				},

				vertical = {
					height = 0.9,
					preview_cutoff = 40,
					prompt_position = "bottom",
					width = 0.8
				}
			},

			mappings = configMapping(),
		},

		pickers = {
			find_files = {
				theme = "dropdown",
			}
		},

		extensions = {
			-- ...
		}
	}

	configHighlight()
end

return M
