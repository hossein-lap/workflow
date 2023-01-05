-- helper {{{
local api = vim.api
local skelpath = '~/.local/dev/hossein-lap/workflow/config/skels/'

-- map() {{{
local function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
-- }}}
-- }}}

map('n',	',C',	':-1read ' .. skelpath .. 'skel.c<CR>G')
map('n',	',cpp',	':-1read ' .. skelpath .. 'skel.cpp<CR>G')
map('n',	',py',	':-1read ' .. skelpath .. 'skel.py<CR>G')
map('n',	',lua',	':-1read ' .. skelpath .. 'skel.lua<CR>G')
map('n',	',sh',	':-1read ' .. skelpath .. 'skel.sh<CR>G')
map('n',	',mk',	':-1read ' .. skelpath .. 'skel.mk<CR>G')
map('n',	',ms',	':-1read ' .. skelpath .. 'skel.ms<CR>G')
map('n',	',tex',	':-1read ' .. skelpath .. 'skel.tex<CR>G')
map('n',	',rmd',	':-1read ' .. skelpath .. 'skel.rmd<CR>G')
map('n',	',md',	':-1read ' .. skelpath .. 'skel.md<CR>G')
map('n',	',htm',	':-1read ' .. skelpath .. 'skel.html<CR>G')

map('n',	',eb',	':read ' .. skelpath .. 'eb.latex<CR>o')
