" set a map leader for more key combos
let mapleader = ';'

" 废弃 F1 这个键，防止调出系统帮助。可以使用 :help 来调出 vim 帮助
noremap <F1> <Esc>
noremap <silent><F2> :NERDTreeTabsToggle<CR>
noremap <silent><F3> :Tagbar<CR>
noremap <silent><F5> :UndotreeToggle<CR>

noremap <leader>C :ClearSearch<CR>

noremap <leader>nt :NERDTreeTabsToggle<CR>
noremap <leader>nm :NERDTreeMirrorToggle<CR>
noremap <leader>nf :NERDTreeTabsFind<CR>

" 复制选中区到系统剪切板中
vnoremap <leader>y "+y
" y$ -> Y Make Y behave like other capitals
nnoremap Y y$

nnoremap <leader>p "0p
xnoremap <leader>p "0p

" Exit from input mode
inoremap jk <Esc>
" Exit from terminal mode
tnoremap kj <C-\><C-n>

" ------------ M- Keymaps ------------
nnoremap <M-g> :echo expand('%:p')<CR>
nnoremap <M-v> ^v$

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv
nnoremap > >>
nnoremap < <<
" nnoremap <S-tab> <<
inoremap <S-Tab> <C-d>
" 缩进当前行所在段落
nnoremap <Tab> za
" 按当前行的缩进，缩进所有同 level 的段落
nnoremap <M-Tab> :call IndentToLevel()<CR>
" 因为 YCM 的影响，insert mode 下 tab 键被占用
" 不能重定义 tab，因为 tab 和 <C-I> 绑定在一起的
"nnoremap <tab> >>

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" window 相关
noremap <C-W>N :vnew<CR>
nmap <C-W>h <C-W>h
nmap <C-W>j <C-W>j
nmap <C-W>k <C-W>k
nmap <C-W>l <C-W>l
nmap <C-W>H <C-W>5<<C-W>
nmap <C-W>J <C-W>5+<C-W>
nmap <C-W>K <C-W>5-<C-W>
nmap <C-W>L <C-W>5><C-W>
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
noremap <C-W>z :MaximizerToggle!<CR>
" " vim-windowswap
" let g:windowswap_map_keys = 0 "prevent default bindings
" nnoremap <C-W>w :call WindowSwap#EasyWindowSwap()<CR>

"" tab 相关
let g:lasttab = 1
noremap <leader>tl :execute "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
noremap <leader>tx :tabclose<CR>
noremap <leader>tj :tabnext<CR>
noremap <leader>tk :tabprev<CR>
noremap <leader>tn :tabnew<CR>
noremap <C-t>x :tabclose<CR>
noremap <C-t>j :tabnext<CR>
noremap <C-t>k gT
noremap <C-t>n :tabnew<CR>
noremap <C-t>h :tabmove -<CR>
noremap <C-t>l :tabmove +<CR>
inoremap <C-t>n <Esc>:tabnew<CR>

" normal模式下切换到确切的tab
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


" buffer 相关
noremap <leader>bj :bn<CR>
noremap <leader>bk :bp<CR>
noremap <leader>bd :bd<CR>

" clear highlighted search
noremap <leader>h :set hlsearch! hlsearch?<CR>

