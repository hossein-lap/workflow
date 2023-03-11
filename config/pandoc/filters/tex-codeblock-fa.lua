---- just for less typing
function raw_tex(t)
	return pandoc.RawBlock('tex', t)
end

---- Wrap code blocks in tcolorbox environments
function CodeBlock(cb)
	local cbft = cb.classes[1]
	local codeblockbox = {
		raw_tex '\\begin{quote}',
--		raw_tex '\\begin{tcolorbox}',
		raw_tex '\\begin{latin}',
			cb,
		raw_tex '\\end{latin}',
--		raw_tex '\\end{tcolorbox}',
		raw_tex '\\end{quote}',
	}
	local codeblock = {
		raw_tex '\\begin{quote}',
		raw_tex '\\begin{latin}',
			cb,
		raw_tex '\\end{latin}',
		raw_tex '\\end{quote}',
	}

	if cbft then
		return codeblockbox
	else
		return codeblock
	end
end
