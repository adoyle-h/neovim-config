"" Use :help 'option' to see the documentation for the given option.

"set clipboard+=unnamed " 共享剪贴板

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容

" Set the default listing style:
" = 0: thin listing (one file per line)
" = 1: long listing (one file per line with time
"      stamp information and file size)
" = 2: wide listing (multiple files in columns)
" = 3: tree style listing
let g:netrw_liststyle=3
let g:netrw_winsize=30

" disable netrw's gx mapping. I use open-browser.vim
let g:netrw_nogx = 1


"set fillchars=vert:\ ,stl:\ ,stlnc:\  " 在被分割的窗口间显示空白，便于阅读

"set wrap "turn on line wrapping
set textwidth=0
"set wrapmargin=0 " wrap lines when coming within n characters from side
"set linebreak " set soft wrapping

set diffopt+=vertical

">>>>>>>>

set nocompatible
syntax on " turn on that syntax highlighting. Default is on in neovim.

" command                       detection   plugin      indent ~
" :filetype on                  on          unchanged   unchanged
" :filetype off                 off         unchanged   unchanged
" :filetype plugin on           on          on          unchanged
" :filetype plugin off          unchanged   off         unchanged
" :filetype indent on           on          unchanged   on
" :filetype indent off          unchanged   unchanged   off
" :filetype plugin indent on    on          on          on
" :filetype plugin indent off   unchanged   off         off

filetype on  " 侦测文件类型
filetype plugin on " 载入文件类型插件
filetype indent on " 为特定文件类型载入相关缩进文件
filetype plugin indent on

set shell=$SHELL

set shortmess=ilmnrwxst
set showmode
set nohidden " current buffer can be put into background"
set lazyredraw " don't update the display while executing macros
set autoread " detect when a file is changed
set whichwrap=b,s   " 允许 backspace 和空格键跨越行边界
set backspace=indent,eol,start " 使 backspace 正常处理 indent, eol, start 等
set history=1000 " change history to 1000

set smartindent
set autoindent " Indent at the same level of the previous line

set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)
set cmdheight=2  " 命令行行高

" 鼠标
set mouse-=a
set mousemodel=popup

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set selection=exclusive

set scrolloff=0 " 0:光标不固定；999:光标始终保持在屏幕中央

set tabstop=4  " Tab键的宽度，tabstop 和 shiftwidth 需要一致
set shiftwidth=4  " 每一次缩进对应的空格数
set softtabstop=4  " 按一次退格键删掉的空格数
set shiftround " 缩进取整，round indent to a multiple of 'shiftwidth'
set expandtab  " 使用空格代替制表符
set smarttab

set ruler " 打开状态栏标尺
set confirm  " 在处理未保存或只读文件的时候，弹出确认
set ttimeout  " prevent '<esc>' delay in terminal http://stackoverflow.com/a/33957679/2326199
set timeoutlen=99999 " 一直等待组合键完成
set scrolljump=1 " Lines to scroll when cursor leaves screen

set number  " 显示行号
set relativenumber " 显示相对行号

"语言设置

set fileencodings=utf-8,gb2312,gbk,ucs-bom,default,latin1
set fileformats=unix,dos,mac
set langmenu=zh_CN.UTF-8

set showcmd " 显示当前正在输入的命令
set completeopt=menu,preview  "补全
set nolist " 不显示制表符
set listchars=tab:——,eol:¬,trail:·,extends:⥤,precedes:⥢,nbsp:+  " 高亮空格、Tab、换行符等
set showbreak=↪
set iskeyword -=.

" 代码折叠
set foldenable " 自动折叠
set foldcolumn=0  " 不显示左侧折叠栏
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=indent
set foldlevel=99

set report=0  " 通过使用: commands命令，告诉我们文件的哪一行被改变过

set showmatch " show matching bracket (briefly jump)
set matchtime=1 " show matching bracket for 0.2 seconds

set matchpairs=(:),{:},[:],<:>,“:”  " 匹配跳转

set formatoptions+=mB

set spelllang=en,cjk
set spell
set spellfile=$XDG_CONFIG_HOME/nvim/spell/en.utf-8.add

set conceallevel=2
set concealcursor=""

" Searching

set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set inccommand=split " neovim feature: live preview

" error bells
set noerrorbells
set visualbell

" set ignore file extension of wildmenu, won't list when using filename completion
set wildignore+=*.a,*.o,.DS_Store,.git,.hg,.svn,*~,*.swp,*.tmp,*/.sass-cache/*,*.scssc
set wildmode=list,full " Command <Tab> completion, list matches, then longest common part, then all.

set cc=80,100  " highlight three columns after 'textwidth'
set synmaxcol=300 " Syntax coloring lines that are too long just slows down the world

" swap 文件配置
set updatetime=5000  " 每 5000 毫秒保存一次 swap
set updatecount=100   " 每 100 字符保存一次 swap

set sessionoptions=buffers,curdir,resize,tabpages,winpos,winsize

set notermguicolors

"" insert mode - line
"let &t_SI .= "\<Esc>[5 q"
""replace mode - underline
"let &t_SR .= "\<Esc>[4 q"
""common - block
"let &t_EI .= "\<Esc>[3 q"
"" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" " For tmux running in iTerm2 on OS X:
" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
