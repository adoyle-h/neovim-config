local M = {
	"lukas-reineke/indent-blankline.nvim",
	disable = false,
}

function M.config()
	vim.cmd [[
		hi! IndentBlanklineChar cterm=nocombine gui=nocombine guifg=#18191B
		hi! IndentBlanklineContextStart cterm=NONE gui=NONE
	]]

	vim.g.indent_blankline_char = '│' -- '┊', '', '⎸'

	require("indent_blankline").setup {
		-- space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = true,
	}
end

return M
