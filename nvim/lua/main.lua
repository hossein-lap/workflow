-- helper {{{
local set = vim.opt
-- }}}

-- set line number
set.number = true
-- wrap lines
set.wrap = true
-- change dir to the current file's directory
set.autochdir = true

-- do not break words on wrapping
set.linebreak = true

--  mouse click
set.mouse = 'a'

-- wild menu
set.wildmenu = true
set.wildmode = 'longest:list,full'

-- clipboard
set.clipboard = 'unnamed'
set.clipboard = 'unnamedplus'

-- show/hide vim mode and pressed key
set.showcmd = true
set.showmode = false

-- <tab> config
set.tabstop = 4
set.shiftwidth = 4

-- indentation
set.autoindent = true

-- search highlight
set.hlsearch = true

-- cursor highlight
set.cursorline = true

set.scrolloff = 2

-- folding section
set.foldmethod = 'marker'
set.foldenable = true
set.foldnestmax = 15
set.foldlevel = 0

-- open all splits in the bottom-h and right
set.splitbelow = true
set.splitright = true

-- Spell Check
set.spelllang='en_us,de'

-- Hidden characters
set.hidden = true
set.list = true
--set.listchars='tab:¦ ,trail:⋅·'
--set.listchars={tab = '│ ', trail = '⋅', eol = '↵'}
set.listchars={tab = '› ', trail = ' ', lead = ' ', eol = ' '}

-- Bidi Support
set.termbidi = true

-- Background color
set.background = 'dark'

-- Max char line
set.colorcolumn= '85'
