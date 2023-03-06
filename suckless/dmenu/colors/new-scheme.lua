#!/bin/lua5.4

-- help function
function help()
	io.stderr:write("Create new colorscheme", "\n\n",
		"Usage: ", arg[0], " <color-name> <hex-color>", "\n\n",
		"\t", "exmaple: \n\n",
		"\t", "$ ", arg[0], " cyan 00ffff \n\n",
		"Run without argument for help page.", "\n")
end

-- check if has to args to show help message
if arg[2] == nil then
	if arg[1] == nil then
		help()
		os.exit(-1)
	else
		help()
		os.exit(3)
	end
end

-- check for existing scheme
function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
	   io.close(f)
	   return true
	else
	   return false
	end
end

-- variable set
local color = arg[2]
local dcolor = "#000000"
local lcolor = "#ffffff"

local bg_normal_fg = [[static const char normal_bg[]	= "]] ..  dcolor .. [[";]]
local bg_normal_bg = [[static const char normal_fg[]	= "]] ..  lcolor .. [[";]]
local bg_focus_fg = [[static const char focus_fg[]	= "]] ..  dcolor .. [[";]]
local bg_focus_bg = [[static const char focus_bg[]	= "#]] .. color .. [[";]]
local bg_sel_fg = [[static const char sel_fg[]	= "#]] .. color .. [[";]]
local bg_sel_bg = [[static const char sel_bg[]	= "]] ..  dcolor .. [[";]]

local fg_normal_fg	= [[static const char normal_bg[]	= "]] ..  dcolor .. [[";]]
local fg_normal_bg	= [[static const char normal_fg[]	= "]] ..  lcolor .. [[";]]
local fg_focus_fg	= [[static const char focus_fg[]	= "#]] .. color .. [[";]]
local fg_focus_bg	= [[static const char focus_bg[]	= "]] ..  dcolor .. [[";]]
local fg_sel_fg		= [[static const char sel_fg[]	= "]] ..  dcolor .. [[";]]
local fg_sel_bg		= [[static const char sel_bg[]	= "#]] .. color .. [[";]]

-- main
local fg = 'fg/' .. arg[1] .. '.h'
local bg = 'bg/' .. arg[1] .. '.h'

if file_exists(fg) then
	io.write("Colors exists\n",
			'\t', fg, '\n', '\t\27[0;3m',
			'\27[0m\n', "Abroting\n")
	if file_exists(bg) then
		io.write("Colors exists\n",
				'\t', bg, '\n', '\t\27[0;3m',
				'\27[0m\n', "Abroting\n")
		return 2
	else
		return 1
	end
else
	local fg_file = assert(io.open (fg, 'w'))
		fg_file:write(fg_normal_bg, '\n')
		fg_file:write(fg_normal_fg, '\n')
		fg_file:write(fg_focus_bg, '\n')
		fg_file:write(fg_focus_fg, '\n')
		fg_file:write(fg_sel_bg, '\n')
		fg_file:write(fg_sel_fg, '\n')
	fg_file:close()

	local bg_file = assert(io.open (bg, 'w'))
		bg_file:write(bg_normal_bg, '\n')
		bg_file:write(bg_normal_fg, '\n')
		bg_file:write(bg_focus_bg, '\n')
		bg_file:write(bg_focus_fg, '\n')
		bg_file:write(bg_sel_bg, '\n')
		bg_file:write(bg_sel_fg, '\n')
	bg_file:close()

	print("Colorscheme created")
end
