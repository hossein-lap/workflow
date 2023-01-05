-- helper {{{
local api = vim.api
-- key mapping {{{
local function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
-- keymap function {{{
function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
--}}}
-- }}}
---- unmap {{{
--local function umap(mode, key)
--	if not mode or not key then
--		print('Error on using umap()')
--		print('umap(mode, key) must have both arguments')
--		return 1
--	end
--	api.nvim_del_keymap(mode, key)
--end
---- }}}
-- autocmd {{{
local function au(commands, patterns, evnt)
	if evnt == nil then
		evnt = 'FileType'
	end
	api.nvim_create_autocmd(evnt, {
		pattern = patterns,
		command = commands,
--		group = patterns .. 'groups'
	})
end
-- }}}
-- }}}

-- Folding {{{
map('n', '<leader>da', ':mkview<CR>')
map('n', '<leader>dw', ':loadview<CR>')
-- }}}
-- back to normal-mode in terminal {{{
map('t', '<Esc>', '<C-\\><C-n>')
map('t', '<C-d>', '<C-c><C-c> <space> exit<CR>', {silent = true})
-- }}}
-- back to normal mode {{{
map('i', '<C-c>', '<Esc>')
-- }}}
---- netrw toggle {{{
--map('n', '<leader>ff', ':24Lexplore<CR><C-w>w')
---- }}}
-- NvimTree Toggle {{{
map('n', '<leader>ff', ':lua nvim_tree_toggle()<CR>', {silent = true})-- }}}
-- toggle paste mode {{{
map('n', '<C-P>', ':set paste! nu! list!<CR>', {silent = true})
--map('n', '<C-P>', ':lua PasteToggle()<CR>')
-- }}}
-- spelling check {{{
map('n', '<leader>ss',  ':setlocal spell!<CR>', {silent = true})
-- }}}
-- go to next/previous buffer {{{
map('n', '<C-n>',  ':bnext<CR>', {silent = true})
map('n', '<C-b>',  ':bprevious<CR>', {silent = true})
-- }}}
---- switch tabs {{{
--map('n', '_', ':tabnext<CR>', {silent = true})
---- }}}
-- comment lines via - and uncomment via + {{{
-- comment_leader var definition {{{
au( [[let b:comment_leader = '//']],
	{ 'c', 'cpp', 'java', 'scala', 'json', 'rust' })

au( [[let b:comment_leader = '#']],
	{ 'sh', 'zsh', 'csh', 'ruby', 'python', 'conf', 'yaml', 'make', 'toml', 'rmd', 'sent' })

au( [[let b:comment_leader = '--']],
	{ 'haskell', 'lua', })

au( [[let b:comment_leader = '"']],
	{ 'vim', })

au( [[let b:comment_leader = '%']],
	{ 'tex', 'plaintex', })

au( [[let b:comment_leader = '.\"']],
	{ 'nroff', })

au( [[let b:comment_leader = ';']],
	{ 'asm', 'lisp' })
-- }}}

-- noremap <silent> - :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
-- noremap <silent> + :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

-- keybinding
map('', '-',
	[[:<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>]],
--	[[:s=\v^(\s*)=\1<C-R>=escape(b:comment_leader,'\ ')<CR><CR>:nohlsearch<CR>]]
	{ silent = true }
)

map('', '+',
	[[:<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>]],
--	[[:s=\v^(\s*)\<C-R>=escape(b:comment_leader,'\= ')<CR>=\1=<CR>:nohlsearch<CR>]]
	{ silent = true }
)
-- }}}
-- autofill {{{
map('n', '<leader>af', ':lua AutoFillAll()<CR>', {silent = true})
--map('n', '<leader>af', ':lua AutoFill()<CR>', {silent = true})
--map('n', '<leader>ad', ':lua AutoFillMarkdown()<CR>', {silent = true})
--map('n', '<leader>as', ':lua AutoFillSent()<CR>', {silent = true})
-- }}}
