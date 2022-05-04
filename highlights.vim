" ------------------------- General Highlights -------------------------
highlight InactiveWindow ctermbg=234
set winhighlight=NormalNC:InactiveWindow

highlight Pmenu cterm=NONE ctermfg=251 ctermbg=235 guibg=Grey
highlight PmenuSel cterm=NONE ctermfg=232 ctermbg=246 guibg=DarkGrey
highlight PmenuSbar cterm=NONE ctermfg=234 ctermbg=234 guibg=Grey
highlight PmenuThumb cterm=NONE ctermfg=247 ctermbg=247 guibg=White

" ------------------------ Plugin Highlights ---------------------------

" vim-bookmarks
highlight BookmarkSign ctermbg=234 ctermfg=27
highlight BookmarkLine ctermbg=NONE ctermfg=NONE
highlight BookmarkAnnotationSign ctermbg=234 ctermfg=35
highlight BookmarkAnnotationLine ctermbg=NONE ctermfg=NONE

" ShowTrailingWhitespace
highlight ShowTrailingWhitespace ctermbg=1 guibg=Grey

" gitgutter
highlight link GitGutterAdd DiffAdd
highlight link GitGutterChange DiffChange
" highlight! link GitGutterDelete DiffDelete
highlight GitGutterDelete guifg=#BF3100 guibg=none guisp=none ctermfg=12 ctermbg=0 guisp=none

" LSP: Highlight symbol under cursor
highlight LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
highlight LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
highlight LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
