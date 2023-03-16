#!/bin/lua5.4

-- help function
function help()
	io.stderr:write("Create new colorscheme", "\n\n",
			"Usage: ", arg[0], " <color-name> <hex-color>", "\n",
			"\n", "\t",
			"exmaple: \n\n\t", "$ ", arg[0], " cyan 00ffff \n",
			"\n", "Run without argument for help page.",
			"\n")
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

local normal_fg = [[static const char normbgcolor[]		= "#000000";]]
local normal_bg = [[static const char normfgcolor[]		= "#ccccce";]]

local focus_bg = [[static const char selbgcolor[]		= "#]] .. color .. [[";]]
local focus_fg = [[static const char selfgcolor[]		= "#000000";]]

local sel_fg = [[static const char urgfgcolor[]		= "#000000";]]
local sel_bg = [[static const char urgbgcolor[]		= "#ff0000";]]

---- main
local fg = 'solid/' .. arg[1] .. '.h'


if file_exists(fg) then
	io.write("Colors exists\n",
			'\t', fg, '\n', '\t\27[0;3m',
			'\27[0m\n', "Abroting\n")
	return 1
else

	print("Colorscheme created")

	local fg_file = assert(io.open (fg, 'w'))
		fg_file:write(normal_bg, '\n')
		fg_file:write(normal_fg, '\n')
		fg_file:write(focus_bg, '\n')
		fg_file:write(focus_fg, '\n')
		fg_file:write(sel_bg, '\n')
		fg_file:write(sel_fg, '\n')
	fg_file:close()
end
