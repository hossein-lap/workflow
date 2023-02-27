-- just for less typing
function raw_tex(t)
	return pandoc.RawBlock('tex', t)
end

-- Wrap code blocks in tcolorbox environments
function CodeBlock(cb)
----	local wrapper = cmdparser(cb.classes, 'ls /tmp/test.*') -- os.capture(cb)
--	print(cb.text)
--	print()
	local codeblock = {
		raw_tex '\\begin{quote}',
		raw_tex '\\begin{quote}',
			cb,
		raw_tex '\\end{quote}',
		raw_tex '\\end{quote}',
	}

	return codeblock
end
