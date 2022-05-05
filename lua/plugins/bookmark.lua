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
	]]
end

return M
