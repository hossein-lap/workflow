local options = {
	belloff = "all", -- no bells
	inccommand = "nosplit", -- preview `:%s` commands live
	undofile = false, -- DO NOT keep track of undos between sessions
	grepprg = "rg --vimgrep --smart-case --no-heading", -- search with rg
	grepformat = "%f:%l:%c:%m", -- filename:line number:column number:error message
	mousescroll = "ver:3,hor:0", -- scroll vertically by 3 lines, no horizontal scrolling
	signcolumn = "yes", -- show the sign column always

	backup = false, -- do not create backup file
	swapfile = false, -- do not create swapfile
	number = true, -- enable line number
	wrap = true, -- enable wrapping
	autochdir = true, -- auto-switch base directory
	linebreak = true, -- set wrapping on `breaking` words (e.g: `,`)
	wildmenu = true, -- enable popup menu
	wildmode = { -- popmenu style
		'longest:list',
		'full',
	},
	completeopt = { -- luasnippet complition option
		'menuone',
		'noselect'
	},
	clipboard = { -- enable clipboard and sync it with system's clipboard
		'unnamed',
		'unnamedplus'
	},
	showcmd = true, -- show presses keys in normal mode
	showmode = false, -- do not show vim-mode in `ex` prompt
	tabstop = 4, -- where tab stop
	shiftwidth = 4, -- set tab width
	autoindent = true, -- enable indentation
	hlsearch = true, -- highligh search keywords
	cursorline = true, -- highlight current line
	scrolloff = 2, -- set where scrolling begins
	foldmethod = 'marker', -- folding style (set to use `{{{ ... }}}` characters)
	foldenable = true, -- enable folding
	foldnestmax = 15, -- maximum od folds
	foldlevel = 0, -- starting fold level
	splitbelow = true, -- set horizontal split-style
	splitright = true, -- set vertical split-style
	spelllang = { -- spell-check languages
		'en_us',
		'de',
	},
	spellsuggest = 'best', -- suggestion method
	hidden = true, -- hide the buffer
	list = true, -- show special characters (e.g: `EOL`, `TAB`, `TRAIL`)
	listchars = {
		tab = '› ', -- <Tab> special character
		trail = '+',
		lead = '-',
		eol = ' ', -- <End Of Line> special character

		nbsp = "␣",
		extends = "·",
		precedes = "·",
		multispace = "…", -- show chars if I have multiple spaces between text
		leadmultispace = "-", -- ...but don't show any when they're at the start
	},
	termbidi = true, -- enable bidirectional support
	background = 'dark', -- set background style
--	colorcolumn = '66', -- highlight maximum preferred column
	colorcolumn= '85', -- highlight maximum preferred column
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
