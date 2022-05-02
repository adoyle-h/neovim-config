local M = {
	"lukas-reineke/indent-blankline.nvim",
	disable = false,
}

function M.config()
	-- vim.cmd [[highlight IndentBlanklineIndent1 ctermfg=#E06C75]]
	-- vim.cmd [[highlight IndentBlanklineIndent2 ctermfg=#E5C07B]]
	-- vim.cmd [[highlight IndentBlanklineIndent3 ctermfg=#98C379]]
	-- vim.cmd [[highlight IndentBlanklineIndent4 ctermfg=#56B6C2]]
	-- vim.cmd [[highlight IndentBlanklineIndent5 ctermfg=#61AFEF]]
	-- vim.cmd [[highlight IndentBlanklineIndent6 ctermfg=#C678DD]]
	-- vim.opt.termguicolors = true
	vim.cmd [[
		highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine
		highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine
		highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
		highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine
		highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
		highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine
	]]

	require("indent_blankline").setup {
		-- space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = true,
		char_highlight_list = {
			"IndentBlanklineIndent1",
			"IndentBlanklineIndent2",
			"IndentBlanklineIndent3",
			"IndentBlanklineIndent4",
			"IndentBlanklineIndent5",
			"IndentBlanklineIndent6",
		},
	}
end

return M
