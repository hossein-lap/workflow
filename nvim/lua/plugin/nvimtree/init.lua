-- helper {{{
local cmd = vim.cmd
local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

-- functions 
-- collapse all {{{
local function collapse_all()
	require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end
-- }}}
-- edit or open {{{
local function edit_or_open()
	-- open as vsplit on current node
	local action = "edit"
	local node = lib.get_node_at_cursor()

	-- Just copy what's done normally with vsplit
	if node.link_to and not node.nodes then
		require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
		view.close() -- Close the tree if file was opened
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)
	else
		require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
		view.close() -- Close the tree if file was opened
	end
end
-- }}}
-- vsplit preview {{{
local function vsplit_preview()
	-- open as vsplit on current node
	local action = "vsplit"
	local node = lib.get_node_at_cursor()

	-- Just copy what's done normally with vsplit
	if node.link_to and not node.nodes then
		require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)

	else
		require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
	end

	-- Finally refocus on tree if it was lost
	view.focus()
end
-- }}}
-- open on directories (current window) {{{
function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end
-- }}}
---- open on directories (new window) {{{
--local function open_nvim_tree(data)
--	-- buffer is a directory
--	local directory = vim.fn.isdirectory(data.file) == 1
--
--	if not directory then
--		return
--	end
--
--	-- create a new, empty buffer
--	vim.cmd.enew()
--
--	-- wipe the directory buffer
--	vim.cmd.bw(data.buf)
--
--	-- change to the directory
--	vim.cmd.cd(data.file)
--
--	-- open the tree
--	require("nvim-tree.api").tree.open()
--end
---- }}}
-- }}}

-- configs {{{
require("nvim-tree").setup({
	open_on_setup = false, -- deprecated
	auto_reload_on_write = true,
	sort_by = "case_sensitive",
	disable_netrw = true,
	hijack_cursor = false,
	reload_on_bufenter = true,
	view = {
		adaptive_size = false,
		mappings = {
			custom_only = false,
			list = {
				{ key = "u", action = "dir_up" },
				{ key = "l", action = "edit", action_cb = edit_or_open },
				{ key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
				{ key = "h", action = "close_node" },
				{ key = "H", action = "collapse_all", action_cb = collapse_all }
			},
		},
	},
	actions = {
		open_file = {
			quit_on_open = false
		}
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	log = {
		enable = false,
		truncate = true,
		types = {
			git = true,
			profile = true,
		},
	},
})
-- }}}

--require("nvim-tree.api").tree.toggle({
--	path = nil,
--	current_window = false,
--	find_file = false,
--	update_root = false,
--	focus = true,
--})

--vim.api.nvim_create_autocmd("BufEnter", {
--	nested = true,
--	callback = function()
--		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
--			vim.cmd "quit"
--		end
--	end
--})

-- NvimTree Toggle {{{
-- key mapping {{{
local function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, key, command, options)
end
-- }}}

--NvimTreeOpen = 0

---- NvimTree Toggle {{{
--map('n', '<leader>qf', ':lua ntree<CR>',
--		{ silent = true, desc = "Toggle › nvim tree" })
---- }}}

--function nvim_tree_toggle()
--	if NvimTreeOpen == 0 then
--		NvimTreeOpen = 1
--		cmd [[:NvimTreeOpen]]
--		cmd "call win_gotoid(1000)"
--	else
--		NvimTreeOpen = 0
--		cmd [[:NvimTreeClose]]
--	end
--end
-- }}}

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
