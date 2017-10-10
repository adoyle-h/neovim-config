autocmd BufRead *.js set isk-=.
autocmd BufRead *.jsx set isk-=.

autocmd FileType javascript set formatprg=prettier\ --stdin

autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

autocmd filetype crontab setlocal nobackup nowritebackup
