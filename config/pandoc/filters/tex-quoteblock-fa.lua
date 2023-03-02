-- just for less typing
function raw_tex(t)
	return pandoc.RawBlock('tex', t)
end

-- quote block
function BlockQuote(bq)
	local blockquote = {
		raw_tex '\\qfont',
			bq,
		raw_tex '\\secfont',
	}
	return blockquote
end
