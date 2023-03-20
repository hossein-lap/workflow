----*** neovim config ***----

require('helper')

-- helper {{{
--local set = vim.opt
local cmd = vim.cmd
--local go = vim.go
-- global
-- }}}

-- some options {{{
vim.go.python3_host_prog = '/bin/python3'
vim.opt.termguicolors = true
-- }}}
-- plugins {{{
require('plugin') -- packer plugin-manager
require('plugin.cmp') -- snippet manager configs
require('plugin.lsp') -- lsp configs
require('plugin.colorizer') -- render colors
require('plugin.lualine') -- status line
require('plugin.nvimtree') -- nvim-tree
require('plugin.treesitter') -- treesitter settings
require('plugin.which-key') -- show keybinds
require('plugin.gitsigns') -- show `git diff` in line-number
require('plugin.alpha') -- greetings at empty buffers
require('plugin.notify') -- notification manager
--require('plugin.tmp.toggleterm') -- ToggleTerm Settings
-- }}}
-- modules {{{
require('main') -- main options
require('extra') -- ftype specific extra options
require('skel') -- to input templates
require('cexecute') -- compile and execute with built-in term
require('keybind') -- set the keybindings and shortcuts
-- }}}
-- colorscheme {{{
require('schemes/ayu')
--require('schemes/tokyodark')
--require('schemes/nightfox')
--require('schemes/catppuccin')
--require('schemes/nord')
--require('schemes/solarized')
--require('schemes/dracula')
--require('schemes/tokyonight')

---- some favorate colorschemes
--[[ hybrid_material sunbather dalton tokyodark
     solarized material nord onedark
]]
--cmd [[ colorscheme hybrid ]]
--vim.cmd.colorscheme "hybrid"
--vim.cmd.colorscheme "256_noir"
-- }}}
-- NeoVide {{{
vim.o.guifont = "Fira Mono:h12"
-- }}}

-- term color {{{
local termcolor = 'tango'

if termcolor == 'dracula' then
	vim.g.terminal_color_0		=	"#21222c"
	vim.g.terminal_color_1		=	"#ff5555"
	vim.g.terminal_color_2		=	"#50fa7b"
	vim.g.terminal_color_3		=	"#f1fa8c"
	vim.g.terminal_color_4		=	"#bd93f9"
	vim.g.terminal_color_5		=	"#ff79c6"
	vim.g.terminal_color_6		=	"#8be9fd"
	vim.g.terminal_color_7		=	"#bbbbbb"
	vim.g.terminal_color_8		=	"#6272a4"
	vim.g.terminal_color_9		=	"#ff6e6e"
	vim.g.terminal_color_10		=	"#69ff94"
	vim.g.terminal_color_11		=	"#ffffa5"
	vim.g.terminal_color_12		=	"#d6acff"
	vim.g.terminal_color_13		=	"#ff92df"
	vim.g.terminal_color_14		=	"#a4ffff"
	vim.g.terminal_color_15		=	"#ffffff"
elseif termcolor == 'solarized' then
	vim.g.terminal_color_0		=	"#073642"
	vim.g.terminal_color_1		=	"#dc322f"
	vim.g.terminal_color_2		=	"#859900"
	vim.g.terminal_color_3		=	"#b58900"
	vim.g.terminal_color_4		=	"#268bd2"
	vim.g.terminal_color_5		=	"#d33682"
	vim.g.terminal_color_6		=	"#2aa198"
	vim.g.terminal_color_7		=	"#eee8d5"
	vim.g.terminal_color_8		=	"#002b36"
	vim.g.terminal_color_9		=	"#cb4b16"
	vim.g.terminal_color_10		=	"#586e75"
	vim.g.terminal_color_11		=	"#657b83"
	vim.g.terminal_color_12		=	"#839496"
	vim.g.terminal_color_13		=	"#6c71c4"
	vim.g.terminal_color_14		=	"#93a1a1"
	vim.g.terminal_color_15		=	"#fdf6e3"
elseif termcolor == 'tango' then
	vim.g.terminal_color_0		=	"#2e3436"
	vim.g.terminal_color_1		=	"#ef2929"
	vim.g.terminal_color_2		=	"#8ae234"
	vim.g.terminal_color_3		=	"#fce94f"
	vim.g.terminal_color_4		=	"#729fcf"
	vim.g.terminal_color_5		=	"#ad7fa8"
	vim.g.terminal_color_6		=	"#34e2e2"
	vim.g.terminal_color_7		=	"#eeeeec"
	vim.g.terminal_color_8		=	"#555753"
	vim.g.terminal_color_9		=	"#cc0000"
	vim.g.terminal_color_10		=	"#4e9a06"
	vim.g.terminal_color_11		=	"#c4a000"
	vim.g.terminal_color_12		=	"#3465a4"
	vim.g.terminal_color_13		=	"#75507b"
	vim.g.terminal_color_14		=	"#06989a"
	vim.g.terminal_color_15		=	"#d3d7cf"
elseif termcolor == 'breeze' then
	vim.g.terminal_color_0		=	"#232627"
	vim.g.terminal_color_1		=	"#ed1515"
	vim.g.terminal_color_2		=	"#11d116"
	vim.g.terminal_color_3		=	"#f67400"
	vim.g.terminal_color_4		=	"#1d99f3"
	vim.g.terminal_color_5		=	"#9b59b6"
	vim.g.terminal_color_6		=	"#1abc9c"
	vim.g.terminal_color_7		=	"#fcfcfc"
	vim.g.terminal_color_8		=	"#7f8c8d"
	vim.g.terminal_color_9		=	"#c0392b"
	vim.g.terminal_color_10		=	"#1cdc9a"
	vim.g.terminal_color_11		=	"#fdbc4b"
	vim.g.terminal_color_12		=	"#3daee9"
	vim.g.terminal_color_13		=	"#8e44ad"
	vim.g.terminal_color_14		=	"#16a085"
	vim.g.terminal_color_15		=	"#ffffff"
elseif termcolor == 'vscode' then
	vim.g.terminal_color_0		=	"#000000"
	vim.g.terminal_color_1		=	"#cd3131"
	vim.g.terminal_color_2		=	"#0dbc79"
	vim.g.terminal_color_3		=	"#e5e510"
	vim.g.terminal_color_4		=	"#2472c8"
	vim.g.terminal_color_5		=	"#bc3fbc"
	vim.g.terminal_color_6		=	"#11a8cd"
	vim.g.terminal_color_7		=	"#e5e5e5"
	vim.g.terminal_color_8		=	"#666666"
	vim.g.terminal_color_9		=	"#f14c4c"
	vim.g.terminal_color_10		=	"#50fa7b"
	vim.g.terminal_color_11		=	"#f1fa8c"
	vim.g.terminal_color_12		=	"#3b8eea"
	vim.g.terminal_color_13		=	"#d670d6"
	vim.g.terminal_color_14		=	"#29b8db"
	vim.g.terminal_color_15		=	"#e5e5e5"
end

--local terminal_color_background		=	"#002b36"
--local terminal_color_foreground		=	"#cccccc"
--
--vim.cmd [[highlight FloatBorder guibg='#002b36' guifg='#cccccc']]
-- }}}
