" reload nvim config
command! Reload :source ~/.config/nvim/init.vim
command! TrailingSpaces RemoveTrailingSpaces
command! ClearCRLF :%s///g
command! Q :q!
command! Qa :qa!
command! Format :Neoformat
command! JSONfy :%s/\v^( +)([^" ]+)(\ +)?:/\1"\2"\3:/g | echo 'JSONfy done'
command! ProfileStart :call ProfileStart()
command! ProfileEnd :profile pause
command! FixLineBreak :call FixLineBreak()
command! CD :lcd %:p:h

function! s:OpenConfig()
  let home = coc#util#get_config_home()
  if home =~# '^\~'
    let home = substitute(home, '\~', $HOME,'')
  endif
  if !isdirectory(home)
    call mkdir(home, 'p')
  endif
  execute 'vs '.home.'/coc-settings.json'
endfunction

" This function not works with vim-plug lazy-load feature
function! PlugLoaded(name)
  return (stridx(&rtp, $NVIM_HOME.'/plugged/'.a:name) >= 0)
endfunction

function! ProfileStart()
  profile start profile.log
  profile func *
  profile file *
endfunc

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc

function! GetSnipsInCurrentScope()
  return UltiSnips#SnippetsInCurrentScope()
endfunction


function! FixLineBreak()
  e ++ff=dos
  set ff=unix
  w
endfunction

function! ShowHighlight()
  for i1 in synstack(line("."), col("."))
    let i2 = synIDtrans(i1)
    let n1 = synIDattr(i1, "name")
    let n2 = synIDattr(i2, "name")
    echo n1 "->" n2
  endfor
endfunction
map <silent>gh :call ShowHighlight()<CR>
