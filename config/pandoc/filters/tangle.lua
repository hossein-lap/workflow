--** THIS IS BROKEN **--

local system = require 'pandoc.system'

--local function tangle_src(src, filetype, outfile)
--	system.with_temporary_directory('tikz2image', function (tmpdir)
--		system.with_working_directory(tmpdir, function()
--	--[[
--	--]]
--			os.execute('pdflatex tikz.tex')
--			if filetype == 'pdf' then
--				os.rename('tikz.pdf', outfile)
--			else
--				os.execute('pdf2svg tikz.pdf ' .. outfile)
--			end
--		end)
--	end)
--end

local function file_exists(name)
	local f = io.open(name, 'r')
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

local dirname = os.getenv("PWD")
local outfile = dirname .. '/tangle.out'

if not file_exists(outfile) then
	local file = io.open(outfile, 'w')
		file:close()
end

function CodeBlock(cb)
	local codetype = cb.classes[1]
	if codetype then
		local tt = ''
		tt = tt .. cb.text .. '\n\n'

		local f = io.open(outfile, 'a')
			f:write(tt)
		f:close()
	end
end
