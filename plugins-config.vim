"" NERDTree
let NERDTreeShowBookmarks=1
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if (argc() == 0) && !exists("s:std_in") | NERDTreeToggle | endif

" NERDTree-git-plugin
let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "✶",
\ "Staged"    : "✚",
\ "Untracked" : "⭐︎",
\ "Renamed"   : "➜",
\ "Unmerged"  : "═",
\ "Deleted"   : "✖",
\ "Dirty"     : "%",
\ "Clean"     : "✔︎",
\ "Unknown"   : "?"
\ }

" NERDComment
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDCommentWholeLinesInVMode = 1

" indentline
let g:indentLine_color_term = 237
" let g:indentLine_char = '┆'
let g:indentLine_char = ''

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_error_symbol = ">>"
let g:syntastic_warning_symbol = ">"
let g:syntastic_style_error_symbol = "🚫"
let g:syntastic_style_warning_symbol = "⚡️"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_stl_format = '%E{First@%feL %e❌}%W{  %w⚠️}'

highlight SyntasticError ctermfg=235 ctermbg=196 cterm=underline
highlight SyntasticWarning ctermfg=235 ctermbg=220 cterm=underline
highlight SyntasticStyleError ctermfg=235 ctermbg=196 cterm=underline
highlight SyntasticStyleWarning ctermfg=235 ctermbg=220 cterm=underline

highlight SyntasticErrorSign ctermfg=235 ctermbg=196 cterm=bold
highlight SyntasticWarningSign ctermfg=235 ctermbg=220 cterm=bold
highlight SyntasticStyleErrorSign ctermfg=235 ctermbg=196 cterm=bold
highlight SyntasticStyleWarningSign ctermfg=235 ctermbg=220 cterm=bold

" vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<M-n>'
let g:multi_cursor_start_word_key='g<M-n>'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<C-c>'

" vim-markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_fenced_languages = ['csharp=cs', 'js=javascript']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

" Goyo
let g:goyo_width = '120' " (default: 80)
let g:goyo_height = '90%' " (default: 85%)
let g:goyo_linenr = 1 " (default: 0)

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  let &scrolloff=999-&scrolloff
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  let &scrolloff=999-&scrolloff
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" vim-airline
let g:airline_theme = 'bubblegum'
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tabs_label = 'Tab'
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " splits and tab number
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buffers_label = 'Buff'
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#ignore_bufadd_pat = '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_symbols.crypt = '🔒'
" let g:airline_left_sep = '▶︎'
" let g:airline_right_sep = '◀'
let g:airline_section_z = airline#section#create(['ts=%{&tabstop}|sw=%{&shiftwidth}|fdl=%{&foldlevel}', ' %4l/%LL+%-3c'])

" gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_modified_removed = '⋍'

" rainbow
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\   'ctermfgs': ['82', '27', '2', '3', '166', '4', '5', '6'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}

" MatchTagAlways
let g:mta_filetypes = {
\ 'html' : 1,
\ 'xhtml' : 1,
\ 'xml' : 1,
\ 'jinja' : 1,
\}
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 0
highlight MatchTag ctermfg=15 ctermbg=4

" easymotion
let g:EasyMotion_smartcase = 1
" 重复上一次操作, 类似repeat插件, 很强大
map <leader><leader>. <Plug>(easymotion-repeat)

" vim-closetag
let g:closetag_filenames = "*.html,*.xml,*.xhtml"

" vim-maximizer
let g:maximizer_set_default_mapping = 0

" editorconfig
let g:EditorConfig_core_mode = 'external_command'

