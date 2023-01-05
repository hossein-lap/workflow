#!/bin/lua5.4
--  _  _
-- | || | github: hossein-lap
-- | __ | email:  hosteam01@gmail.com
-- |_||_| matrix: hosaidenpwd:matrix.org
--

function help()
	io.stderr:write("Create new colorscheme", "\n\n",
			"Usage: ", arg[0], " <color-name> <hex-color>", "\n",
			"\n", "\t",
			"exmaple: \n\n\t", "$ ", arg[0], " cyan 00ffff \n",
			"\n", "Run without argument for help page.",
			"\n")
end

if arg[2] == nil then
	if arg[1] == nil then
		help()
		os.exit(-1)
	else
		help()
		os.exit(3)
	end
end

function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
	   io.close(f)
	   return true
	else
	   return false
	end
end

local color = arg[2]

local normals = [[static const char normal_bg[]		= "#000000";
static const char normal_br[]		= "#444444";
static const char normal_fg[]		= "#999999";
]]

local focus_br = [[static const char focus_br[]		= "#]] .. color .. [[";]]

local b_focus_bg = [[static const char focus_bg[]		= "#]] .. color .. [[";]]
local b_focus_fg = [[static const char focus_fg[]		= "#000000";]]
local f_focus_fg = [[static const char focus_bg[]		= "#]] .. color .. [[";]]
local f_focus_bg = [[static const char focus_fg[]		= "#000000";]]

---- main
local bg = 'bg/' .. arg[1] .. '.h'
local fg = 'fg/' .. arg[1] .. '.h'
--
--
if file_exists(bg) and file_exists(fg) then
	io.write("Colors exists\n",
			'\t', fg, '\n',
			'\t\27[0;3m', bg, '\27[0m\n',
			"Abroting\n")
	return 1
else

	print("Colorscheme created")

	local fg_file = assert(io.open (fg, 'w'))
		fg_file:write(normals)
		fg_file:write(f_focus_bg, '\n')
		fg_file:write(f_focus_fg, '\n')
		fg_file:write(focus_br, '\n')
	fg_file:close()

	local bg_file = io.open (bg, 'w')
		bg_file:write(normals)
		bg_file:write(b_focus_bg, '\n')
		bg_file:write(b_focus_fg, '\n')
		bg_file:write(focus_br, '\n')
	bg_file:close()
	return 0
end
