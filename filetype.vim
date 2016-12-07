" :h new-filetype
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.cocoascript setfiletype javascript
augroup END
