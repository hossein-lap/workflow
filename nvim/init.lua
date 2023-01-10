----*** neovim config ***---
--require('helper') ---- helper functions module

-- helper {{{
local set = vim.opt
local cmd = vim.cmd
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
