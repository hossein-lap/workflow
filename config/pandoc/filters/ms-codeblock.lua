--** THIS WILL BROKE ms-image.lua FILTER **--
-- helper: store output of a command into a varaible
function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

-- just for less typing
function raw_ms(t)
	return pandoc.RawBlock('ms', t)
end

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

-- Wrap code blocks in tcolorbox environments
function CodeBlock(cb)
----	local wrapper = cmdparser(cb.classes, 'ls /tmp/test.*') -- os.capture(cb)
	print(cb.classes[1], cb.text)
	cbft = cb.classes[1]
----	local temp = string(cb.text)
--	local wrapper = cmdparser(cbft, cb.text) -- os.capture(cb) -- os.capture(wrapper)
----	local test = cmdparser(cb.classes[1], temp) -- os.capture(cb) -- os.capture(wrapper)
--	local output = string.format("\\begin{verbatim}\n%s\n\\end{verbatim}", wrapper)
    local backsrender = string.gsub(cb.text, '\\', '\\\\')
    local charsfixed = string.gsub(backsrender, '^\\.', '\\\\.')
	local codeblockbox = {
--		raw_ms '.cb',
----		raw_ms '\\begin{tcolorbox}',
--			cb,
----		raw_ms '\\end{tcolorbox}',
--		raw_ms './cb',
		raw_ms(string.format('.QP\n.cb\n%s\n./cb', string.gsub(charsfixed, '\'', '\\(aq')))
	}
	local codeblock = {
--		raw_ms(string.format('.QP\n.ft CW\n%s\n.ft P\n', cb.text))
		raw_ms(string.format('.QP\n.ob\n%s\n./ob', charsfixed))
--		raw_ms '.QP',
--			cb,
--		raw_ms '.QP',
--			cb,
----		raw_ms '\\end{quote}',
	}

	if cbft then
		return codeblockbox
	else
		return codeblock
	end
end
