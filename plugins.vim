"" Other
Plug 'neomutt/neomutt.vim'

"" Funny
Plug 'johngrib/vim-game-snake', {'on': 'VimGameSnake'}
Plug 'koron/nyancat-vim', {'on': ['Nyancat', 'Nyancat2']}
Plug 'uguu-org/vim-matrix-screensaver', {'on': 'Matrix'}

"" File Explorer
Plug 'shougo/unite.vim' "  search and display information from arbitrary sources like files, buffers, recently used files or registers.

""" Nerdtree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeMirrorToggle', 'NERDTreeTabsToggle', 'NERDTreeTabsFind', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'jistr/vim-nerdtree-tabs', {'on': ['NERDTreeMirrorToggle', 'NERDTreeTabsToggle', 'NERDTreeTabsFind', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeMirrorToggle', 'NERDTreeTabsToggle', 'NERDTreeTabsFind', 'NERDTreeToggle', 'NERDTreeFind'] } " slow in large git repo
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': ['NERDTreeMirrorToggle', 'NERDTreeTabsToggle', 'NERDTreeTabsFind', 'NERDTreeToggle', 'NERDTreeFind'] }

""" Defx
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'

"" Utilities
Plug 'lifepillar/vim-cheat40', {'on': 'Cheat40'} " 显示快捷键指南
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " 显示匹配某个前缀的快捷键
Plug 'kassio/neoterm', {'on': ['T', 'Tnew', 'Tmap', 'Tpos', 'TTestSetTerm', 'TTestLib', 'TTestClearStatus', 'TREPLSetTerm', 'TREPLSendFile', 'TREPLSendLine', 'TREPLSendSelection', 'Topen', 'Ttoggle']}  " vim 内启动 shell
Plug 'tyru/capture.vim', {'on': 'Capture'}  " :Capture <命令> 将结果输出到新的 buffer 中
Plug 'scrooloose/nerdcommenter'  " 注释
Plug 'nishigori/increment-activator', {'on': ['<Plug>(increment-activator-increment)', '<Plug>(increment-activator-decrement)']} " 自增/自减
Plug 'mg979/vim-visual-multi' " 多光标选择
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session' " 会话管理器
Plug 'AndrewRadev/splitjoin.vim' " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
Plug 'tpope/vim-repeat' " enables repeating other supported plugins with the . command
Plug 'tyru/open-browser.vim', {'on': ['<Plug>(openbrowser-smart-search)', '<Plug>(openbrowser-open)']} " Open url from text with browser

"" Content Explorer
Plug 'majutsushi/tagbar', {'on': 'Tagbar'}
Plug 'liuchengxu/vista.vim' " 目前比 tagbar 弱
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'} " 修改历史树

"" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'  " alt vim-indent-guides

""" Window
" Plug 'wesQ3/vim-windowswap'  " window 窗口交换
Plug 'szw/vim-maximizer'  " window 缩放

""" Brackets and Tags Matching
Plug 'luochen1990/rainbow'  " 括号颜色配对。Attention: 可能会影响到其他语法着色
Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
Plug 'Raimondi/delimitMate' " automatic closing of quotes, parenthesis, brackets, etc.
Plug 'adoyle-h/vim-eunuch', {'branch': 'adoyle'}  " UNIX 命令封装。 :h eunuch
Plug 'tpope/vim-ragtag' " like closetag. endings for html, xml, etc. - enhance vim-surround
Plug 'alvan/vim-closetag'
Plug 'vim-scripts/matchit.zip' " extended % matching

