local system = require 'pandoc.system'

local function tikz2image(src, filetype, outfile)
	system.with_temporary_directory('tikz2image', function (tmpdir)
		system.with_working_directory(tmpdir, function()
			local f = io.open('tikz.tex', 'w')
			f:write(tikz_doc_template:format(src))
			f:close()
			os.execute('pdflatex tikz.tex')
			if filetype == 'pdf' then
				os.rename('tikz.pdf', outfile)
			else
				os.execute('pdf2svg tikz.pdf ' .. outfile)
			end
		end)
	end)
end

local function file_exists(name)
	local f = io.open(name, 'r')
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

function CodeBlock(cb, outfile)
	local dirname = os.getenv("PWD")
	local codetype = cb.classes[1]

	if codetype then
--		print(cb.text)
		print(outfile)
	end
end
