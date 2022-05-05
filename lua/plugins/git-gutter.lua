local M = {
	'airblade/vim-gitgutter',
	desc = '侧边栏 Git 状态',
	disable = false,
}

function M.config()
	vim.g.gitgutter_map_keys = 0
	vim.g.gitgutter_preview_active = 0
	vim.g.gitgutter_last_line_number = 0
	vim.g.gitgutter_sign_added = '┃'
	vim.g.gitgutter_sign_modified = '┃'
	vim.g.gitgutter_sign_removed            = '_'
	vim.g.gitgutter_sign_removed_first_line = '‾'
	vim.g.gitgutter_sign_removed_above_and_below = 'ニ'
	vim.g.gitgutter_sign_modified_removed = '⋍'

	vim.cmd [[
		hi GitGutterDelete guifg=#BF3100 guibg=none guisp=none ctermfg=9 ctermbg=0 guisp=none
		hi GitGutterAdd guifg=#75C44E guibg=none guisp=none ctermfg=10 ctermbg=0 guisp=none
		hi GitGutterChange guifg=#C3B11A guibg=none guisp=none ctermfg=10 ctermbg=0 guisp=none

		au CursorMoved * if g:gitgutter_preview_active && exists('*gitgutter#utility#is_active') && gitgutter#utility#is_active() && line('.') != g:gitgutter_last_line_number |
		\   let g:gitgutter_last_line_number = line('.') |
		\   if empty(gitgutter#hunk#current_hunk()) |
		\     pclose |
		\   else |
		\     call gitgutter#preview_hunk() |
		\   endif |
		\ endif
	]]
end

return M
