" neovim
let g:python_host_prog = '/usr/local/bin/python2'

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

" limelight.vim
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" goyo.vim
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
let g:airline_powerline_fonts = 1

"" vim-airline extensions
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 0

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'

let g:airline#extensions#whitespace#skip_indent_check_ft = {
  \'go': ['mixed-indent-file', 'indent'],
\}

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 1 " show tab label
let g:airline#extensions#tabline#tabs_label = 'Tab'
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
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
let g:airline#extensions#tabline#formatter = 'short_path'
let g:airline#extensions#tabline#overflow_marker = '…'
let g:airline#extensions#tabline#tabtitle_formatter = 'MyAirlineTabTitleFormatter'
function MyAirlineTabTitleFormatter(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufnr = buflist[winnr - 1]
  let winid = win_getid(winnr, a:n)
  " let title = bufname(bufnr)
  let title = airline#extensions#tabline#get_buffer_name(bufnr, buflist)

  if empty(title)
    let title = '[No Name]'
  endif

  return title
endfunction

" Or Use ['all'] to enable for all filetypes.
let g:airline#extensions#wordcount#filetypes = [
  \'asciidoc', 'help', 'mail', 'markdown', 'org', 'rst', 'tex', 'text',
  \]

"" vim-airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.paste = 'Ƥ'
let g:airline_symbols.spell = 'Ȿ'
let g:airline_symbols.branch = ''
let g:airline_symbols.crypt = '🔒'

function! AirlineInit()
  " :h airline-predefined-parts
  " let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'keymap', 'spell', 'capslock', 'xkblayout', 'iminsert'])
  let g:airline_section_b = airline#section#create(['%l/%L|%c'])
  " let g:airline_section_x = airline#section#create_right(['bookmark', 'tagbar', 'vista', 'gutentags', 'grepper', 'filetype'])
  " let g:airline_section_y = airline#section#create_right([])
  let g:airline_section_z = airline#section#create([
    \'ts=%{&tabstop}|sw=%{&shiftwidth}|fdl=%{&foldlevel}',
  \])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" Default g:airline_mode_map is:
" let g:airline_mode_map = {
"   \ 's': 'SELECT',
"   \ 'V': 'V-LINE',
"   \ 'ni': '(INSERT)',
"   \ 'ic': 'INSERT COMPL',
"   \ 'R': 'REPLACE',
"   \ '^S': 'S-BLOCK',
"   \ 'no': 'OP PENDING',
"   \ '^V': 'V-BLOCK',
"   \ 'multi': 'MULTI',
"   \ '__': '------',
"   \ 'Rv': 'V REPLACE',
"   \ 'c': 'COMMAND',
"   \ 'ix': 'INSERT COMPL',
"   \ 'i': 'INSERT',
"   \ 'n': 'NORMAL',
"   \ 'S ': 'S-LINE',
"   \ 't': 'TERMINAL',
"   \ 'v': 'VISUAL',
"   \}
let g:airline_mode_map = {
  \ 'n': 'N',
  \ 'i': 'I',
  \ 'c': 'C',
  \ 'R': 'R',
  \ 's': 'S',
  \ 't': 'T',
  \ 'v': 'V',
  \ 'V': 'V-LINE',
  \ '^V': 'V-BLOCK',
  \ 'multi': 'M',
  \ 'S ': 'S-LINE',
  \ '^S': 'S-BLOCK',
  \ 'ni': '(INSERT)',
  \ 'ic': 'INSERT COMPL',
  \ 'no': 'OP PENDING',
  \ 'Rv': 'V REPLACE',
  \ 'ix': 'INSERT COMPL',
  \ '__': '------',
  \}

function! PatchInactiveStatusLine(...)
  call setwinvar(a:2.winnr, 'airline_section_a', '')
  call setwinvar(a:2.winnr, 'airline_section_b', '')
  call setwinvar(a:2.winnr, 'airline_section_x', '')
  call setwinvar(a:2.winnr, 'airline_section_y', '')
  call setwinvar(a:2.winnr, 'airline_section_z', '')
endfunction
call airline#add_inactive_statusline_func('PatchInactiveStatusLine')


" vim-easymotion
let g:EasyMotion_smartcase = 1

" vim-closetag
let g:closetag_filenames = "*.html,*.xml,*.xhtml,*.htm,*.jsx"

" vim-maximizer
let g:maximizer_set_default_mapping = 0

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