" normal 模式下加空格
nnoremap <space> i<space><esc>
nnoremap ]<space> a<space><esc>
nnoremap [<space> i<space><esc>

" 加新行
nnoremap <silent><C-k> :put! =''<CR>j
nnoremap <silent><C-j> :put =''<CR>k
" split line
nnoremap K i<Enter><Esc>

" shortcut to save
nnoremap <leader>w :w<CR>
nnoremap <leader>q :close<CR>
nnoremap <leader>e :e<CR>

" disable Ex mode
noremap Q <NOP>


" activate spell-checking alternatives
noremap <leader>S :set invspell<CR>
" toggle invisible characters
noremap <leader>l :set list!<CR>
" select all
nnoremap <leader>sa ggVG
" toggle scrolloff
noremap <leader>so :let &scrolloff=999-&scrolloff<CR>
noremap <leader>N :call NumberToggle()<CR>
noremap <leader>L :ToggleLineNumber<CR>
" toggle paste mode
noremap <leader>P :set paste!<CR>


" enable . command in visual mode
vnoremap . :normal .<CR>

" scroll the viewport faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" ------------------------ Pugins Keymap ----------------------------

" Unite
noremap <silent><leader>uf :call Unite_open("file")<CR>
"noremap <silent><leader>uF :call Unite_open("file_rec")<CR>
noremap <silent><leader>uF :call Unite_open("file_rec/neovim")<CR>
noremap <silent><leader>ud :call Unite_open("directory")<CR>
" noremap <silent><leader>ub :call Unite_open("buffer_tab")<CR>
noremap <silent><leader>ub :call Unite_open("buffer")<CR>
noremap <silent><leader>uc :call Unite_open("command")<CR>
noremap <silent><leader>ut :call Unite_open("tab")<CR>
noremap <silent><leader>ur :call Unite_open("register")<CR>
noremap <silent><leader>um :call Unite_open("bookmark")<CR>
noremap <silent><leader>uM :call Unite_open("mapping")<CR>
noremap <silent><leader>uy :call Unite_open("history/yank")<CR>
noremap <silent><leader>uj :call Unite_open("jump")<CR>
noremap <silent><leader>uo :call Unite_open("output")<CR>
noremap z= :call Unite_open("spell_suggest")<CR>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()

function! Unite_open(field)
  let a:command = "Unite -start-insert -prompt=>\   -prompt-focus -prompt-visible -direction=dynamicbottom -buffer-name=".a:field." ".a:field
  execute a:command
endfunction

function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  nmap <silent><buffer><expr> s unite#do_action('split')
  nmap <silent><buffer><expr> vs unite#do_action('vsplit')
  nmap <silent><buffer><expr> S unite#do_action('vsplit')
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction


" vim-easy-align
nmap <leader>A <Plug>(EasyAlign)
xmap <leader>A <Plug>(EasyAlign)
nmap <leader>a <Plug>(LiveEasyAlign)
xmap <leader>a <Plug>(LiveEasyAlign)

" vim-fuzzysearch
nmap <leader>/ :FuzzySearch<CR>

nmap <leader>f <Plug>CtrlSFPrompt
vmap <leader>f <Plug>CtrlSFVwordPath

" clever-f
"nnoremap f <Plug>(clever-f-f)
"xnoremap f <Plug>(clever-f-f)
"onoremap f <Plug>(clever-f-f)
"nnoremap F <Plug>(clever-f-F)
"xnoremap F <Plug>(clever-f-F)
"onoremap F <Plug>(clever-f-F)
"nnoremap t <Plug>(clever-f-t)
"xnoremap t <Plug>(clever-f-t)
"onoremap t <Plug>(clever-f-t)
"nnoremap T <Plug>(clever-f-T)
"xnoremap T <Plug>(clever-f-T)
"onoremap T <Plug>(clever-f-T)
"nnoremap f :call clever_f#find_with('f')<Cr>
"xnoremap f :call clever_f#find_with('f')<Cr>
"onoremap f :call clever_f#find_with('f')<Cr>
"nnoremap F :call clever_f#find_with('F')<Cr>
"xnoremap F :call clever_f#find_with('F')<Cr>
"onoremap F :call clever_f#find_with('F')<Cr>
"nnoremap t :call clever_f#find_with('t')<Cr>
"xnoremap t :call clever_f#find_with('t')<Cr>
"onoremap t :call clever_f#find_with('t')<Cr>
"nnoremap T :call clever_f#find_with('T')<Cr>
"xnoremap T :call clever_f#find_with('T')<Cr>
"onoremap T :call clever_f#find_with('T')<Cr>

" vim-visualstar, 不能使用 xnoremap !
silent! xmap <C-n> <Plug>(visualstar-*)
silent! xmap <C-p> <Plug>(visualstar-#)
silent! xmap g<C-n> <Plug>(visualstar-g*)
silent! xmap g<C-p> <Plug>(visualstar-g#)

nnoremap <C-n> *
nnoremap <C-p> #
nnoremap g<C-n> g*
nnoremap g<C-p> g#

" vim-table-mode
noremap <leader>tm :TableModeToggle<CR>
noremap <leader>tc :echomsg TableModeChange()<CR>

" emacs editline
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

" syntastic
nnoremap <leader>sc :SyntasticCheck<CR>

" vim-node
autocmd User Node
  \ if &filetype == "javascript" |
  \   nmap <buffer> <C-W>f <Plug>NodeVSplitGotoFile |
  \   nmap <buffer> <C-W><C-f> <Plug>NodeVSplitGotoFile |
  \ endif

" vim-bookmarks
let g:bookmark_no_default_key_mappings = 1
function! BookmarkMapKeys()
    nmap mm :BookmarkToggle<CR>
    nmap mi :BookmarkAnnotate<CR>
    nmap mn :BookmarkNext<CR>
    nmap mp :BookmarkPrev<CR>
    nmap mj :BookmarkNext<CR>
    nmap mk :BookmarkPrev<CR>
    nmap ml :BookmarkShowAll<CR>
    nmap mx :BookmarkClear<CR>
    nmap mX :BookmarkClearAll<CR>
    nmap mK :BookmarkMoveUp<CR>
    nmap mJ :BookmarkMoveDown<CR>
endfunction
function! BookmarkUnmapKeys()
    unmap mm
    unmap mi
    unmap mn
    unmap mp
    unmap mj
    unmap mk
    unmap ml
    unmap mx
    unmap mX
    unmap mK
    unmap mJ
endfunction
autocmd BufEnter * :call BookmarkMapKeys()
autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()

" vim-gitgutter
nnoremap <leader>gk :GitGutterPrevHunk<CR>
nnoremap <leader>gj :GitGutterNextHunk<CR>

" vim-interestingwords
nnoremap <leader>ij :call WordNavigation('forward')<CR>
nnoremap <leader>ik :call WordNavigation('backward')<CR>

" increment-activator
nmap <leader>ii <Plug>(increment-activator-increment)<leader>i
nmap <leader>id <Plug>(increment-activator-decrement)<leader>i

" choose-win
nmap - <Plug>(choosewin)
