let $NVIM_HOME=stdpath("config")

source $NVIM_HOME/color.vim
source $NVIM_HOME/functions.vim
source $NVIM_HOME/settings.vim
source $NVIM_HOME/autocmds.vim

luafile $NVIM_HOME/plugins.lua
source $NVIM_HOME/plugins-config.vim

source $NVIM_HOME/highlights.vim
source $NVIM_HOME/keys.vim

for file in split(glob('$NVIM_HOME/ftdetect/*.vim'), '\n')
  execute 'source' file
endfor
