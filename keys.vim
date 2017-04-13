" ------------------------------------------------------------------
" |                  All keymaps showing here                      |
" ------------------------------------------------------------------

" set a map <leader> for more key combos
let mapleader = ';'

" ------------------------ F1~F9 Keymap ----------------------------
" 废弃 F1 这个键，防止调出系统帮助。可以使用 :help 来调出 vim 帮助
noremap <F1> <Esc>
noremap <silent><F2> :NERDTreeTabsToggle<CR>
noremap <silent><F3> :Tagbar<CR>
noremap <silent><F5> :UndotreeToggle<CR>
" ------------------------------------------------------------------

noremap <leader>C :ClearSearch<CR>

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

" Exit from input mode
inoremap jk <Esc>
" Exit from terminal mode
tnoremap kj <C-\><C-n>

" clear highlighted search
noremap <leader>h :set hlsearch! hlsearch?<CR>

" add spaces in normal mode
nnoremap <space> a<space><esc>
nnoremap ]<space> a<space><esc>
nnoremap [<space> i<space><esc>

" add blank before/after current line
nnoremap <silent><C-k> :put! =''<CR>j
nnoremap <silent><C-j> :put =''<CR>k
" split line
nnoremap K i<Enter><Esc>

" shortcut to save
nnoremap <leader>w :w<CR>
" shortcut to quit
nnoremap <leader>q :close<CR>
nnoremap <leader>Q :tabclose<CR>
" shortcut to refresh
nnoremap <leader>e :e<CR>

" disable Ex mode
noremap Q <NOP>

" toggle invisible characters
noremap <leader>l :set list!<CR>
" select all
nnoremap <leader>sa ggVG
" toggle scrolloff
noremap <leader>so :let &scrolloff=999-&scrolloff<CR>
noremap <leader>N :call NumberToggle()<CR>
noremap <leader>L :ToggleLineNumber<CR>
noremap <leader>I :IndentLinesToggle<CR>

" enable . command in visual mode
vnoremap . :normal .<CR>

" jumps
nnoremap go <C-o>
nnoremap gi <C-i>
nnoremap g. g;

" scroll the viewport faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

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


" ------------------------- M- Keymap ------------------------------
nnoremap <M-g> :echo expand('%:p')<CR>
nnoremap <M-v> ^v$
" activate spell-checking alternatives
noremap <M-s> :set invspell<CR>

" ----------------------- Window Keymap ----------------------------
noremap <C-W>N :vnew<CR>
nmap <C-W>h <C-W>h
nmap <C-W>j <C-W>j
nmap <C-W>k <C-W>k
nmap <C-W>l <C-W>l
nmap <C-W>H <C-W>5<<C-W>
nmap <C-W>J <C-W>5+<C-W>
nmap <C-W>K <C-W>5-<C-W>
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
noremap <C-W>z :MaximizerToggle!<CR>
" " vim-windowswap
" let g:windowswap_map_keys = 0 "prevent default bindings
" nnoremap <C-W>w :call WindowSwap#EasyWindowSwap()<CR>

" -------------------------- Tab Keymap ----------------------------
let g:lasttab = 1
noremap <leader>tl :execute "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
noremap <leader>tx :tabclose<CR>
noremap <leader>tj :tabnext<CR>
noremap <leader>tk :tabprev<CR>
noremap [t :tabprev<CR>
noremap ]t :tabnext<CR>
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

" ------------------------ Buffer Keymap ---------------------------
" noremap <leader>bj :bn<CR>
" noremap <leader>bk :bp<CR>
" noremap <leader>bd :bd<CR>

" ------------------------ Pugins Keymap ---------------------------

" NERDTreeTabsToggle
noremap <leader>nt :NERDTreeTabsToggle<CR>
noremap <leader>nm :NERDTreeMirrorToggle<CR>
noremap <leader>nf :NERDTreeTabsFind<CR>

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
    nmap ma :BookmarkAnnotate<CR>
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
    unmap ma
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
nmap <leader>gk <Plug>GitGutterPrevHunk
nmap <leader>gj <Plug>GitGutterNextHunk
nmap [g <Plug>GitGutterPrevHunk
nmap ]g <Plug>GitGutterNextHunk
nmap <leader>gp <Plug>GitGutterPreviewHunk
nmap <leader>gu <Plug>GitGutterUndoHunk
nmap <leader>ga <Plug>GitGutterStageHunk
nmap <leader>gl <Plug>GitGutterLineHighlightsToggle
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
nmap <leader>ij <Plug>InterestingWordsForeward
nmap <leader>ik <Plug>InterestingWordsBackward
nmap [k <Plug>InterestingWordsBackward
nmap ]k <Plug>InterestingWordsForeward

" increment-activator
nmap <leader>ii <Plug>(increment-activator-increment)<leader>i
nmap <leader>id <Plug>(increment-activator-decrement)<leader>i

" choose-win
nmap - <Plug>(choosewin)

" ale
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" accelerated-smooth-scroll
" nnoremap <silent> <C-d>
"     \ :<C-u>call ac_smooth_scroll#scroll('j', 2, g:ac_smooth_scroll_du_sleep_time_msec, 10)<CR>
" nnoremap <silent> <C-u>
"     \ :<C-u>call ac_smooth_scroll#scroll('k', 2, g:ac_smooth_scroll_du_sleep_time_msec, 10)<CR>
" nnoremap <silent> <C-f>
"     \ :<C-u>call ac_smooth_scroll#scroll('j', 4, g:ac_smooth_scroll_fb_sleep_time_msec, 10)<CR>
" nnoremap <silent> <C-b>
"     \ :<C-u>call ac_smooth_scroll#scroll('k', 4, g:ac_smooth_scroll_fb_sleep_time_msec, 10)<CR>

" CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
" sunmap w
" sunmap b
" sunmap e
" sunmap ge

" vim-abolish
" :h cr for more descriptions
" MixedCase (crm)
" camelCase (crc)
" snake_case (crs or cr_)
" SNAKE_UPPERCASE (cru)
" dash-case (cr-)
" kebab-case (crk)
" dot.case (cr.)
" space case (cr<space>)


" clever-f.vim
nmap <M-f> <Plug>(clever-f-f)
xmap <M-f> <Plug>(clever-f-f)
omap <M-f> <Plug>(clever-f-f)
nmap F <Plug>(clever-f-F)
xmap F <Plug>(clever-f-F)
omap F <Plug>(clever-f-F)
nmap t <Plug>(clever-f-t)
xmap t <Plug>(clever-f-t)
omap t <Plug>(clever-f-t)
nmap T <Plug>(clever-f-T)
xmap T <Plug>(clever-f-T)
omap T <Plug>(clever-f-T)

" easymotion
map f <Plug>(easymotion-prefix)
" 重复上一次操作, 类似repeat插件, 很强大
map f. <Plug>(easymotion-repeat)

" open-browser.vim
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" tern-for-vim
let tern_prefix = exists('g:tern_map_prefix') ? g:tern_map_prefix : "<LocalLeader>"
execute 'nnoremap '.tern_prefix.'tD' ':TernDoc<CR>'
execute 'nnoremap '.tern_prefix.'tb' ':TernDocBrowse<CR>'
execute 'nnoremap '.tern_prefix.'tt' ':TernType<CR>'
execute 'nnoremap '.tern_prefix.'td' ':TernDef<CR>'
execute 'nnoremap '.tern_prefix.'tp' ':TernDefPreview<CR>'
execute 'nnoremap '.tern_prefix.'ts' ':TernDefSplit<CR>'
" execute 'nnoremap '.tern_prefix.'ttd' ':TernDefTab<CR>'
execute 'nnoremap '.tern_prefix.'tr' ':TernRefs<CR>'
execute 'nnoremap '.tern_prefix.'tR' ':TernRename<CR>'
