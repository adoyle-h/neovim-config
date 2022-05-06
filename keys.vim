" ------------------------------------------------------------------
" |                  All keymaps showing here                      |
" ------------------------------------------------------------------

" set a map <leader> for more key combos
let mapleader = ';'

" ------------------------ F1~F9 Keymap ----------------------------
" Prevent <F1> key from opening system help window. You can use ":help" to open vim help window
noremap <F1> <Esc>

" ------------------------- General Keymap -------------------------

" disable Ex mode
noremap Q <NOP>

" swap adjacent characters
noremap t xp
noremap T Xp

" Exit from input mode
inoremap jk <Esc>
" Exit from terminal mode
tnoremap kj <C-\><C-n>

" select all
nnoremap <leader>sa ggVG

" enable . command in visual mode
vnoremap . :normal .<CR>

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" ------------------------ Toggles Keymap --------------------------
noremap <leader>N :call NumberToggle()<CR>
noremap <silent> <leader>L :set relativenumber! number!<CR>
" toggle invisible characters
noremap <leader>l :set list!<CR>
" toggle scrolloff
noremap <leader>so :let &scrolloff=999-&scrolloff<CR>
" toggle spell-checking
noremap <M-s> :set invspell<CR>

" -------------------------- Jump Keymap ---------------------------
" jump to previous cursor position
nnoremap go <C-o>
" jump reverse to previous cursor position
nnoremap gi <C-i>

" -------------------------- Fold Keymap ---------------------------
" When cursor on a closed fold: open it. When cursor on an open fold, close it.
nnoremap <Tab> za
" Similar to <Tab>, but effect all paragraphs in same fold level.
nnoremap <M-Tab> :call IndentToLevel()<CR>

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

" ------------------------- M- Keymap ------------------------------
nnoremap <M-g> :echo expand('%:p')<CR>
