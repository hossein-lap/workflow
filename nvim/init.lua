----*** neovim config ***---

-- helper {{{
local set = vim.opt
local cmd = vim.cmd
local g = vim.g
local go = vim.go
-- }}}

go.python3_host_prog = '/bin/python'

-- some options {{{
set.termguicolors = true
-- }}}
-- modules {{{
require('main') ---- main options
require('extra') ---- ftype specific extra options
require('skel') ---- to input templates
require('cexecute') ---- compile and execute with built-in term
require('keybind') ---- set the keybindings and shortcuts
-- }}}
-- Plugins {{{
require('plugins') ---- packer plugin-manager
require('plugins.lsp') ---- lsp configs
require('plugins.cmp') ---- Snippet Manager Configs
require('plugins.colorizer') ---- Colorizer Plugin
require('plugins.lualine') ---- Lualine [status line]
require('plugins.nvimtree') ---- NvimTree
require('plugins.treesitter') ---- Treesitter Settings
require('plugins.which-key') ---- GitSigns Settings
require('plugins.gitsigns') ---- Treesitter Settings
require('plugins.alpha') ---- ToggleTerm Settings
--require('plugins.toggleterm') ---- ToggleTerm Settings
-- }}}
-- colorscheme {{{

require('plugins/schemes/ayu')
--require('plugins/schemes/nightfox')
--require('plugins/schemes/catppuccin')
--require('plugins/schemes/nord')
--require('plugins/schemes/solarized')
--require('plugins/schemes/dracula')
--require('plugins/schemes/tokyodark')
--require('plugins/schemes/tokyonight')

---- some favorate colorschemes
--[[ hybrid_material sunbather dalton tokyodark
     solarized material nord onedark
]]
--cmd [[ colorscheme hybrid ]]
--vim.cmd.colorscheme "hybrid"
-- }}}
-- NeoVide {{{
vim.o.guifont = "Fira Mono:h12"
-- }}}

-- term color {{{
local termcolor = 'tango'

if termcolor == 'dracula' then
	g.terminal_color_0		=	"#21222c"
	g.terminal_color_1		=	"#ff5555"
	g.terminal_color_2		=	"#50fa7b"
	g.terminal_color_3		=	"#f1fa8c"
	g.terminal_color_4		=	"#bd93f9"
	g.terminal_color_5		=	"#ff79c6"
	g.terminal_color_6		=	"#8be9fd"
	g.terminal_color_7		=	"#bbbbbb"
	g.terminal_color_8		=	"#6272a4"
	g.terminal_color_9		=	"#ff6e6e"
	g.terminal_color_10		=	"#69ff94"
	g.terminal_color_11		=	"#ffffa5"
	g.terminal_color_12		=	"#d6acff"
	g.terminal_color_13		=	"#ff92df"
	g.terminal_color_14		=	"#a4ffff"
	g.terminal_color_15		=	"#ffffff"
elseif termcolor == 'solarized' then
	g.terminal_color_0		=	"#073642"
	g.terminal_color_1		=	"#dc322f"
	g.terminal_color_2		=	"#859900"
	g.terminal_color_3		=	"#b58900"
	g.terminal_color_4		=	"#268bd2"
	g.terminal_color_5		=	"#d33682"
	g.terminal_color_6		=	"#2aa198"
	g.terminal_color_7		=	"#eee8d5"
	g.terminal_color_8		=	"#002b36"
	g.terminal_color_9		=	"#cb4b16"
	g.terminal_color_10		=	"#586e75"
	g.terminal_color_11		=	"#657b83"
	g.terminal_color_12		=	"#839496"
	g.terminal_color_13		=	"#6c71c4"
	g.terminal_color_14		=	"#93a1a1"
	g.terminal_color_15		=	"#fdf6e3"
elseif termcolor == 'tango' then
	g.terminal_color_0		=	"#2e3436"
	g.terminal_color_1		=	"#ef2929"
	g.terminal_color_2		=	"#8ae234"
	g.terminal_color_3		=	"#fce94f"
	g.terminal_color_4		=	"#729fcf"
	g.terminal_color_5		=	"#ad7fa8"
	g.terminal_color_6		=	"#34e2e2"
	g.terminal_color_7		=	"#eeeeec"
	g.terminal_color_8		=	"#555753"
	g.terminal_color_9		=	"#cc0000"
	g.terminal_color_10		=	"#4e9a06"
	g.terminal_color_11		=	"#c4a000"
	g.terminal_color_12		=	"#3465a4"
	g.terminal_color_13		=	"#75507b"
	g.terminal_color_14		=	"#06989a"
	g.terminal_color_15		=	"#d3d7cf"
elseif termcolor == 'breeze' then
	g.terminal_color_0		=	"#232627"
	g.terminal_color_1		=	"#ed1515"
	g.terminal_color_2		=	"#11d116"
	g.terminal_color_3		=	"#f67400"
	g.terminal_color_4		=	"#1d99f3"
	g.terminal_color_5		=	"#9b59b6"
	g.terminal_color_6		=	"#1abc9c"
	g.terminal_color_7		=	"#fcfcfc"
	g.terminal_color_8		=	"#7f8c8d"
	g.terminal_color_9		=	"#c0392b"
	g.terminal_color_10		=	"#1cdc9a"
	g.terminal_color_11		=	"#fdbc4b"
	g.terminal_color_12		=	"#3daee9"
	g.terminal_color_13		=	"#8e44ad"
	g.terminal_color_14		=	"#16a085"
	g.terminal_color_15		=	"#ffffff"
elseif termcolor == 'vscode' then
	g.terminal_color_0		=	"#000000"
	g.terminal_color_1		=	"#cd3131"
	g.terminal_color_2		=	"#0dbc79"
	g.terminal_color_3		=	"#e5e510"
	g.terminal_color_4		=	"#2472c8"
	g.terminal_color_5		=	"#bc3fbc"
	g.terminal_color_6		=	"#11a8cd"
	g.terminal_color_7		=	"#e5e5e5"
	g.terminal_color_8		=	"#666666"
	g.terminal_color_9		=	"#f14c4c"
	g.terminal_color_10		=	"#50fa7b"
	g.terminal_color_11		=	"#f1fa8c"
	g.terminal_color_12		=	"#3b8eea"
	g.terminal_color_13		=	"#d670d6"
	g.terminal_color_14		=	"#29b8db"
	g.terminal_color_15		=	"#e5e5e5"
end

--local terminal_color_background		=	"#002b36"
--local terminal_color_foreground		=	"#cccccc"
--
--cmd [[highlight FloatBorder guibg='#002b36' guifg='#cccccc']]
-- }}}
