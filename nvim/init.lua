----*** neovim config ***---
--require('helper') ---- helper functions module

-- helper {{{
local set = vim.opt
local cmd = vim.cmd
local g = vim.g
-- }}}

vim.go.python3_host_prog = '/bin/python'

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
require('plugins.tokyodark') ---- Colorscheme
require('plugins.nvimtree') ---- NvimTree
require('plugins.treesitter') ---- Treesitter Settings
require('plugins.which-key') ---- GitSigns Settings
require('plugins.gitsigns') ---- Treesitter Settings
--require('plugins.toggleterm') ---- ToggleTerm Settings
-- }}}
-- colorscheme {{{
--cmd [[ colorscheme hybrid_material ]]

--require('plugins.tokyonight')
--cmd [[ colorscheme tokyonight ]]

---- some favorate colorschemes
--[[ hybrid_material sunbather dalton tokyodark
     solarized material nord onedark
]]

-- colorscheme options
vim.g.tokyodark_transparent_background = false
vim.g.tokyodark_enable_italic_comment = false
vim.g.tokyodark_enable_italic = false
vim.g.tokyodark_color_gamma = "1.0"
cmd [[ colorscheme tokyodark ]]
-- }}}
-- NeoVide {{{
vim.o.guifont = "Fira Mono:h12"
-- }}}

-- term color {{{
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

--local terminal_color_background		=	"#002b36"
--local terminal_color_foreground		=	"#cccccc"
--
--cmd [[highlight FloatBorder guibg='#002b36' guifg='#cccccc']]
-- }}}
