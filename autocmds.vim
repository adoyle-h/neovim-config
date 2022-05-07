autocmd BufRead *.js set isk-=.
autocmd BufRead *.jsx set isk-=.

" autocmd FileType javascript set formatprg=prettier\ --stdin

autocmd filetype crontab setlocal nobackup nowritebackup
autocmd VimEnter * source $NVIM_HOME/abbreviations.vim
