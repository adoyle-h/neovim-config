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
highlight CocErrorHighlight cterm=NONE ctermfg=0 ctermbg=1
highlight CocWarningSign cterm=bold ctermfg=11 ctermbg=234
highlight CocWarningHighlight cterm=NONE ctermfg=0 ctermbg=11
highlight CocHintSign cterm=bold ctermfg=2 ctermbg=234
highlight CocInfoHighlight cterm=NONE ctermfg=0 ctermbg=2
highlight CocInfoSign cterm=bold ctermfg=6 ctermbg=234
highlight CocHintHighlight cterm=NONE ctermfg=0 ctermbg=6
highlight CocFloating cterm=NONE ctermfg=7 ctermbg=236
highlight CocErrorFloat cterm=NONE ctermfg=1 ctermbg=236
highlight CocWarningFloat cterm=NONE ctermfg=11 ctermbg=236
highlight default link CocInfoFloat CocFloating
highlight CocHintFloat cterm=NONE ctermfg=2 ctermbg=236

" ShowTrailingWhitespace
highlight ShowTrailingWhitespace ctermbg=1 guibg=1
