source $NVIM_HOME/abbreviations.vim
source $NVIM_HOME/color.vim
source $NVIM_HOME/functions.vim
source $NVIM_HOME/settings.vim
source $NVIM_HOME/autocmds.vim

" see https://github.com/junegunn/vim-plug
call plug#begin('$NVIM_HOME/plugged')
source $NVIM_HOME/plugins.vim
call plug#end()
source $NVIM_HOME/plugins-config.vim

source $NVIM_HOME/keys.vim

for file in split(glob('$NVIM_HOME/ftdetect/*.vim'), '\n')
  execute 'source' file
endfor
"source $NVIM_HOME/ftdetect.vim