" vim-table-mode
function! TableModeChange()
  if (b:table_mode_mode == 'Normal')
    let g:table_mode_corner = '|'
    let g:table_mode_separator = '|'
    let g:table_mode_fillchar = '-'
    let g:table_mode_corner_corner = '|'
    let g:table_mode_align_char = ':'
    let b:table_mode_mode = 'GFM'
  else
    let g:table_mode_corner = '+'
    let g:table_mode_separator = '|'
    let g:table_mode_fillchar = '-'
    let g:table_mode_corner_corner="+"
    let g:table_mode_align_char = ':'
    let b:table_mode_mode = 'Normal'
  endif
  return 'Table Mode: '.b:table_mode_mode
endfunc
autocmd BufNew,BufRead * let b:table_mode_mode = 'GFM'
autocmd BufNew,BufRead * call TableModeChange()

" tagbar
let g:tagbar_show_linenumbers = -1
let g:tagbar_sort = 0

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<C-n>"
"let g:UltiSnipsJumpBackwardTrigger="<C-p>"
let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
let g:UltiSnipsSnippetsDir = '$XDG_CONFIG_HOME/nvim/UltiSnips'

" YouCompleteMe
let g:ycm_server_keep_logfiles = 1
let g:ycm_confirm_extra_conf=0
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_complete_in_comments=1 " 补全功能在注释中同样有效
let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
let g:ycm_use_ultisnips_completer = 1 "提示UltiSnips
let g:ycm_collect_identifiers_from_comments_and_strings = 1   "注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_tags_files = 1  " 开启 YCM 基于标签引擎
let g:ycm_seed_identifiers_with_syntax=1 " 开启语法关键字补全
let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_key_invoke_completion = '<leader><tab>'  " 函数补全快捷键
let g:ycm_key_list_select_completion = ['<Down>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<Up>', '<C-k>']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filetype_blacklist = {
\ 'tagbar' : 1,
\ 'gitcommit' : 1,
\ 'ctrlsf': 1,
\ 'unite': 1,
\}
let g:ycm_filetype_specific_completion_to_disable = {
\ 'tagbar' : 1,
\ 'gitcommit' : 1,
\ 'ctrlsf': 1,
\ 'unite': 1,
\}

" vim-interestingwords
let g:interestingWordsTermColors = ['154', '99', '121', '212', '39', '166', '123', '214', '34', '222', '111', '33']
let g:interestingWordsRandomiseColors = 0

" undotree
if has("persistent_undo")
    set undodir=$NVIM_HOME/temp/undodir/
    set undofile
endif

" vim-javascript
let g:javascript_plugin_jsdoc = 1

" tern-for-vim
" 鼠标停留在方法内时显示参数提示
let g:tern_show_argument_hints = 'on_hold'
" 补全时显示函数类型定义
let g:tern_show_signature_in_pum = 1
let g:tern_map_keys = 1
let g:tern_map_prefix = ';'

" ctrlsf
let g:ctrlsf_auto_close = 0
let g:ctrlsf_ignore_dir = ['bower_components', 'npm_modules']

" vim-visualstar
let g:visualstar_no_default_key_mappings = 0

" clever-f.vim
let g:clever_f_show_prompt = 1
"let g:clever_f_not_overwrites_standard_mappings = 1

" unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_rec/neovim', 'ignore_pattern', 'node_modules/\|bower_components/')

if executable('ag')
    " Use ag (the silver searcher) https://github.com/ggreer/the_silver_searcher
    let g:unite_source_rec_async_command = ['ag', '--smart-case', '--nocolor', '--follow', '--vimgrep', '--hidden', '--nogroup', '-g', '']
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
    \ '--smart-case --nocolor --follow --vimgrep --hidden --nogroup -g ""' .
    \ '--ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr''' .
    \ '--ignore ''node_modules'' --ignore ''bower_components''' .
    \ ''
    let g:unite_source_grep_recursive_opt = ''
endif

" easy-align
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ 'd': {
\     'pattern':      ' \(\S\+\s*[;=]\)\@=',
\     'left_margin':  0,
\     'right_margin': 0
\   }
\ }

" vim-bookmarks
let g:bookmark_no_default_key_mappings = 1
