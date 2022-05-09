let $NVIM_HOME=stdpath('config')

" Note: in a runtime directory, all *.vim files are sourced before *.lua files. See ":help load-plugins"

source $NVIM_HOME/basic.vim
source $NVIM_HOME/config.lua
source $NVIM_HOME/basic.lua
source $NVIM_HOME/plugins.lua
