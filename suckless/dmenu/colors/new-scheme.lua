#!/bin/lua5.4

-- help function
local function help()
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
local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- variable set
--local color  = "ff7700"
local color  = arg[2]
local dcolor = "#000000"
local lcolor = "#ffffff"

local bg_scheme = {
	'static const char normal_fg[]      = "'..lcolor..'";',
	'static const char normal_bg[]      = "'..dcolor..'";',
	'static const char focus_fg[]       = "'..dcolor..'";',
	'static const char focus_bg[]       = "#'..color..'";',
	'static const char sel_fg[]         = "#'..color..'";',
	'static const char sel_bg[]         = "'..dcolor..'";',
	'static const char high_sel_fg[]    = "'..dcolor..'";',
	'static const char high_sel_bg[]    = "#'..color..'";',
	'static const char high_normal_fg[] = "#'..color..'";',
	'static const char high_normal_bg[] = "'..dcolor..'";',
}

local fg_scheme = {
	'static const char normal_fg[]      = "'..lcolor..'";',
	'static const char normal_bg[]      = "'..dcolor..'";',
	'static const char focus_fg[]       = "#'..color..'";',
	'static const char focus_bg[]       = "'..dcolor..'";',
	'static const char sel_fg[]         = "'..dcolor..'";',
	'static const char sel_bg[]         = "#'..color..'";',
	'static const char high_sel_fg[]    = "#'..color..'";',
	'static const char high_sel_bg[]    = "'..dcolor..'";',
	'static const char high_normal_fg[] = "'..dcolor..'";',
	'static const char high_normal_bg[] = "#'..color..'";',
}

-- main
local fg = 'fg/' .. arg[1] .. '.h'
local bg = 'bg/' .. arg[1] .. '.h'

if file_exists(fg) then
	io.write("Colors exists:",
	'\t', fg, '\t', '\27[0;3m',
	'\27[0m', "[Abrot]\n")
	if file_exists(bg) then
		io.write("Colors exists:",
		'\t', bg, '\t', '\27[0;3m',
		'\27[0m', "[Abrot]\n")
		return 2
	else
		return 1
	end
else
	local fg_file = assert(io.open (fg, 'w'))
	for _,v in ipairs(fg_scheme) do
		fg_file:write(v, '\n')
	end
	fg_file:close()

	local bg_file = assert(io.open (bg, 'w'))
	for _,v in ipairs(bg_scheme) do
		bg_file:write(v, '\n')
	end
	bg_file:close()

	print(arg[1] .. ": colorscheme created")
end
