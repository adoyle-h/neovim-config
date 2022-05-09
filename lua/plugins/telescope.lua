local M = {
	'nvim-telescope/telescope.nvim',
	disable = false,
	requires = {
		'nvim-telescope/telescope-ui-select.nvim', -- improve the default vim.ui interfaces
	},
}

local function configHighlight()
	vim.cmd [[
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
	local opts = { noremap = true, silent = true }
	local keymap = vim.keymap.set

	-- nnoremap <space>f :lua require('telescope.builtin').find_files()<cr>
	keymap('n', '<space>;', ':Telescope builtin<cr>', opts)
	keymap('n', '<space>f', ':Telescope find_files hidden=true<cr>', opts)
	keymap('n', '<space>g', ':Telescope current_buffer_fuzzy_find<cr>', opts)
	keymap('n', '<space>G', ':Telescope live_grep<cr>', opts)
	keymap('n', '<space>b', ':Telescope buffers<cr>', opts)
	keymap('n', '<space>p', ':Telescope commands<cr>', opts)
	keymap('n', '<space>D', ':Telescope diagnostics<cr>', opts)
	keymap('n', '<space>h', ':Telescope help_tags<cr>', opts)
	keymap('n', '<space>H', ':Telescope highlights<cr>', opts)
	keymap('n', '<space>c', ':Telescope command_history<cr>', opts)
	keymap('n', '<space>s', ':Telescope search_history<cr>', opts)
	keymap('n', '<space>S', ':Telescope spell_suggest layout_strategy=cursor<cr>', opts)
	keymap('n', '<space>j', ':Telescope jumplist<cr>', opts)
	keymap('n', '<space>v', ':Telescope vim_options<cr>', opts)
	keymap('n', '<space>r', ':Telescope registers<cr>', opts)
	keymap('n', '<space>k', ':Telescope keymaps<cr>', opts)

	-- override lsp keymaps
	keymap('n', 'gI', ':Telescope lsp_implementations<cr>', opts)
	keymap('n', 'gd', ':Telescope lsp_definitions<cr>', opts)
	keymap('n', 'gr', ':Telescope lsp_references<cr>', opts)
	keymap('n', 'gt', ':Telescope lsp_type_definitions<cr>', opts)

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
	local telescope = require('telescope')

	telescope.setup {
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
					width = 0.8
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
			},

			highlights = {
				theme = "dropdown",
			},

			live_grep = {
				theme = "dropdown",
			},

			current_buffer_fuzzy_find = {
				theme = "dropdown",
			},
		},

		extensions = {
		}
	}

	telescope.load_extension('ui-select')


	configHighlight()
end

return M