""" Colors
Plug 'vasconcelloslf/vim-interestingwords'  " 高亮单词
Plug 'guns/xterm-color-table.vim', {'on': ['XtermColorTable', 'SXtermColorTable', 'VXtermColorTable', 'TXtermColorTable', 'EXtermColorTable', 'OXtermColorTable']} " 终端颜色表
Plug 'chrisbra/Colorizer'  " 直接在文本上显示对应的颜色

"" Search
Plug 'ggVGc/vim-fuzzysearch', {'on': 'FuzzySearch'}
Plug 'henrik/vim-indexed-search'  " 显示搜索查找到第几个
Plug 'dyng/ctrlsf.vim', {'on': ['<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordPath', 'CtrlSF']} " 项目内内容搜索
Plug 'thinca/vim-visualstar'  " visual 模型下查找增强

"" Move
Plug 't9md/vim-choosewin' " window/tab 切换
Plug 'easymotion/vim-easymotion'  " 光标跳转
Plug 'matze/vim-move' " 移动选定段落 <A-k> <A-j>
Plug 'adoyle-h/vim-emacscommandline'  " Emacs 快捷键
Plug 'bkad/CamelCaseMotion' " either CamelCase ('anIdentifier') or underscore_notation ('an_identifier')

"" Git
Plug 'airblade/vim-gitgutter' " git 状态侧边栏
Plug 'tpope/vim-fugitive' " git 命令 in vim
Plug 'gregsexton/gitv' " git log in vim

"" Diff
Plug 'chrisbra/vim-diff-enhanced'
Plug 'chrisbra/Recover.vim'   " 崩溃后打开 swap 文件 diff

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " vim-snippets depends on ultisnips
Plug 'justinj/vim-react-snippets'
Plug 'ahmedelgabri/vim-ava-snippets'
" Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'

"" Auto Completion
" Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " 自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" Lint
Plug 'w0rp/ale' " Asynchronous Syntax Lint Engine

"" Formatting
Plug 'sbdchd/neoformat'
Plug 'Chiel92/vim-autoformat'  " 整理格式。并且自带的 RemoveTrailingSpaces 也可以去空格
Plug 'editorconfig/editorconfig-vim' " .editorconfig support
Plug 'rhlobo/vim-super-retab', {'on': ['Space2Tab', 'Tab2Space']}
Plug 'vim-scripts/ShowTrailingWhitespace'  " 高亮尾空格
Plug 'tpope/vim-sleuth' " 根据上下文自动调整 shiftwidth expandtab
Plug 'dhruvasagar/vim-table-mode', {'on': 'TableModeToggle'}  " 格式化表格
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'mechatroner/rainbow_csv' " for .csv file
Plug 'tpope/vim-abolish'  " https://github.com/tpope/vim-abolish#coercion

"" Writing
Plug 'junegunn/goyo.vim', { 'on': 'Goyo', 'for': 'markdown' } " 禅意协作模式
Plug 'junegunn/limelight.vim', { 'on': 'Limelight', 'for': 'markdown' } " 高亮当前代码块
Plug 'sotte/presenting.vim', { 'for': 'markdown' } " markdown 幻灯片

"" Languages
""" Markdown
Plug 'plasticboy/vim-markdown', {'for': ['markdown']}
Plug 'lvht/tagbar-markdown', {'for': ['markdown']} " List TOC
Plug 'adoyle-h/vim-MarkdownTOC', {'for': 'markdown', 'branch': 'adoyle'} " Table of Content generator
" Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', {'for': 'markdown', 'do': 'cd app & yarn install'}

Plug 'mattn/emmet-vim', {'for': ['html', 'xml', 'xhtml']}
Plug 'elzr/vim-json', {'for': ['javascript', 'json']}
Plug 'pangloss/vim-javascript' " 不要使用 for 选项，否则会导致语法高亮不会在初次加载时生效
Plug 'moll/vim-node', {'for': ['javascript']}
" Plug 'ternjs/tern_for_vim', {'for': ['javascript', 'javascript.jsx'], 'do': 'npm install'}
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx']}
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim', {'for': ['elixir']}

Plug 'pearofducks/ansible-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'mustache/vim-mustache-handlebars', {'for': ['handlebars']}
Plug 'rust-lang/rust.vim', {'for': ['rust']}
Plug 'tokozedg/vim-sman'
Plug 'aklt/plantuml-syntax'
Plug 'nikvdp/ejs-syntax'
Plug 'chr4/nginx.vim'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
Plug 'sirosen/vim-rockstar'
Plug 'jvirtanen/vim-hcl'
Plug 'hashivim/vim-terraform'

" Typescript
Plug 'leafgarland/typescript-vim'
" Plug 'Quramy/tsuquyomi'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'HerringtonDarkholme/yats.vim'

"" devicons should be put at last!!
Plug 'ryanoasis/vim-devicons'
