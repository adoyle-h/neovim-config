"Plug 'benekastah/neomake'
"Plug 'tpope/vim-dispatch' " asynchronous build and test dispatcher
"Plug 'Shougo/vimproc.vim', { 'do': 'make' } " interactive command execution in vim


"Plug 'Shougo/deoplete.nvim'
"Plug 'tpope/vim-vinegar'
"Plug 'MarcWeber/vim-addon-mw-utils' " interpret a file by function and cache file automatically
"Plug 'tomtom/tlib_vim' " utility functions for vim
"Plug 'xolox/vim-misc'


"" ========
Plug 'MattesGroeger/vim-bookmarks'  " 书签管理器
Plug 'kassio/neoterm'  " vim 内启动 shell
Plug 'adoyle-h/vim-emacscommandline'  " emacs 快捷键
Plug 'vasconcelloslf/vim-interestingwords'  " 高亮单词
"Plug 'kopischke/unite-spell-suggest'
Plug 'vim-scripts/VisIncr'  " Produce increasing/decreasing columns of numbers, dates, or daynames
Plug 'guns/xterm-color-table.vim' " 终端颜色表
Plug 'majutsushi/tagbar', {'on': 'Tagbar'}  " 侧边栏索引
Plug 'terryma/vim-multiple-cursors'  " g:multi_cursor_start_key 不能绑定到 <CR> 或者 <C-m> 键，会出问题
Plug 'easymotion/vim-easymotion'  " 光标跳转
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeMirrorToggle', 'NERDTreeTabsToggle', 'NERDTreeTabsFind', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'jistr/vim-nerdtree-tabs', {'on': ['NERDTreeMirrorToggle', 'NERDTreeTabsToggle', 'NERDTreeTabsFind', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeMirrorToggle', 'NERDTreeTabsToggle', 'NERDTreeTabsFind', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
"Plug 'godlygeek/tabular' " alt vim-easy-align
"Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder
Plug 'shougo/unite.vim' "  search and display information from arbitrary sources like files, buffers, recently used files or registers.
Plug 'scrooloose/syntastic' " syntax checking for vim
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'adoyle-h/syntastic-local-eslint.vim', {'branch': 'adoyle'} " 使用项目自身的 eslint 进行语法检查
"Plug 'luochen1990/rainbow'
Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
Plug 'Raimondi/delimitMate' " automatic closing of quotes, parenthesis, brackets, etc.
"Plug 'tpope/vim-unimpaired' " mappings which are simply short normal mode aliases for commonly used ex commands

Plug 'ap/vim-css-color'  " 显示颜色
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ggVGc/vim-fuzzysearch', {'on': 'FuzzySearch'}
"Plug 'rking/ag.vim'
Plug 'dyng/ctrlsf.vim', {'on': ['<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordPath', 'CtrlSF']} " 项目内内容搜索
Plug 'thinca/vim-visualstar'  " visual 模型下查找增强
Plug 'scrooloose/nerdcommenter'  " 注释
" Plug 'tomtom/tcomment_vim'  " alt nerdcommenter
Plug 'yggdroot/indentline'  " alt vim-indent-guides
Plug 'tpope/vim-ragtag' " like closetag
Plug 'alvan/vim-closetag', {'for': ['javascript.jsx', 'html', 'xml', 'xhtml']}
Plug 'Valloric/MatchTagAlways', {'for': ['javascript.jsx', 'html', 'xml', 'xhtml']}
Plug 'vim-scripts/matchit.zip' " extended % matching

Plug 'airblade/vim-gitgutter' " git 状态侧边栏
Plug 'tpope/vim-fugitive' " git 命令 in vim
Plug 'tpope/vim-repeat' " enables repeating other supported plugins with the . command
Plug 'henrik/vim-indexed-search'  " 显示搜索查找到第几个
Plug 'szw/vim-maximizer'  " window 缩放

"" utilities
"Plug 'xolox/vim-session'
"Plug 'sickill/vim-pasta' " context-aware pasting
Plug 'tpope/vim-sleuth' " 根据上下文自动调整 shiftwidth expandtab
"Plug 'AndrewRadev/splitjoin.vim' " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one

"Plug 'tpope/vim-endwise' " automatically add end in ruby
"Plug 'tpope/vim-ragtag' " endings for html, xml, etc. - ehances surround

Plug 'chrisbra/vim-diff-enhanced'
Plug 'chrisbra/Recover.vim'   " 崩溃后打开 swap 文件 diff
Plug 'wesQ3/vim-windowswap'  " window 窗口交换

"" snippets
Plug 'SirVer/ultisnips', { 'on': [] }
Plug 'honza/vim-snippets' " vim-snippets depends on ultisnips
Plug 'justinj/vim-react-snippets'
Plug 'ahmedelgabri/vim-ava-snippets'
Plug 'rdnetto/YCM-Generator', { 'on': 'YcmGenerateConfig', 'branch': 'stable'}
"Plug 'ervandew/supertab' " Perform all your vim insert mode completions with Tab

Plug 'Valloric/YouCompleteMe', {'do': './install.py --tern-completer'}
augroup load_snips
  autocmd!
  autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe')
          \| call youcompleteme#Enable()
          \| autocmd! load_snips
augroup END

Plug 'editorconfig/editorconfig-vim' " .editorconfig support
Plug 'dhruvasagar/vim-table-mode', {'on': 'TableModeToggle'}  " 格式化表格
Plug 'bronson/vim-trailing-whitespace' " 去空格
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'} " 撤销树
Plug 'rhysd/clever-f.vim' " 字符跳转
Plug 'rhlobo/vim-super-retab' " tab space 转换

"" writing

Plug 'junegunn/goyo.vim', { 'on': 'Goyo', 'for': 'markdown' } " 禅意协作模式
Plug 'junegunn/limelight.vim', { 'on': 'Limelight', 'for': 'markdown' } " 高亮当前代码块
Plug 'sotte/presenting.vim', { 'for': 'markdown' } " markdown 幻灯片

"" languages
Plug 'Chiel92/vim-autoformat'

Plug 'mattn/emmet-vim', {'for': ['html', 'xml', 'xhtml']}
Plug 'elzr/vim-json', {'for': ['javascript', 'json']}
Plug 'plasticboy/vim-markdown', {'for': ['markdown']}
"Plug 'tpope/vim-markdown'

Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'moll/vim-node', {'for': ['javascript', 'javascript.jsx']}
Plug 'ternjs/tern_for_vim', {'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx']}

Plug 'elixir-lang/vim-elixir', {'for': ['.ex', '.exs', '.eex']}

Plug 'stephpy/vim-yaml', {'for': ['.yaml']}
"Plug 'chase/vim-ansible-yaml'
Plug 'honza/dockerfile.vim', {'for': ['Dockerfile']}
Plug 'mustache/vim-mustache-handlebars', {'for': ['.handlebars']}
Plug 'rust-lang/rust.vim', {'for': ['.rust']}
Plug 'tokozedg/vim-sman', {'for': ['.yaml']}

" devicons should be put at last!!
Plug 'ryanoasis/vim-devicons'
