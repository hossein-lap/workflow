local cmd = vim.cmd
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		'git', 'clone', '--depth', '1',
		'https://github.com/wbthomason/packer.nvim', install_path
	})
	vim.cmd [[packadd packer.nvim]]
end

--cmd 'packadd packer.nvim'

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'	---- Plugin manager
	use 'neovim/nvim-lspconfig'		---- Configurations for Nvim LSP
	use 'hrsh7th/nvim-cmp'			---- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp'		---- LSP source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip'	---- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip'			---- Snippets plugin
	use 'nvim-treesitter/nvim-treesitter'		---- Treesitter [more syntax color]
	use 'norcalli/nvim-colorizer.lua'			---- Hex color preview
	use 'nvim-lualine/lualine.nvim'				---- status line
	use 'kyazdani42/nvim-web-devicons'			---- icons
	use { 'kyazdani42/nvim-tree.lua', tag = 'nightly' }		---- tree file-manager
	use 'lewis6991/gitsigns.nvim'				---- Git signs
	use "folke/which-key.nvim"					---- show maps
--	use 'onsails/lspkind.nvim'					---- icons in lsp-menu
--	use {"akinsho/toggleterm.nvim", tag = 'v2.*' }			---- terminal plugin
	use "goolord/alpha-nvim"				---- Greeting

	---- colorschemes
	use 'folke/tokyonight.nvim'
	use 'tiagovla/tokyodark.nvim'
	use 'Mofiqul/dracula.nvim'
	use 'ishan9299/nvim-solarized-lua'
	use 'shaunsingh/nord.nvim'
--	use { "catppuccin/nvim", as = "catppuccin" }
--	use "EdenEast/nightfox.nvim"
--	use 'navarasu/onedark.nvim'
--	use 'marko-cerovac/material.nvim'
end)
