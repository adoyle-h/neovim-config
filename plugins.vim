"Plug 'tpope/vim-vinegar'
"Plug 'MarcWeber/vim-addon-mw-utils' " interpret a file by function and cache file automatically
"Plug 'tomtom/tlib_vim' " utility functions for vim
"Plug 'xolox/vim-misc'

Plug 'johngrib/vim-game-snake', {'on': 'VimGameSnake'}
Plug 'lifepillar/vim-cheat40'

"" ========
Plug 'uguu-org/vim-matrix-screensaver', {'on': 'Matrix'}
Plug 'matze/vim-move' " 移动选定段落 <A-k> <A-j>
Plug 'MattesGroeger/vim-bookmarks'  " 书签管理器
Plug 'kassio/neoterm', {'on': ['T', 'Tnew', 'Tmap', 'Tpos', 'TTestSetTerm', 'TTestLib', 'TTestClearStatus', 'TREPLSetTerm', 'TREPLSendFile', 'TREPLSendLine', 'TREPLSendSelection', 'Topen', 'Ttoggle']}  " vim 内启动 shell
Plug 'adoyle-h/vim-emacscommandline'  " emacs 快捷键
Plug 'vasconcelloslf/vim-interestingwords'  " 高亮单词
"Plug 'kopischke/unite-spell-suggest'
Plug 'nishigori/increment-activator'
Plug 'guns/xterm-color-table.vim', {'on': ['XtermColorTable', 'SXtermColorTable', 'VXtermColorTable', 'TXtermColorTable', 'EXtermColorTable', 'OXtermColorTable']} " 终端颜色表
Plug 'majutsushi/tagbar', {'on': 'Tagbar'}  " 侧边栏索引
Plug 'terryma/vim-multiple-cursors'  " g:multi_cursor_start_key 不能绑定到 <CR> 或者 <C-m> 键，会出问题
Plug 'easymotion/vim-easymotion'  " 光标跳转
Plug 'bkad/CamelCaseMotion' " either CamelCase ('anIdentifier') or underscore_notation ('an_identifier')
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeMirrorToggle', 'NERDTreeTabsToggle', 'NERDTreeTabsFind', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'jistr/vim-nerdtree-tabs', {'on': ['NERDTreeMirrorToggle', 'NERDTreeTabsToggle', 'NERDTreeTabsFind', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeMirrorToggle', 'NERDTreeTabsToggle', 'NERDTreeTabsFind', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
"Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder
Plug 'shougo/unite.vim' "  search and display information from arbitrary sources like files, buffers, recently used files or registers.

"" brackets and tags matching
" Plug 'luochen1990/rainbow'  " 括号颜色配对。暂不开启，会影响到其他语法着色
Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
Plug 'Raimondi/delimitMate' " automatic closing of quotes, parenthesis, brackets, etc.
"Plug 'tpope/vim-unimpaired' " mappings which are simply short normal mode aliases for commonly used ex commands
Plug 'adoyle-h/vim-eunuch', {'branch': 'adoyle'}  " UNIX 命令封装。 :h eunuch
Plug 'tpope/vim-ragtag' " like closetag. endings for html, xml, etc. - enhance vim-surround
Plug 'alvan/vim-closetag'
" Plug 'Valloric/MatchTagAlways'  " 太慢，暂时关闭
Plug 'vim-scripts/matchit.zip' " extended % matching

Plug 'ap/vim-css-color'  " 显示颜色
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ggVGc/vim-fuzzysearch', {'on': 'FuzzySearch'}
Plug 'henrik/vim-indexed-search'  " 显示搜索查找到第几个
"Plug 'rking/ag.vim'
Plug 'dyng/ctrlsf.vim', {'on': ['<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordPath', 'CtrlSF']} " 项目内内容搜索
Plug 'thinca/vim-visualstar'  " visual 模型下查找增强
Plug 'scrooloose/nerdcommenter'  " 注释
Plug 'yggdroot/indentline'  " alt vim-indent-guides

Plug 'airblade/vim-gitgutter' " git 状态侧边栏
Plug 'tpope/vim-fugitive' " git 命令 in vim
Plug 'gregsexton/gitv' " git log in vim
Plug 'tpope/vim-repeat' " enables repeating other supported plugins with the . command
Plug 'szw/vim-maximizer'  " window 缩放
Plug 't9md/vim-choosewin' " window/tab 切换
Plug 'tyru/capture.vim'  " :Capture <命令> 将结果输出到新的 buffer 中
Plug 'tyru/open-browser.vim', {'on': ['<Plug>(openbrowser-smart-search)', '<Plug>(openbrowser-open)']}
Plug 'jpalardy/vim-slime', {'on': ['<Plug>SlimeRegionSend', '<Plug>SlimeParagraphSend', '<Plug>SlimeConfig']}  " 将 vim 里的内容发送到 tmux 的任意 pane 里

