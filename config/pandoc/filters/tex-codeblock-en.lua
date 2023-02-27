---- helper: store output of a command into a varaible
--function os.capture(cmd, raw)
--	local f = assert(io.popen(cmd, 'r'))
--	local s = assert(f:read('*a'))
--	f:close()
--	if raw then return s end
--	s = string.gsub(s, '^%s+', '')
--	s = string.gsub(s, '%s+$', '')
--	s = string.gsub(s, '[\n\r]+', ' ')
--	return s
--end

---- command parser
--function cmdparser(ft, cmd)
--	local list = {
--		shell = "sh -c \\\"" .. cmd .. "\\\"",
--		sh = "sh -c \\\"" .. cmd .. "\\\"",
--		bash = "sh -c \\\"" .. cmd .. "\\\"",
--		python = "python3 -c \\\"" .. cmd .. "\\\"",
--		py = "python3 -c \\\"" .. cmd .. "\\\"",
--	}
--	print(list[ft])
--	local out = os.capture(list[ft])
--	return out
--end

-- just for less typing
function raw_tex(t)
	return pandoc.RawBlock('tex', t)
end

-- Wrap code blocks in tcolorbox environments
function CodeBlock(cb)
----	local wrapper = cmdparser(cb.classes, 'ls /tmp/test.*') -- os.capture(cb)
	print(cb.text)
	print()
	cbft = cb.classes[1]
----	local temp = string(cb.text)
--	local wrapper = cmdparser(cbft, cb.text) -- os.capture(cb) -- os.capture(wrapper)
----	local test = cmdparser(cb.classes[1], temp) -- os.capture(cb) -- os.capture(wrapper)
--	local output = string.format("\\begin{verbatim}\n%s\n\\end{verbatim}", wrapper)
	local codeblockbox = {
		raw_tex '\\begin{quote}',
		raw_tex '\\begin{bbox}',
			cb,
--		raw_tex '\\tcblower',
--			raw_tex(output),
		raw_tex '\\end{bbox}',
		raw_tex '\\end{quote}',
	}
	local codeblock = {
		raw_tex '\\begin{quote}',
			cb,
		raw_tex '\\end{quote}',
	}

	if cbft then
		return codeblockbox
	else
		return codeblock
	end
end
