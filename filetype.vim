" :h new-filetype
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufRead,BufNewFile *.cocoascript setfiletype javascript
  au BufRead,BufNewFile bash_profile,profile setfiletype sh
augroup END
