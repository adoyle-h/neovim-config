local M = {
	'nvim-telescope/telescope.nvim',
	disable = false,
	requires = {},
}

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

			mappings = {
				i = {
					-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
					["<C-s>"] = "select_horizontal",
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
					-- clear inputs
					["<C-u>"] = false
				}
			},
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
end

return M
