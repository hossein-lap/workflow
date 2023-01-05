"   _  _ ___    
"  | || | __|   H
"  | __ | _|    A
"  |_||_|___|   P
"                
"                
"" add ready-to-use text by .ext
let g:skelkey=','
let g:skelpath='~/.local/dev/hossein-lap/workflow/config/skels/'
"
exe "nnoremap" .. g:skelkey .. "make :-1read " .. g:skelpath .. "skel.mk<CR>"
exe "nnoremap" .. g:skelkey .. "sh   :-1read " .. g:skelpath .. "skel.sh<CR>"
exe "nnoremap" .. g:skelkey .. "py   :-1read " .. g:skelpath .. "skel.py<CR>"
exe "nnoremap" .. g:skelkey .. "lua  :-1read " .. g:skelpath .. "skel.lua<CR>"
"
exe "nnoremap" .. g:skelkey .. "html :-1read " .. g:skelpath .. "skel.html<CR>"
exe "nnoremap" .. g:skelkey .. "md   :-1read " .. g:skelpath .. "skel.md<CR>"
exe "nnoremap" .. g:skelkey .. "rmd  :-1read " .. g:skelpath .. "skel.rmd<CR>"
exe "nnoremap" .. g:skelkey .. "ms   :-1read " .. g:skelpath .. "skel.ms<CR>"
exe "nnoremap" .. g:skelkey .. "tex  :-1read " .. g:skelpath .. "skel.tex<CR>"
"
exe "nnoremap" .. g:skelkey .. "C    :-1read " .. g:skelpath .. "skel.c<CR>"
exe "nnoremap" .. g:skelkey .. "cpp  :-1read " .. g:skelpath .. "skel.cpp<CR>"
"               
"exe "nnoremap" .. g:skelkey .. "int  :-1read " .. g:skelpath .. "skel.intro<CR>"
"               