let g:table_mode_motion_up_map = '[{'
let g:table_mode_motion_down_map = ']}'
let g:table_mode_motion_left_map = '[['
let g:table_mode_motion_right_map = ']]'

" tagbar
let g:tagbar_autofocus = 1
let g:tagbar_case_insensitive = 1
let g:tagbar_sort = 1
let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds' : [
  \   'p:package',
  \   'i:imports:1',
  \   'c:constants',
  \   'v:variables',
  \   't:types',
  \   'n:interfaces',
  \   'w:fields',
  \   'e:embedded',
  \   'm:methods',
  \   'r:constructor',
  \   'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
  \   't' : 'ctype',
  \   'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
  \   'ctype' : 't',
  \   'ntype' : 'n'
  \ },
  \ 'ctagsbin'  : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
  \}

" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger='<tab>'
" let g:UltiSnipsListSnippets = '<C-tab>'
"let g:UltiSnipsJumpForwardTrigger='<C-n>'
"let g:UltiSnipsJumpBackwardTrigger='<C-p>'
let g:UltiSnipsSnippetsDir = $NVIM_HOME.'/UltiSnips'

" vim-interestingwords
let g:interestingWordsTermColors = [
  \ '33', '4', '210', '197', '78', '154', '99', '121', '212', '38',
  \ '166', '123', '214', '34', '222', '116', '207', '242',
  \]
let g:interestingWordsRandomiseColors = 0

" vim-javascript
let g:javascript_plugin_jsdoc = 1
" let g:javascript_conceal_function        = "⨕"
" let g:javascript_conceal_null            = "𝓝"
" let g:javascript_conceal_this            = "𝓣"
" let g:javascript_conceal_return          = "⏎"
" let g:javascript_conceal_undefined       = "𝕦"
" let g:javascript_conceal_NaN             = "ℕ"
" let g:javascript_conceal_prototype       = "𝓟"
" let g:javascript_conceal_static          = "𝕤"
" let g:javascript_conceal_super           = "𝓢"
" let g:javascript_conceal_arrow_function  = "➢"
" let g:javascript_conceal_noarg_arrow_function = "➤"
" let g:javascript_conceal_underscore_arrow_function = "⇢"

" vim-jsx
let g:jsx_ext_required = 1

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

" increment-activator
let g:increment_activator_no_default_key_mappings = 1
let g:increment_activator_filetype_candidates = {
  \ '_': [
  \   ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'],
  \   ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'],
  \   ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十'],
  \   ['none', 'debug', 'info', 'warn', 'error'],
  \   ['NONE', 'DEBUG', 'INFO', 'WARN', 'ERROR'],
  \   ['Todo', 'Done'],
  \   ['TODO', 'DONE'],
  \   ['todo', 'done'],
  \   ['low', 'normal', 'high'],
  \   ['LOW', 'NORMAL', 'HIGH'],
  \ ],
  \}

" vim-MarkdownTOC
let g:vmt_style = 'unordered'
let g:vmt_list_item_char = '-'
let g:vmt_fence_text = 'MarkdownTOC'
let g:vmt_fence_closing_text = '/'.g:vmt_fence_text
command! TocInsert GenTocGFM
command! TocUpdate UpdateToc

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

" ale
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'markdown': ['mdl'],
  \ 'jsx': ['stylelint', 'eslint'],
  \}
let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'css': ['stylelint'],
  \}
let g:ale_fix_on_save = 1
let g:ale_linter_aliases = {
  \ 'jsx': 'css',
  \}
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_statusline_format = ['E•%d', 'W•%d', '⬥ ok']
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warn'
let g:ale_echo_msg_format = '[%linter%][%severity%: %code%] %s'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_warn_about_trailing_whitespace = 1
" https://github.com/dense-analysis/ale#5iii-how-can-i-use-ale-and-cocnvim-together
let g:ale_disable_lsp = 1

"" ale - java
let g:ale_java_checkstyle_config = 'style_checks.xml'

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_format_strings = 1
let g:go_get_update = 0
let g:go_def_reuse_buffer = 1
let g:go_doc_keywordprg_enabled = 0


" neoformat
let g:neoformat_enabled_javascript = ['prettier', 'prettydiff', 'prettiereslint']

" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.

" vim-indexed-search
let g:indexed_search_shortmess = 1
let g:indexed_search_numbered_only = 1

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
