"  _  _ ___
" | || | __|   H
" | __ | _|    A
" |_||_|___|   P
"
"
" Global Section {{{
" Makefile:
au FileType * nnoremap <leader>cc :!clear; make<CR>
au FileType * nnoremap <leader>cx :!clear; make force<CR>
" Git:
au FileType * nnoremap <leader>gs :!clear; git status -s<CR>
au FileType * nnoremap <leader>gl :!clear; git log --oneline --stat --graph --all<CR>
au FileType * nnoremap <leader>ga :!clear; git add %<CR>
au FileType * nnoremap <leader>gc :!clear; git commit<CR>
" }}}
"
" C++ section {{{
"" compile via \fe
autocmd FileType cpp nnoremap <leader>fe :!clear; g++ % -o %:r<CR>
"" run via \fw
autocmd FileType cpp nnoremap <leader>fw :!clear; ./%:r<CR>
"" compile and run via \fq
autocmd FileType cpp nnoremap <leader>fq :!clear; g++ % && ./%:r<CR>
" }}}
" C section {{{
"" compile via \fe
autocmd FileType c nnoremap <leader>fe :!clear; gcc %:r.c -o %:r<CR>
"" run via \fw
autocmd FileType c nnoremap <leader>fw :!clear; ./%:r<CR>
"" compile and run via \fq
autocmd FileType c nnoremap <leader>fq :!clear; gcc %:r.c && ./%:r<CR>
" }}}
"
" LaTeX section {{{
"" using pdflatex
"autocmd Filetype tex nnoremap <leader>fe :!clear; pdflatex %:r.tex<CR>
"" using XeLaTeX
autocmd Filetype tex nnoremap <leader>fe :!clear; xelatex %:r.tex<CR>
" }}}
" groff section {{{
"" mspdf macro to pdf
autocmd Filetype nroff nnoremap <leader>fe :!clear; groff -mspdf -Tpdf %:r.ms > %:r.pdf<CR>
" }}}
" markdown section {{{
"" markdown to pdf via pandoc
"autocmd Filetype markdown nnoremap <leader>fe :!clear; pandoc %:r.md -o %:r.pdf<CR>
autocmd Filetype markdown,vimwiki nnoremap <leader>fe :!clear; glow -p %<CR>
autocmd Filetype markdown,vimwiki nnoremap <leader>fw :!clear; mdp %<CR>
" }}}
" rmarkdown section {{{
"" markdown to pdf via pandoc
"autocmd Filetype markdown nnoremap <leader>fe :!clear; pandoc %:r.md -o %:r.pdf<CR>
autocmd Filetype rmd nnoremap <leader>fe :!clear; Rscript -e "rmarkdown::render('%')"<CR>
"autocmd Filetype rmd nnoremap <leader>fw :!clear; mdp %<CR>
" }}}
" sent section {{{
autocmd Filetype text nnoremap <leader>fe :!clear; sent -f 'Liberation Serif' % &<CR>
" }}}
"
"" folding section {{{
""" save via zs
"autocmd Filetype *  nnoremap zs :mkview<CR>  
""" restore via zr
"autocmd Filetype *  nnoremap zr :loadview<CR>
"" }}}
"
" execute Python programs {{{
autocmd FileType python nnoremap <leader>fe :!clear; python3 %:p<CR>
" }}}
" execute Lua programs {{{
autocmd FileType lua nnoremap <leader>fe :!clear; lua5.4 %:p<CR>
" }}}
"
" shell {{{
autocmd FileType sh nnoremap <leader>fe :!clear; bash %:p<CR>
autocmd FileType sh nnoremap <leader>fw :!clear; dash %:p<CR>
autocmd FileType csh nnoremap <leader>fq :!clear; tcsh %:p<CR>
" }}}

