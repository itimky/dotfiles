if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
 au!
 au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END
