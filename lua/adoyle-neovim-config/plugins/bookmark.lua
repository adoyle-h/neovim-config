local M = {
  'MattesGroeger/vim-bookmarks',
	desc = '书签',
	disable = false,
}

function M.config()
	vim.g.bookmark_no_default_key_mappings = 1
	vim.g.bookmark_sign = '笠'
	vim.g.bookmark_annotation_sign = 'ﰠ'
	vim.g.bookmark_highlight_lines = 1
	vim.g.bookmark_location_list = 1

	vim.cmd [[
		hi BookmarkSign ctermbg=234 ctermfg=27
		hi BookmarkLine ctermbg=NONE ctermfg=NONE
		hi BookmarkAnnotationSign ctermbg=234 ctermfg=35
		hi BookmarkAnnotationLine ctermbg=NONE ctermfg=NONE

		nmap <Leader>bb <Plug>BookmarkToggle
		nmap <Leader>ba <Plug>BookmarkAnnotate
		nmap <Leader>bs <Plug>BookmarkShowAll
		nmap <Leader>bl <Plug>BookmarkShowAll
		nmap <Leader>bj <Plug>BookmarkNext<CR>k<Leader>b
		nmap <Leader>bk <Plug>BookmarkPrev<CR>k<Leader>b
		nmap <Leader>bc <Plug>BookmarkClear<CR>
		nmap <Leader>bC <Plug>BookmarkClearAll
		nmap <Leader>bK <Plug>BookmarkMoveUp<CR>k<Leader>b
		nmap <Leader>bJ <Plug>BookmarkMoveDown<CR>k<Leader>b
		nmap <Leader>bt <Plug>BookmarkMoveToLine
	]]
end

return M
