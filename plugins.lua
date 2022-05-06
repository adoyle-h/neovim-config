-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide

local P = require('plugins.vim-plug')
local Plug = P.Plug
local Load = P.Load

P.start()

-- Basics
-- Many plugin require plenary.nvim
Plug 'nvim-lua/plenary.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'liuchengxu/vista.vim'

-- UI
Load 'plugins.color-theme'
Load 'plugins.colorizer'
Load 'plugins.statusline'
Load 'plugins.brackets'
Load 'plugins.indent'
Load 'plugins.search'
Load 'plugins.scrollbar' -- scrollbar must put after search
Plug 'majutsushi/tagbar' -- Content Explorer Sidebar
Load 'plugins.trailing'

-- Window
Plug 'szw/vim-maximizer' -- window 缩放
Plug 'simeji/winresizer'

-- Functions
Load 'plugins.lsp'
Load 'plugins.completion'
Load 'plugins.treesitter'
Load 'plugins.todo'
Load 'plugins.telescope'
Load 'plugins.session'
Load 'plugins.undotree'
Load 'plugins.comment'
Load 'plugins.bookmark'
Load 'plugins.file-explorer'
Plug('adoyle-h/vim-eunuch', {branch = 'adoyle'})  -- UNIX 命令封装。 :h eunuch

Plug('tyru/open-browser.vim', {on = {'<Plug>(openbrowser-smart-search)', '<Plug>(openbrowser-open)'}}) -- Open url from text with browser

-- Other
Plug 'neomutt/neomutt.vim'
-- This plugin was built while :w !sudo tee % > /dev/null trick does not work on neovim. https://github.com/neovim/neovim/issues/1716
Plug 'lambdalisue/suda.vim'
-- Launch vim-startuptime with :StartupTime
Plug 'dstein64/vim-startuptime'
-- Plug 'psliwka/vim-smoothie'

-- Funny
Plug('johngrib/vim-game-snake', {on = 'VimGameSnake'})
Plug('koron/nyancat-vim', {on = {'Nyancat', 'Nyancat2'}})
Plug('uguu-org/vim-matrix-screensaver', {on = 'Matrix'})

-- Utilities
-- Plug 'lifepillar/vim-cheat40', {on = 'Cheat40'} -- 显示快捷键指南
-- Plug 'liuchengxu/vim-which-key', { on = ['WhichKey', 'WhichKey!'] } -- 显示匹配某个前缀的快捷键
Plug('kassio/neoterm', {on = {'T', 'Tnew', 'Tmap', 'Tpos', 'TTestSetTerm', 'TTestLib', 'TTestClearStatus', 'TREPLSetTerm', 'TREPLSendFile', 'TREPLSendLine', 'TREPLSendSelection', 'Topen', 'Ttoggle'}})  -- vim 内启动 shell
Plug('tyru/capture.vim', {on = 'Capture'})  -- :Capture <命令> 将结果输出到新的 buffer 中
Plug('nishigori/increment-activator', {on = {'<Plug>(increment-activator-increment)', '<Plug>(increment-activator-decrement)'}}) -- 自增/自减
Plug 'mg979/vim-visual-multi' -- 多光标选择

Plug 'AndrewRadev/splitjoin.vim' -- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
Plug 'tpope/vim-repeat' -- enables repeating other supported plugins with the . command


---- Brackets and Tags Matching
Plug 'tpope/vim-surround' -- mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
Plug 'Raimondi/delimitMate' -- automatic closing of quotes, parenthesis, brackets, etc.
Plug 'tpope/vim-ragtag' -- like closetag. endings for html, xml, etc. - enhance vim-surround
Plug 'alvan/vim-closetag'
Plug 'vim-scripts/matchit.zip' -- extended % matching

---- Colors
Plug 'vasconcelloslf/vim-interestingwords'  -- 高亮单词
Plug('guns/xterm-color-table.vim', {on = {'XtermColorTable', 'SXtermColorTable', 'VXtermColorTable', 'TXtermColorTable', 'EXtermColorTable', 'OXtermColorTable'}}) -- 终端颜色表

