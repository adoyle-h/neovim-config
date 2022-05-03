let $NVIM_HOME=stdpath("config")

" see https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('$NVIM_HOME/autoload/plug.vim'))
  silent !curl -fLo $NVIM_HOME/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

source $NVIM_HOME/color.vim
source $NVIM_HOME/functions.vim
source $NVIM_HOME/settings.vim
source $NVIM_HOME/autocmds.vim

" see https://github.com/junegunn/vim-plug
call plug#begin('$NVIM_HOME/plugged')
source $NVIM_HOME/plugins.vim
call plug#end()
source $NVIM_HOME/plugins-config.vim

lua require('plugins')
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins/init.lua source <afile> | PackerCompile
augroup end

source $NVIM_HOME/highlights.vim
source $NVIM_HOME/keys.vim
luafile $NVIM_HOME/keys.lua

for file in split(glob('$NVIM_HOME/ftdetect/*.vim'), '\n')
  execute 'source' file
endfor
