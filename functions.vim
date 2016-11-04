" reload nvim config
command! Reload :source ~/.config/nvim/init.vim
command! Path :echo expand('%:p')
command! ClearSearch :let @/ = ""
command! CursorColHL :set cursorcolumn!
command! TrailingSpaces FixWhitespace
command! Q :q!
command! Qa :qa!
command! Format :Autoformat
command! LimelightOff Limelight!
command! JSONfy :%s/\v^( +)([^" ]+)(\ +)?:/\1"\2"\3:/g | echo 'JSONfy done'

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc

function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction

function! IndentToLevel()
  let l = IndentLevel(line('.')) - 1
  if &fdl == l
    let &l:fdl = 99
  else
    let &l:fdl = l
  end
endfunction
