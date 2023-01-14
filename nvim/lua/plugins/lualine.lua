-- helper {{{
local expand = vim.fn.expand
-- }}}
-- autofill sym {{{
local function showautofill()
	local Achar = ''
	local Mchar = ''
	local Schar = ''
	if Autofill == 1 then
		Achar = 'α'
	end
	if Mautofill == 1 then
		Mchar = 'μ'
	end
	if Sautofill == 1 then
		Mchar = 'Σ'
	end
	return Achar .. Mchar .. Schar
end
-- }}}
-- split sym {{{
local function ShowSplitMode()
	if Wind_style == 'h' then
		return 'Hor'
	elseif Wind_style == 'v' then
		return 'Ver'
	elseif Wind_style == 'f' then
		return 'Flo'
	else
		return ''
	end
--	return '-'
end
-- }}}
-- basename {{{
local function Split(s, delimiter)
	local result = {};
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match);
	end
	return result;
end

local function basename()
	local myString = expand('%:p')
	local split_string = Split(myString, "/")

	local i = 0
	for _ in pairs(split_string) do
		i = i + 1
	end
--  
	return ' ' .. split_string[i - 1]
end
-- }}}
-- bullet sym {{{
local function bullet()
	return '●'
end
-- }}}
--  sym {{{
local function vimlogo()
	return ''
end
local function buftext()
	return 'buf'
end
-- }}}
-- filetype {{{
local function currfiletype()
	return vim.bo.filetype
end
-- }}}
-- username {{{
local function username()
	return os.getenv("USER")
--	return 'test'
end
-- }}}

require('lualine').setup {
	options = {
		icons_enabled = true,
--		theme = '256_noir',
--		theme = 'tokyonight',
		theme = 'dracula-nvim',
--		theme = 'solarized',
--		theme = 'horizon',
--		theme = 'nord',
--		theme = 'ayu',
--		theme = 'material',
--		theme = 'onedark',
--		theme = 'wombat',
--		
		component_separators = { left = '⟩', right = '⟨'},
--		component_separators = { left = '›', right = '‹'},
--		component_separators = { left = '', right = ''},
--		
		section_separators = { left = '', right = ''},
--		section_separators = { left = '⟩', right = '⟨'},
--		section_separators = { left = '', right = ''},
--		
--		         
--		         
--		         
--		»   «   ›   ‹
--		      
--		   ●    
--		
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = {
--			'mode',
			{ 'mode', fmt = function(str) return str:sub(1,3) end },
		},
		lualine_b = {{'branch', icon = ''}},
		lualine_c = {basename, '%f %m'},
		lualine_x = {showautofill, 'fileformat'},
		lualine_y = {'%l/%L:%c',
--			currfiletype,
			{ 'filetype', colored = false, icon_only = false, icon = { align = 'left' }, },
		},
		lualine_z = {'progress'
		}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'%F'},
--		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {
		lualine_a = {buftext},
		lualine_b = {
			{
				'buffers',
				show_filename_only = true,   -- Shows shortened relative path when set to false.
				hide_filename_extension = true,   -- Hide filename extension when set to true.
				show_modified_status = true, -- Shows indicator when the buffer is modified.

				mode = 2, -- 0: Shows buffer name
--							 1: Shows buffer index
--							 2: Shows buffer name + buffer index
--							 3: Shows buffer number
--							 4: Shows buffer name + buffer number

--				max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
--					it can also be a function that returns
--					the value of `max_length` dynamically.
				symbols = {
					modified = ' ●', -- Text to show when the buffer is modified
					alternate_file = '', -- Text to show to identify the alternate file
					directory =  '', -- Text to show when the buffer is a directory
				},
			}
		},
		lualine_c = {},
		lualine_x = {'diagnostics', 'diff'},
		lualine_y = {ShowSplitMode, username},
		lualine_z = {vimlogo},
--		lualine_z = {bullet}
	},
	extensions = {}
}
