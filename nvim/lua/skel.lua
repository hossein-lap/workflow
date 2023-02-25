-- helper {{{
local api = vim.api
local skelp = ' ~/.local/hos/skels/'

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

map('n', ',c', ':-1read'..skelp..'skel.c<CR>G',		{ desc = "C template" })
map('n', ',C', ':-1read'..skelp..'skel.cpp<CR>G',	{ desc = "C++ template" })
map('n', ',h', ':-1read'..skelp..'skel.html<CR>G',	{ desc = "HTML template" })
map('n', ',l', ':-1read'..skelp..'skel.lua<CR>G',	{ desc = "Lua template" })
map('n', ',m', ':-1read'..skelp..'skel.md<CR>G',	{ desc = "Markdown template" })
map('n', ',M', ':-1read'..skelp..'skel.mk<CR>G',	{ desc = "Makefile template" })
map('n', ',g', ':-1read'..skelp..'skel.ms<CR>G',	{ desc = "Groff `ms` template" })
map('n', ',p', ':-1read'..skelp..'skel.py<CR>G',	{ desc = "Python template" })
map('n', ',r', ':-1read'..skelp..'skel.rmd<CR>G',	{ desc = "R Markdown template" })
map('n', ',s', ':-1read'..skelp..'skel.sh<CR>G',	{ desc = "Bash template" })
map('n', ',t', ':-1read'..skelp..'skel.tex<CR>G',	{ desc = "LaTeX template" })
