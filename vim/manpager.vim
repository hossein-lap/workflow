" vimrc
if !empty($MAN_PN)
	autocmd StdinReadPost * set ft=man | file $MAN_PN
endif

" ftplugin/man.vim
set showtabline=0
set ls=0
set nonu
set nolist
set nohidden
set readonly
set buftype=nofile
set bufhidden=hide
set noswapfile
set nomodifiable
set scrolloff=15

function! PrepManPager()
	setlocal modifiable
	if !empty ($MAN_PN)
		silent %! col -b -x
	endif
	setlocal nomodified
	setlocal nomodifiable
endfunction

autocmd BufWinEnter $MAN_PN call PrepManPager()
nnoremap q :qa<CR>
nnoremap <Space> <PageDown>
map <expr> <CR> winnr('$') == 1 ? ':vs<CR><C-]>' : '<C-]>'

colorscheme hybrid
