-- variables {{{
HOME = os.getenv("HOME")
set = vim.opt
cmd = vim.cmd
api = vim.api
expand = vim.fn.expand

-- set <leader> key
vim.g.mapleader = '\\'
-- }}}
-- Functions {{{
-- autocmd {{{
function au(commands, patterns, evnt)
	if evnt == nil then
		evnt = 'FileType'
	end
	api.nvim_create_autocmd(evnt, {
		pattern = patterns,
		command = commands,
--		 group = patterns .. 'groups'
	})
end
-- }}}
-- key mapping {{{
function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
-- keymap function {{{
function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
--}}}
-- }}}
-- unmap {{{
function umap(mode, key)
	if not mode or not key then
		vim.notify('umap(mode, key) must have at least two arguments', 4,
			{title = 'Error on using umap()'})
		return 1
	end
	api.nvim_del_keymap(mode, key)
end
-- }}}
-- NvimTree Toggle {{{
NvimTreeOpen = 0

function nvim_tree_toggle()
	if NvimTreeOpen == 0 then
		NvimTreeOpen = 1
		cmd [[:NvimTreeOpen]]
		cmd "call win_gotoid(1000)"
	else
		NvimTreeOpen = 0
		cmd [[:NvimTreeClose]]
	end
end
-- }}}
-- }}}
