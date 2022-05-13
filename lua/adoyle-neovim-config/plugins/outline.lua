local M = {
	'stevearc/aerial.nvim',
	desc = 'Outline',
	disable = false,
	requires = {},
}

function M.config()
	local keymap = vim.keymap.set

	keymap('n', '<space>o', '<cmd>AerialToggle<CR>', {
		noremap = true, silent = true, desc = 'Toggle the aerial window',
	})

	require('aerial').setup {
		highlight_on_hover = true,

		default_direction = 'right',

		min_width = 20,

		show_guides = true,

		guides = {
			-- When the child item has a sibling below it
			mid_item = "├─ ",
			-- When the child item is the last in the list
			last_item = "└─ ",
			-- When there are nested child guides to the right
			nested_top = "│ ",
			-- Raw indentation
			whitespace = "  ",
		},
	}
end

return M
