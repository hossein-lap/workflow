local util = require('packer.util')
local packer = require('packer')
--local use = packer.use

-- bootstrap {{{
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({
		'git', 'clone', '--depth', '1',
		'https://github.com/wbthomason/packer.nvim', install_path
	})
	vim.cmd [[packadd packer.nvim]]
end
-- }}}
-- configs {{{
packer.reset()
packer.init {
	ensure_dependencies = true, -- Should packer install plugin dependencies?
	snapshot = nil, -- Name of the snapshot you would like to load at startup
	snapshot_path = util.join_paths(vim.fn.stdpath 'cache', 'packer.nvim'), -- Default save directory for snapshots
	package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack'),
	compile_path = util.join_paths(vim.fn.stdpath('config'), 'plugin', 'packer_compiled.lua'),
	plugin_package = 'packer', -- The default package for plugins
	max_jobs = 1, -- Limit the number of simultaneous jobs. nil means no limit
	auto_clean = true, -- During sync(), remove unused plugins
	compile_on_sync = true, -- During sync(), run packer.compile()
	disable_commands = false, -- Disable creating commands
	opt_default = false, -- Default to using opt (as opposed to start) plugins
	transitive_opt = true, -- Make dependencies of opt plugins also opt by default
	transitive_disable = true, -- Automatically disable dependencies of disabled plugins
	auto_reload_compiled = true, -- Automatically reload the compiled file after creating it.
	preview_updates = false, -- If true, always preview updates before choosing which plugins to update, same as `PackerUpdate --preview`.
	git = {
		cmd = 'git', -- The base command for git operations
		subcommands = { -- Format strings for git subcommands
			update         = 'pull --ff-only --progress --rebase=false',
			install        = 'clone --depth %i --no-single-branch --progress',
			fetch          = 'fetch --depth 999999 --progress',
			checkout       = 'checkout %s --',
			update_branch  = 'merge --ff-only @{u}',
			current_branch = 'branch --show-current',
			diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
			diff_fmt       = '%%h %%s (%%cr)',
			get_rev        = 'rev-parse --short HEAD',
			get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
			submodules     = 'submodule update --init --recursive --progress'
		},
		depth = 1, -- Git clone depth
		clone_timeout = 60, -- Timeout, in seconds, for git clones
		default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
	},
	display = {
		non_interactive = false, -- If true, disable display windows for all operations
		compact = true, -- If true, fold updates results by default
		-- An optional function to open a window for packer's display
		open_fn = nil,
--		open_fn = function()
--			local result, win, buf = util.float {
--				border = {
--					{ '╭', 'FloatBorder' },
--					{ '─', 'FloatBorder' },
--					{ '╮', 'FloatBorder' },
--					{ '│', 'FloatBorder' },
--					{ '╯', 'FloatBorder' },
--					{ '─', 'FloatBorder' },
--					{ '╰', 'FloatBorder' },
--					{ '│', 'FloatBorder' },
--				},
--			}
--			vim.api.nvim_win_set_option(win, 'winhighlight', 'NormalFloat:Normal')
--			return result, win, buf
--		end,
		open_cmd = 'split \\[packer\\]', -- An optional command to open a window for packer's display
		working_sym = '⟳', -- The symbol for a plugin being installed/updated
		error_sym = '✗', -- The symbol for a plugin with an error in installation/updating
		done_sym = '✓', -- The symbol for a plugin which has completed installation/updating
		removed_sym = '-', -- The symbol for an unused plugin which was removed
		moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
		header_sym = '━', -- The symbol for the header line in packer's display
		show_all_info = true, -- Should packer show all update details automatically?
		prompt_border = 'double', -- Border style of prompt popups.
		keybindings = { -- Keybindings for the display window
			quit = 'q',
			toggle_update = 'u', -- only in preview
			continue = 'c', -- only in preview
			toggle_info = '<CR>',
			diff = 'd',
			prompt_revert = 'r',
		}
	},
	luarocks = {
		python_cmd = 'python' -- Set the python command to use for running hererocks
	},
	log = { level = 'debug' }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal".
	profile = {
		enable = false,
		threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
	},
	autoremove = true, -- Remove disabled or unused plugins without prompting the user
}
-- }}}
-- plugins {{{
return packer.startup(function(use)
	use 'wbthomason/packer.nvim' -- Plugin manager
	use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
	use 'hrsh7th/nvim-gtd' -- Go To Definition plugin for neovim
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin based on nvim's builtin lsp
		use 'hrsh7th/cmp-nvim-lsp' -- nvim builtin lsp source for nvim-cmp
		use 'hrsh7th/cmp-nvim-lua' -- nvim Lua API source for nvim-cmp
		use 'hrsh7th/cmp-buffer' -- buffer source for nvim-cmp
		use 'hrsh7th/cmp-path' -- path source for nvim-cmp
		use 'uga-rosa/cmp-dictionary' -- dictionary source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip' -- Snippets plugin

	use 'nvim-treesitter/nvim-treesitter' -- Treesitter [more syntax color]

	use 'norcalli/nvim-colorizer.lua' -- Hex color preview
	use 'goolord/alpha-nvim' -- Greeting

	use 'nvim-lualine/lualine.nvim' -- statusline
	use 'kyazdani42/nvim-tree.lua' -- tree file-manager
	use 'lewis6991/gitsigns.nvim' -- Git signs
	use 'folke/which-key.nvim' -- show mapps
	use 'kyazdani42/nvim-web-devicons' -- icons
	use 'rcarriga/nvim-notify' -- notification manager

--	use 'onsails/lspkind.nvim' -- icons in lsp-menu
--	use 'akinsho/toggleterm.nvim' -- terminal plugin

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
-- }}}
