" ------------------------- General Highlights -------------------------
hi InactiveWindow ctermbg=234
set winhighlight=NormalNC:InactiveWindow

hi Pmenu cterm=NONE ctermfg=251 ctermbg=235 guibg=Grey
hi PmenuSel cterm=NONE ctermfg=232 ctermbg=246 guibg=DarkGrey
hi PmenuSbar cterm=NONE ctermfg=234 ctermbg=234 guibg=Grey
hi PmenuThumb cterm=NONE ctermfg=247 ctermbg=247 guibg=White

" ------------------------ Plugin Highlights ---------------------------

" vim-bookmarks
hi BookmarkSign ctermbg=234 ctermfg=27
hi BookmarkLine ctermbg=NONE ctermfg=NONE
hi BookmarkAnnotationSign ctermbg=234 ctermfg=35
hi BookmarkAnnotationLine ctermbg=NONE ctermfg=NONE

" ShowTrailingWhitespace
hi ShowTrailingWhitespace ctermbg=1 guibg=Grey

" gitgutter
" highlight link GitGutterAdd DiffAdd
" highlight link GitGutterChange DiffChange
" highlight link GitGutterDelete DiffDelete
hi GitGutterDelete guifg=#BF3100 guibg=none guisp=none ctermfg=9 ctermbg=0 guisp=none
hi GitGutterAdd guifg=#75C44E guibg=none guisp=none ctermfg=10 ctermbg=0 guisp=none
hi GitGutterChange guifg=#C3B11A guibg=none guisp=none ctermfg=10 ctermbg=0 guisp=none
" hi GitGutterChange guifg=#689AFD guibg=none guisp=none ctermfg=10 ctermbg=0 guisp=none

" LSP: Highlight symbol under cursor
hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow

hi IndentBlanklineChar cterm=nocombine gui=nocombine guifg=#18191B
hi IndentBlanklineContextChar cterm=nocombine gui=nocombine guifg=#875FDF
" hi IndentBlanklineContextStart cterm=nocombine gui=nocombine guisp=NONE
