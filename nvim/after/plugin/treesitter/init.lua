-- config
require'nvim-treesitter.configs'.setup {
	--parser_install_dir = "~/.config/nvim/plugin/treesitter-parsers",
	-- A list of parser names, or "all"
	ensure_installed = {
		"lua",
		"bash",
		"markdown",
		"c",
		"python",
		"rust",
		"go",
		"latex",
		"yaml", "json", "toml"
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	--ignore_install = { "javascript", "json", "java", "csharp" },
	ignore_install = { 'csharp', 'pascal',  },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		disable = { 'html', 'css', 'xml', 'config', 'diff', 'd', 'git' },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}
vim.opt.runtimepath:append("~/.config/nvim/plugin/treesitter-parsers")
------ Users of packer.nvim have reported that when using treesitter for folds, they
------ sometimes receive an error "No folds found", or that treesitter highlighting
------ does not apply. A workaround for this is to set the folding options in an
------ autocmd:
--vim.api.nvim_create_autocmd({'BufEnter','ButAdd','BufNew','BufNewFile','BufWinEnter'}, {
--	group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--	callback = function()
--		vim.opt.foldmethod= 'expr'
--		vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--end
--})
