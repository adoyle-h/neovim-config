" ------------------------------------------------------------------
" |                  All keymaps showing here                      |
" ------------------------------------------------------------------

" set a map <leader> for more key combos
let mapleader = ';'

" ------------------------ F1~F9 Keymap ----------------------------
" Prevent <F1> key from opening system help window. You can use ":help" to open vim help window
noremap <F1> <Esc>
noremap <silent><F2> :Tagbar<CR>
noremap <silent><F3> :UndotreeToggle<CR>

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

" toggle scrolloff
noremap <leader>so :let &scrolloff=999-&scrolloff<CR>

" enable . command in visual mode
vnoremap . :normal .<CR>

" ---------------------- Insert Spaces Keymap ----------------------
" insert a space at right position of cursor
nnoremap <space> a<space><esc>
nnoremap ]<space> a<space><esc>
" insert a space at left position of cursor
nnoremap [<space> i<space><esc>

" add a blank line before current line
nnoremap <silent><C-k> :put! =''<CR>j
" add a blank line after current line
nnoremap <silent><C-j> :put =''<CR>k
" split line from current cursor position
nnoremap K i<Enter><Esc>

" ------------------------- Search Keymap --------------------------
" quick search word
nnoremap <C-n> *
nnoremap <C-p> #
nnoremap g<C-n> g*
nnoremap g<C-p> g#

" clear highlighted search
noremap <silent> <leader>C :ClearSearch<CR>:CocClear<CR>
" toggle highlighted search
noremap <leader>h :set hlsearch! hlsearch?<CR>

" ----------------------- Copy&Paste Keymap ------------------------
" copy selected into system clipboard
vnoremap <leader>y "+y
" y$ -> Y Make Y behave like other capitals: D, C etc...
nnoremap Y y$

" paste from vim clipboard
nnoremap <leader>p "0p
xnoremap <leader>p "0p
" paste from system clipboard
nnoremap <leader>P "*p
xnoremap <leader>P "*p
" toggle paste mode
noremap <M-p> :set paste!<CR>

" ------------------------ Toggles Keymap --------------------------
noremap <leader>N :call NumberToggle()<CR>
noremap <leader>L :ToggleLineNumber<CR>
" toggle invisible characters
noremap <leader>l :set list!<CR>
noremap <leader>I :IndentLinesToggle<CR>

" -------------------------- Jump Keymap ---------------------------
" jump to previous cursor position
nnoremap go <C-o>
" jump reverse to previous cursor position
nnoremap gi <C-i>

" ------------------------- Indent Keymap --------------------------
" indent line while keep visual selected
vnoremap < <gv
vnoremap > >gv
" indent line
nnoremap > >>
nnoremap < <<

" -------------------------- Fold Keymap ---------------------------
" When cursor on a closed fold: open it. When cursor on an open fold, close it.
nnoremap <Tab> za
" Similar to <Tab>, but effect all paragraphs in same fold level.
nnoremap <M-Tab> :call IndentToLevel()<CR>

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" ------------------------ Difftool Keymap -------------------------
if &diff
  map ,1 :diffget LOCAL<CR>
  map ,2 :diffget REMOTE<CR>
  map ,0 :diffget BASE<CR>
endif

" --------------------- Emacs Editline Keymap ----------------------
inoremap <silent> <C-a> <Esc>I
inoremap <silent> <C-e> <Esc>A
inoremap <silent> <C-b> <Esc>ha
inoremap <silent> <C-f> <Esc>la
inoremap <silent> <M-b> <Esc>bi
inoremap <silent> <M-f> <Esc>fi
inoremap <silent> <M-d> <Esc>dwa
inoremap <silent> <C-d> <Esc>dla
inoremap <silent> <C-w> <Esc>bdei
inoremap <silent> <C-k> <Esc>Da
inoremap <silent> <C-u> <Esc>d0

" ------------------------- M- Keymap ------------------------------
nnoremap <M-g> :echo expand('%:p')<CR>
nnoremap <M-v> ^v$
" activate spell-checking alternatives
noremap <M-s> :set invspell<CR>

" ----------------------- Window Keymap ----------------------------
" shortcut to save current buffer
nnoremap <leader>w :w<CR>
" shortcut to quit current window
nnoremap <leader>q :close<CR>
" shortcut to quit current tab
nnoremap <leader>Q :tabclose<CR>
" shortcut to refresh current window
nnoremap <leader>e :e<CR>

noremap <C-W>N :vnew<CR>
nmap <C-W>h <C-W>h
nmap <C-W>j <C-W>j
nmap <C-W>k <C-W>k
nmap <C-W>l <C-W>l
nmap <C-W>H <C-W>5<<C-W>
nmap <C-W>J <C-W>3+<C-W>
nmap <C-W>K <C-W>3-<C-W>
nmap <C-W>L <C-W>5><C-W>
nmap <C-W>< <C-W><<C-W>
nmap <C-W>+ <C-W>+<C-W>
nmap <C-W>- <C-W>-<C-W>
nmap <C-W>> <C-W>><C-W>
nnoremap <C-W><C-L> <C-W>L
nnoremap <C-W><C-H> <C-W>H
nnoremap <C-W><C-J> <C-W>J
nnoremap <C-W><C-K> <C-W>K
noremap <C-W>s\ <C-W>s
noremap <C-W>s\| <C-W>v
noremap <C-W>\ :new<CR>
noremap <C-W>\| :vnew<CR>
noremap <C-W>x <C-W>q
noremap <C-W>! <C-W>T
nmap <C-W>o <C-W>w<C-W>
nmap <C-W>O <C-W>W<C-W>

" vim-maximizer
noremap <silent> <C-W>z :MaximizerToggle!<CR>

" simeji/winresizer
let g:winresizer_start_key = '<C-W><C-W>'

" -------------------------- Tab Keymap ----------------------------
let g:lasttab = 1
noremap <leader>t- :execute "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

noremap <C-t>k :tabprev<CR>
noremap <C-t>j :tabnext<CR>
noremap [t :tabprev<CR>
noremap ]t :tabnext<CR>

noremap <C-t>h :tabmove -<CR>
noremap <C-t>l :tabmove +<CR>

noremap <C-t>n :tabnew<CR>
inoremap <C-t>n <Esc>:tabnew<CR>

noremap <C-t>x :tabclose<CR>

" switch tab in normal mode
noremap <C-t>1 1gt
noremap <C-t>2 2gt
noremap <C-t>3 3gt
noremap <C-t>4 4gt
noremap <C-t>5 5gt
noremap <C-t>6 6gt
noremap <C-t>7 7gt
noremap <C-t>8 8gt
noremap <C-t>9 9gt
noremap <C-t>0 :tablast<CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<CR>

" ------------------------ Plugin Keymap ---------------------------

" vim-nerdtree-tabs
noremap <silent> <leader>nt :NERDTreeTabsToggle<CR>
noremap <silent> <leader>nm :NERDTreeMirrorToggle<CR>
noremap <silent> <leader>nf :NERDTreeTabsFind<CR>

" defx.nvim
noremap <silent> <leader>m :Defx -toggle<CR>

" coc.nvim
"" coc

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rr <Plug>(coc-rename)

" Formatting code.
xmap <leader>=  <Plug>(coc-format-selected)
" nmap <leader>=  <Plug>(coc-format-selected)
nmap <leader>=  <Plug>(coc-format)

" Use <M-Tab> to trigger completion.
inoremap <silent><expr> <M-Tab> coc#refresh()

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \   coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \   <SID>check_back_space() ? "\<TAB>" :
  \   coc#refresh()

"" coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-l> <Plug>(coc-snippets-expand-jump)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-n>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-p>'

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

"" coc-list
noremap <silent><leader>uu :CocList -N<CR>
noremap <silent><leader>uf :CocList files<CR>
noremap <silent><leader>ue :CocList extensions<CR>
noremap <silent><leader>uc :CocList commands<CR>
noremap <silent><leader>ul :CocList lines<CR>
noremap <silent><leader>uhs :CocList searchhistory<CR>
noremap <silent><leader>uhc :CocList cmdhistory<CR>
noremap <silent><leader>uy :CocList -A yank<cr>
noremap <silent><leader>us :CocList snippets<CR>
noremap <silent><leader>uw :CocList windows<CR>
noremap <silent><leader>ub :CocList buffers<CR>
noremap <silent><leader>u/ :CocList words<CR>
noremap <silent><leader>ut :CocList translation<CR>
noremap <silent><leader>um :CocList marketplace<CR>

"" coc-translator
" popup window
nmap <Leader>tt <Plug>(coc-translator-p)
vmap <Leader>tt <Plug>(coc-translator-pv)
" echo
nmap <Leader>te <Plug>(coc-translator-e)
nmap <Leader>te <Plug>(coc-translator-ev)
" replace
nmap <Leader>tr <Plug>(coc-translator-r)
nmap <Leader>tr <Plug>(coc-translator-rv)

" vim-easy-align
nmap <leader>A <Plug>(EasyAlign)
xmap <leader>A <Plug>(EasyAlign)
nmap <leader>a <Plug>(LiveEasyAlign)
xmap <leader>a <Plug>(LiveEasyAlign)

" vim-fuzzysearch
nmap <leader>/ :FuzzySearch<CR>

" ctrlsf.vim
nmap <leader>f <Plug>CtrlSFPrompt
vmap <leader>f <Plug>CtrlSFVwordPath

" vim-visualstar
" xnoremap cannot work!
silent! xmap <C-n> <Plug>(visualstar-*)
silent! xmap <C-p> <Plug>(visualstar-#)
silent! xmap g<C-n> <Plug>(visualstar-g*)
silent! xmap g<C-p> <Plug>(visualstar-g#)

" vim-table-mode
noremap <leader>tm :TableModeToggle<CR>
noremap <leader>tc :echomsg TableModeChange()<CR>

" vim-node
autocmd User Node
  \ if &filetype == "javascript" |
  \   nmap <buffer> <C-W>f <Plug>NodeVSplitGotoFile |
  \   nmap <buffer> <C-W><C-f> <Plug>NodeVSplitGotoFile |
  \ endif

" vim-gitgutter
nmap <leader>gk <Plug>(GitGutterPrevHunk)
nmap <leader>gj <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)
nmap ]g <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>ga <Plug>(GitGutterStageHunk)
nmap <leader>gl <Plug>(GitGutterLineHighlightsToggle)
nmap <leader>gt :call ToggleGitGutterPreview()<CR>
nmap <leader>gc :pclose<CR>

function! ToggleGitGutterPreview()
  let g:gitgutter_preview_active = !g:gitgutter_preview_active
  if (g:gitgutter_preview_active)
    if (!empty(gitgutter#hunk#current_hunk()))
      call gitgutter#preview_hunk()
    endif
    echo 'GitGutter AutoPreview: on'
  else
    pclose
    echo 'GitGutter AutoPreview: off'
  endif
endfunction

" vim-interestingwords
" nmap <silent> <leader>k <Plug>InterestingWords " not work
nnoremap <silent> <leader>k :call InterestingWords('n')<CR>
vmap <silent> <leader>k <Plug>InterestingWords
nmap <silent> <leader>K <Plug>InterestingWordsClear
nmap [k <Plug>InterestingWordsBackward
nmap ]k <Plug>InterestingWordsForeward

" increment-activator
nmap <leader>ii <Plug>(increment-activator-increment)<leader>i
nmap <leader>id <Plug>(increment-activator-decrement)<leader>i

" vim-choosewin
nmap - <Plug>(choosewin)

" ale
" ale
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" CamelCaseMotion
" CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
noremap W w
noremap B b
noremap E e
noremap gE ge

" vim-abolish the default keymaps
" :h cr for more descriptions
" MixedCase (crm)
" camelCase (crc)
" snake_case (crs or cr_)
" SNAKE_UPPERCASE (cru)
" dash-case (cr-)
" kebab-case (crk)
" dot.case (cr.)
" space case (cr<space>)

" vim-easymotion
noremap f <Plug>(easymotion-prefix)
noremap f. <Plug>(easymotion-repeat)

" open-browser.vim
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nmap gX <Plug>(openbrowser-open)
vmap gX <Plug>(openbrowser-open)

" vim-which-key
nnoremap <silent> <leader><leader> :WhichKey ';'<CR>

" vim-bookmarks
nmap <Leader>bb <Plug>BookmarkToggle
nmap <Leader>ba <Plug>BookmarkAnnotate
nmap <Leader>bs <Plug>BookmarkShowAll
nmap <Leader>bl <Plug>BookmarkShowAll
nmap <Leader>bj <Plug>BookmarkNext<CR>k<Leader>b
nmap <Leader>bk <Plug>BookmarkPrev<CR>k<Leader>b
nmap <Leader>bc <Plug>BookmarkClear<CR>
nmap <Leader>bC <Plug>BookmarkClearAll
nmap <Leader>bK <Plug>BookmarkMoveUp<CR>k<Leader>b
nmap <Leader>bJ <Plug>BookmarkMoveDown<CR>k<Leader>b
nmap <Leader>bt <Plug>BookmarkMoveToLine

" vim-go
" Similar to gf. See https://vi.stackexchange.com/a/3369
au FileType go nmap <C-W>d <Plug>(go-def-vertical)
au FileType go nmap <C-W>gd <Plug>(go-def-tab)

" tagbar
noremap <leader>tb :TagbarOpen fj<CR>
noremap <leader>tB :TagbarToggle<CR>

" adoyle-h/vim-MarkdownTOC
nmap <Leader>toc :Toc<CR>
