-- helper {{{
local cmd = vim.cmd
-- }}}
require("nvim-tree").setup({
	open_on_setup = false,
	auto_reload_on_write = true,
	sort_by = "case_sensitive",
	disable_netrw = true,
	hijack_cursor = false,
	reload_on_bufenter = true,
	view = {
		adaptive_size = false,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
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

vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd "quit"
		end
	end
})

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
