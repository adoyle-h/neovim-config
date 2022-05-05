local M = {
	'lukas-reineke/indent-blankline.nvim',
	disable = false,
}

function M.config()
	vim.g.indent_blankline_char = '│' -- '┊', '', '⎸'

	-- hi IndentBlanklineContextStart cterm=nocombine gui=nocombine guisp=NONE
	vim.cmd [[
		hi IndentBlanklineChar cterm=nocombine gui=nocombine guifg=#18191B
		hi IndentBlanklineContextChar cterm=nocombine gui=nocombine guifg=#875FDF
	]]

	require("indent_blankline").setup {
		-- space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = false,
	}
end

return M
