au BufNewFile,BufRead *.hm setf hamler
au FileType hamler let &l:commentstring='{--%s--}'