-- Search
Plug 'henrik/vim-indexed-search'  -- 显示搜索查找到第几个
Plug('dyng/ctrlsf.vim', {on = {'<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordPath', 'CtrlSF'}}) -- 项目内内容搜索
Plug 'thinca/vim-visualstar'  -- visual 模型下查找增强

-- Move
Plug 't9md/vim-choosewin' -- window/tab 切换
Plug 'easymotion/vim-easymotion'  -- 光标跳转
Plug 'matze/vim-move' -- 移动选定段落 <A-k> <A-j>
Plug 'adoyle-h/vim-emacscommandline'  -- Emacs 快捷键
Plug 'bkad/CamelCaseMotion' -- either CamelCase ('anIdentifier') or underscore_notation ('an_identifier')

-- Git
Load 'plugins.git-gutter'
Plug 'tpope/vim-fugitive' -- git 命令 in vim
Plug 'gregsexton/gitv' -- git log in vim

-- Diff
Plug 'chrisbra/vim-diff-enhanced'
Plug 'chrisbra/Recover.vim'   -- 崩溃后打开 swap 文件 diff

-- Formatting
Plug 'editorconfig/editorconfig-vim' -- .editorconfig support
Plug 'sbdchd/neoformat'
Plug 'Chiel92/vim-autoformat'  -- 整理格式。并且自带的 RemoveTrailingSpaces 也可以去空格
Plug('rhlobo/vim-super-retab', {on = {'Space2Tab', 'Tab2Space'}})
Plug 'tpope/vim-sleuth' -- 根据上下文自动调整 shiftwidth expandtab
Plug('dhruvasagar/vim-table-mode', {on = 'TableModeToggle'})  -- 格式化表格
Plug('junegunn/vim-easy-align', { on = {'<Plug>(EasyAlign)', 'EasyAlign'} })
Plug 'mechatroner/rainbow_csv' -- for .csv file
Plug 'tpope/vim-abolish'  -- https://github.com/tpope/vim-abolish#coercion

-- Writing
Load 'plugins.writing'
Plug('sotte/presenting.vim', { ['for'] = 'markdown' }) -- markdown 幻灯片

-- Languages
---- Markdown
Plug('plasticboy/vim-markdown', {['for'] = 'markdown'})
Plug('adoyle-h/vim-MarkdownTOC', {['for'] = 'markdown', branch = 'adoyle'}) -- Table of Content generator
-- Plug 'mzlogin/vim-markdown-toc', {['for'] = 'markdown'}
Plug('iamcco/markdown-preview.nvim', {['for'] = 'markdown', ['do'] = 'cd app & npm install'})

-- Plug 'mattn/emmet-vim', {['for'] = ['html', 'xml', 'xhtml']}
-- Plug 'elzr/vim-json', {['for'] = ['javascript', 'json']}
-- Plug 'pangloss/vim-javascript' -- 不要使用 for 选项，否则会导致语法高亮不会在初次加载时生效
-- Plug 'mxw/vim-jsx', {['for'] = ['javascript', 'javascript.jsx']}
-- Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

-- Plug 'ekalinin/Dockerfile.vim'
-- Plug 'tokozedg/vim-sman'
-- Plug 'aklt/plantuml-syntax'
-- Plug 'nikvdp/ejs-syntax'
-- Plug 'chr4/nginx.vim'
-- Plug 'cespare/vim-toml'
-- Plug 'sirosen/vim-rockstar'
-- Plug 'jvirtanen/vim-hcl'
-- Plug 'hashivim/vim-terraform'
-- Plug 'google/vim-jsonnet'

-- Typescript
-- Plug 'leafgarland/typescript-vim'
-- Plug 'Quramy/tsuquyomi'
-- Plug 'HerringtonDarkholme/yats.vim'

-- devicons should be put at last!!
Plug 'ryanoasis/vim-devicons'

P.fin()