"" utilities
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session' " improve :mksession
"Plug 'sickill/vim-pasta' " context-aware pasting
Plug 'tpope/vim-sleuth' " 根据上下文自动调整 shiftwidth expandtab
Plug 'AndrewRadev/splitjoin.vim' " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one

Plug 'chrisbra/vim-diff-enhanced'
Plug 'chrisbra/Recover.vim'   " 崩溃后打开 swap 文件 diff
" Plug 'wesQ3/vim-windowswap'  " window 窗口交换

"" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " vim-snippets depends on ultisnips
Plug 'justinj/vim-react-snippets'
Plug 'ahmedelgabri/vim-ava-snippets'
"Plug 'ervandew/supertab' " Perform all your vim insert mode completions with Tab
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

" ycmd
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " 自动补全

Plug 'tpope/vim-abolish'  " fix typo and Coercion https://github.com/tpope/vim-abolish#coercion
Plug 'editorconfig/editorconfig-vim' " .editorconfig support
Plug 'dhruvasagar/vim-table-mode', {'on': 'TableModeToggle'}  " 格式化表格
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'} " 撤销树
Plug 'rhysd/clever-f.vim' " 字符跳转
Plug 'rhlobo/vim-super-retab' " tab space 转换

"" writing

Plug 'adoyle-h/vim-MarkdownTOC', {'for': 'markdown', 'branch': 'adoyle'} " Table of Content generator
Plug 'junegunn/goyo.vim', { 'on': 'Goyo', 'for': 'markdown' } " 禅意协作模式
Plug 'junegunn/limelight.vim', { 'on': 'Limelight', 'for': 'markdown' } " 高亮当前代码块
Plug 'sotte/presenting.vim', { 'for': 'markdown' } " markdown 幻灯片

"" languages
" Plug 'sheerun/vim-polyglot'
Plug 'Chiel92/vim-autoformat'  " 整理格式。并且自带的 RemoveTrailingSpaces 也可以去空格
Plug 'adoyle-h/vim-trailing-whitespace', {'branch': 'adoyle'} " 高亮空格

Plug 'mattn/emmet-vim', {'for': ['html', 'xml', 'xhtml']}
Plug 'elzr/vim-json', {'for': ['javascript', 'json']}
Plug 'plasticboy/vim-markdown', {'for': ['markdown']}
"Plug 'tpope/vim-markdown'

Plug 'pangloss/vim-javascript' " 不要使用 for 选项，否则会导致语法高亮不会在初次加载时生效
Plug 'moll/vim-node', {'for': ['javascript']}
" Plug 'ternjs/tern_for_vim', {'for': ['javascript', 'javascript.jsx'], 'do': 'npm install'}
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx']}
Plug 'sbdchd/neoformat'
" Plug 'scrooloose/syntastic' " syntax checking for vim
" Plug 'adoyle-h/syntastic-local-eslint.vim', {'for': ['javascript', 'javascript.jsx'], 'branch': 'adoyle'} " 使用项目自身的 eslint 进行语法检查
Plug 'w0rp/ale' " Asynchronous Syntax Lint Engine
Plug 'koron/nyancat-vim'
" Plug 'sjbach/lusty'
" Plug 'adoyle-h/accelerated-smooth-scroll', {'branch': 'adoyle'} " 顺滑滚动

Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim', {'for': ['elixir']}

"Plug 'chase/vim-ansible-yaml'
Plug 'ekalinin/Dockerfile.vim'
Plug 'mustache/vim-mustache-handlebars', {'for': ['handlebars']}
Plug 'rust-lang/rust.vim', {'for': ['rust']}
Plug 'tokozedg/vim-sman'
Plug 'aklt/plantuml-syntax'
Plug 'nikvdp/ejs-syntax'
Plug 'chr4/nginx.vim'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'sirosen/vim-rockstar'
Plug 'jvirtanen/vim-hcl'
Plug 'hashivim/vim-terraform'

" Typescript
Plug 'leafgarland/typescript-vim'
" Plug 'Quramy/tsuquyomi'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'HerringtonDarkholme/yats.vim'

" devicons should be put at last!!
Plug 'ryanoasis/vim-devicons'
