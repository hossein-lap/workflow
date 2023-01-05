local expand = vim.fn.expand
local api = vim.api
local Tm  = require('toggleterm.terminal').Terminal
-- keymap function {{{
local function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
-- }}}

require'toggleterm'.setup {
	size = function(term)
			if term.direction == "horizontal" then
				return 20
			elseif term.direction == "vertical" then
				return 40 * 2
			end
		end,

	winbar = {
		enabled = true,
		name_formatter = function(Terminal) --  term: Terminal
			return Terminal.name
		end
	},

	highlights = {
		FloatBorder = {
			guifg = "#ff7777",
		},
	},

	direction = 'float',
	float_opts = {
		border = 'curved',
--		winblend = 3,
	},

	shell = 'bash',
	open_mapping = [[<leader>tt]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_terminals = false,
	start_in_insert = true,
	close_on_exit = false,
}

-- custom terminals {{{
-- horizontal terminal
function HorizTerm(wrapand)
	local theterm = Tm:new({
		direction = 'horizontal',
		cmd = wrapand,
	})
	theterm:toggle()
end

-- vertical terminal
function VertiTerm(wrapand)
	local theterm = Tm:new({
		direction = 'vertical',
		cmd = wrapand,
	})
	theterm:toggle()
end
-- }}}

map('n', '<leader>te', ":lua HorizTerm()<CR>")
map('n', '<leader>tr', ":lua VertiTerm()<CR>")
