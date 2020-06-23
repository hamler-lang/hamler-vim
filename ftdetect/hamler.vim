au BufNewFile,BufRead *.hm set filetype=hamler
au FileType hamler let &l:commentstring='{--%s--}'
