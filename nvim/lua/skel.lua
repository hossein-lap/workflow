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

map('n', ',c', ':-1read'..skelp..'skel.c<CR>',		{ desc = "C template" })
map('n', ',C', ':-1read'..skelp..'skel.cpp<CR>',	{ desc = "C++ template" })
map('n', ',h', ':-1read'..skelp..'skel.html<CR>',	{ desc = "HTML template" })
map('n', ',l', ':-1read'..skelp..'skel.lua<CR>',	{ desc = "Lua template" })
map('n', ',m', ':-1read'..skelp..'skel.md<CR>',		{ desc = "Markdown template" })
map('n', ',M', ':-1read'..skelp..'skel.mk<CR>',		{ desc = "Makefile template" })
map('n', ',g', ':-1read'..skelp..'skel.ms<CR>',		{ desc = "Groff `ms` template" })
map('n', ',p', ':-1read'..skelp..'skel.py<CR>',		{ desc = "Python template" })
map('n', ',r', ':-1read'..skelp..'skel.rmd<CR>',	{ desc = "R Markdown template" })
map('n', ',s', ':-1read'..skelp..'skel.sh<CR>',		{ desc = "Bash template" })
map('n', ',t', ':-1read'..skelp..'skel.tex<CR>',	{ desc = "LaTeX template" })

-- Loremipsum
map('n', ',i1', ':read'..skelp..'loremipsum/lipsum001.txt<CR>',
	{ desc = "Lorem Ipsum, Section 01" })
map('n', ',i2', ':read'..skelp..'loremipsum/lipsum002.txt<CR>',
	{ desc = "Lorem Ipsum, Section 02" })
map('n', ',i3', ':read'..skelp..'loremipsum/lipsum003.txt<CR>',
	{ desc = "Lorem Ipsum, Section 03" })
map('n', ',i4', ':read'..skelp..'loremipsum/lipsum004.txt<CR>',
	{ desc = "Lorem Ipsum, Section 04" })
map('n', ',i5', ':read'..skelp..'loremipsum/lipsum005.txt<CR>',
	{ desc = "Lorem Ipsum, Section 05" })
map('n', ',i6', ':read'..skelp..'loremipsum/lipsum006.txt<CR>',
	{ desc = "Lorem Ipsum, Section 06" })
map('n', ',i7', ':read'..skelp..'loremipsum/lipsum007.txt<CR>',
	{ desc = "Lorem Ipsum, Section 07" })
map('n', ',i8', ':read'..skelp..'loremipsum/lipsum008.txt<CR>',
	{ desc = "Lorem Ipsum, Section 08" })
map('n', ',i9', ':read'..skelp..'loremipsum/lipsum009.txt<CR>',
	{ desc = "Lorem Ipsum, Section 09" })
