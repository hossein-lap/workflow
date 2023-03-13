local options = {
	backup = false,
	swapfile = false,
	number = true,
	wrap = false,
	autochdir = true,
	linebreak = true,
	wildmenu = true,
	wildmode = {
		'longest:list',
		'full',
	},
	clipboard = {
		'unnamed',
		'unnamedplus'
	},
	showcmd = true,
	showmode = false,
	tabstop = 4,
	shiftwidth = 4,
	autoindent = true,
	hlsearch = true,
	cursorline = true,
	scrolloff = 2,
	foldmethod = 'marker',
	foldenable = true,
	foldnestmax = 15,
	foldlevel = 0,
	splitbelow = true,
	splitright = true,
	spelllang = {
		'en_us',
		'de'
	},
	spellsuggest = 'best',
	hidden = true,
	list = true,
	listchars = {
		tab = '› ',
		trail = ' ',
		lead = ' ',
		eol = ' '
	},
	termbidi = true,
	background = 'dark',
--	colorcolumn = '66',
	colorcolumn= '85',
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

---- old {{{
---- set line number
--set.number = true
---- wrap lines
--set.wrap = false
---- change dir to the current file's directory
--set.autochdir = true
--
---- do not break words on wrapping
--set.linebreak = true
--
----  mouse click
--set.mouse = 'a'
--
---- wild menu
--set.wildmenu = true
--set.wildmode = 'longest:list,full'
--
---- clipboard
--set.clipboard = 'unnamed'
--set.clipboard = 'unnamedplus'
--
---- show/hide vim mode and pressed key
--set.showcmd = true
--set.showmode = false
--
---- <tab> config
--set.tabstop = 4
--set.shiftwidth = 4
--
---- indentation
--set.autoindent = true
--
---- search highlight
--set.hlsearch = true
--
---- cursor highlight
--set.cursorline = true
--
--set.scrolloff = 2
--
---- folding section
--set.foldmethod = 'marker'
--set.foldenable = true
--set.foldnestmax = 15
--set.foldlevel = 0
--
---- open all splits in the bottom-h and right
--set.splitbelow = true
--set.splitright = true
--
---- Spell Check
--set.spelllang = 'en_us'
--
---- Hidden characters
--set.hidden = true
--set.list = true
----set.listchars='tab:¦ ,trail:⋅·'
----set.listchars={tab = '│ ', trail = '⋅', eol = '↵'}
--set.listchars = {
--	tab = '› ',
--	trail = ' ',
--	lead = ' ',
--	eol = ' '
--}
--
---- Bidi Support
--set.termbidi = true
--
---- Background color
--set.background = 'dark'
--
---- Max char line
--set.colorcolumn= '66'
----set.colorcolumn= '85'
---- }}}
