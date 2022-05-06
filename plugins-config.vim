" neovim
" let g:python_host_prog = '/usr/local/bin/python2'

" vim-visual-multi
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<M-n>' " replace C-n
let g:VM_maps['Find Subword Under'] = '<M-n>' " replace visual C-n

" vim-markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_fenced_languages = ['csharp=cs', 'js=javascript']
let g:vim_markdown_new_list_item_indent = 2

" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger='<tab>'
" let g:UltiSnipsListSnippets = '<C-tab>'
"let g:UltiSnipsJumpForwardTrigger='<C-n>'
"let g:UltiSnipsJumpBackwardTrigger='<C-p>'
let g:UltiSnipsSnippetsDir = $NVIM_HOME.'/UltiSnips'

" ctrlsf.vim
let g:ctrlsf_auto_close = 0
let g:ctrlsf_ignore_dir = ['bower_components', 'node_modules', 'vendor']
let g:ctrlsf_context = '-C 3'
let g:ctrlsf_follow_symlinks = 0

" vim-visualstar
let g:visualstar_no_default_key_mappings = 0

" vim-easy-align
let g:easy_align_delimiters = {
  \ '>': {
  \   'pattern': '>>\|=>\|>'
  \ },
  \ '/': {
  \   'pattern': '//\+\|/\*\|\*/',
  \   'delimiter_align': 'l',
  \   'ignore_groups':   ['!Comment']
  \ },
  \ ']': {
  \   'pattern': '[[\]]',
  \   'left_margin':   0,
  \   'right_margin':  0,
  \   'stick_to_left': 0
  \ },
  \ ')': {
  \   'pattern': '[()]',
  \   'left_margin':   0,
  \   'right_margin':  0,
  \   'stick_to_left': 0
  \ },
  \ 'd': {
  \   'pattern': ' \(\S\+\s*[;=]\)\@=',
  \   'left_margin':  0,
  \   'right_margin': 0
  \ }
  \}

" neoterm
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = '<leader>tt'

" vim-choosewin
" tmux-like overlay
let g:choosewin_overlay_enable = 0
let g:choosewin_statusline_replace = !g:choosewin_overlay_enable
let g:choosewin_tabline_replace = 0 " don't replace tabline
let g:choosewin_overlay_shade = 0
let g:choosewin_blink_on_land = 0 " don't blink at land
let g:choosewin_color_overlay = {
  \ 'cterm': [33, 33]
  \}
let g:choosewin_color_overlay_current = {
  \ 'cterm': [196, 196]
  \}
let g:choosewin_label_padding = 5
let g:choosewin_color_bg = 234
let g:choosewin_color_other = {
  \ 'cterm': [g:choosewin_color_bg, 0]
  \}
let g:choosewin_color_label = {
  \ 'cterm': [g:choosewin_color_bg, 33]
  \}
let g:choosewin_color_label_current = {
  \ 'cterm': [g:choosewin_color_bg, 196]
  \}
let g:choosewin_label = 'QWEASDZXC'
let g:choosewin_tablabel = '1234567890'
let g:choosewin_keymap = {
  \ '0':     '<NOP>',
  \ '[':     'tab_prev',
  \ ']':     'tab_next',
  \ '$':     '<NOP>',
  \ 'x':     '<NOP>',
  \ ';':     '<NOP>',
  \ '-':     'previous',
  \ 's':     'swap',
  \ 'S':     'swap_stay',
  \ "\<CR>": 'win_land',
  \ 'h':     'tab_first',
  \ 'k':     'tab_prev',
  \ 'j':     'tab_next',
  \ 'l':     'tab_last',
  \}

" neoformat
let g:neoformat_enabled_javascript = ['prettier', 'prettydiff', 'prettiereslint']

" gitv
let g:Gitv_OpenPreviewOnLaunch = 0
" let g:Gitv_PreviewOptions = '--stat'
let g:Gitv_CustomMappings = {
  \ 'let': '|',
  \ 'stat': 's',
  \ 'vstat': 's',
  \ 'head': 'H',
  \ 'delete': 'dd',
  \ 'vdelete': 'dd',
  \}

" vista.vim
" let g:vista_default_executive = 'coc'
" @TODO fix it
let g:vista_ctags_cmd = {
  \ 'go': 'gotags -sort -silent',
  \}

" Colorizer
let g:colorizer_auto_color = 1
let g:colorizer_auto_filetype='css,html,vim,markdown,js,jsx'
" let g:colorizer_skip_comments = 1

" winresizer
let g:winresizer_vert_resize = 5
let g:winresizer_horiz_resize = 3
