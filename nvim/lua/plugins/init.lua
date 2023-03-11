local cmd = vim.cmd
local fn = vim.fn
local packer = require('packer')

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		'git', 'clone', '--depth', '1',
		'https://github.com/wbthomason/packer.nvim', install_path
	})
	vim.cmd [[packadd packer.nvim]]
end

packer.init {
	max_jobs = 1, -- Simultaneous download limit
}

return packer.startup(function()
	use 'wbthomason/packer.nvim'	-- Plugin manager
	use 'neovim/nvim-lspconfig'	-- Configurations for Nvim LSP
	use 'hrsh7th/nvim-gtd'		-- Go To Definition plugin for neovim
	use 'hrsh7th/nvim-cmp'		-- Autocompletion plugin based on nvim's builtin lsp
		use 'hrsh7th/cmp-nvim-lsp'	  -- nvim builtin lsp source for nvim-cmp
		use 'hrsh7th/cmp-nvim-lua'	  -- nvim Lua API source for nvim-cmp
		use 'hrsh7th/cmp-buffer'	  -- buffer source for nvim-cmp
		use 'hrsh7th/cmp-path'		  -- path source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip'	-- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip'		-- Snippets plugin

	use 'nvim-treesitter/nvim-treesitter'	-- Treesitter [more syntax color]
	use 'norcalli/nvim-colorizer.lua'	-- Hex color preview
	use 'goolord/alpha-nvim'		-- Greeting

	use 'nvim-lualine/lualine.nvim'		-- status line
	use 'kyazdani42/nvim-tree.lua'		-- tree file-manager
	use 'lewis6991/gitsigns.nvim'		-- Git signs
	use 'folke/which-key.nvim'		-- show maps
	use 'kyazdani42/nvim-web-devicons'	-- icons

--	use 'onsails/lspkind.nvim'		-- icons in lsp-menu
--	use 'akinsho/toggleterm.nvim'		-- terminal plugin

	---- colorschemes
	use 'hossein-lap/vim-256noir'
	use 'folke/tokyonight.nvim'
	use 'tiagovla/tokyodark.nvim'
	use 'Mofiqul/dracula.nvim'
	use 'ishan9299/nvim-solarized-lua'
	use 'shaunsingh/nord.nvim'
	use { 'catppuccin/nvim', as = 'catppuccin' }
	use 'EdenEast/nightfox.nvim'
	use 'Shatur/neovim-ayu'
--	use 'navarasu/onedark.nvim'
--	use 'marko-cerovac/material.nvim'
end)
