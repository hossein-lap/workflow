autocmd BufNewFile,BufRead *.sent set filetype=sent

syntax match Comment /^#.*/
syntax match String /^@.*/
syntax match Type /\\./
