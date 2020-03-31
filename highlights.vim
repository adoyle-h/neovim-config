" ------------------------- General Highlights -------------------------
highlight InactiveWindow ctermbg=234
set winhighlight=NormalNC:InactiveWindow

" ------------------------ Plugin Highlights ---------------------------

" vim-bookmarks
highlight BookmarkSign ctermbg=234 ctermfg=27
highlight BookmarkLine ctermbg=NONE ctermfg=NONE
highlight BookmarkAnnotationSign ctermbg=234 ctermfg=35
highlight BookmarkAnnotationLine ctermbg=NONE ctermfg=NONE

" ale
highlight ALEErrorSign cterm=bold ctermfg=1 ctermbg=234
highlight ALEWarningSign cterm=bold ctermfg=11 ctermbg=234
highlight ALEError cterm=NONE ctermfg=0 ctermbg=1
highlight ALEWarning cterm=NONE ctermfg=0 ctermbg=11
highlight ALEErrorSignLineNr cterm=NONE ctermfg=0 ctermbg=1
highlight ALEStyleErrorSignLineNr cterm=NONE ctermfg=0 ctermbg=1
highlight ALEWarningSignLineNr ctermfg=0 ctermbg=11
highlight ALEStyleWarningSignLineNr ctermfg=0 ctermbg=11
highlight ALEInfoSignLineNr cterm=NONE ctermfg=0 ctermbg=6

" coc
highlight CocErrorSign cterm=bold ctermfg=1 ctermbg=234
highlight CocWarningSign cterm=bold ctermfg=11 ctermbg=234
highlight CocHintSign cterm=bold ctermfg=2 ctermbg=234
highlight CocInfoSign cterm=bold ctermfg=6 ctermbg=234

" ShowTrailingWhitespace
highlight ShowTrailingWhitespace ctermbg=1 guibg=1
