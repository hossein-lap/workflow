-- just for less typing
function raw_tex(t)
	return pandoc.RawBlock('tex', t)
end

-- hos {{{
function DefinitionList(dl)
	local char_length = 100
	print(dl.content, '\n')
--	print(string.rep('=', char_length))

	local title_list = {}
	local loop_length

	for i, item in ipairs(dl.content) do
		local term = pandoc.utils.stringify(item[1])
		local body = pandoc.utils.stringify(item[2])

		io.write(i, '. ', term, '\n', ': ', body, '\n', '\n')

		local dtitle_list = {
				raw_tex(term)
		}
		local dbody_list = {
				raw_tex(body)
		}

		if #dtitle_list > #dbody_list then
			loop_length = #dtitle_list
		else
			loop_length = #dbody_list
		end

		for x = 1, loop_length, 1 do
--			table.insert(title_list,
--				raw_tex(string.format("\\rmfamily\n\\textbf{%s}\n\\begin{quote}\\sffamily\n",
--				dtitle_list[x].text)
--			)
--			table.insert(title_list, raw_tex '\\begin{quote}')
--			table.insert(title_list, raw_tex '\\noindent\\fbox{')
--			table.insert(title_list, raw_tex '\\begin{minipage}{\\textwidth}')
			table.insert(title_list,
--				raw_tex(string.format("\\begin{tcolorbox}[title=\\textbf{%s}],
				raw_tex(string.format("\\noindent\\fbox{\\textbf{%s}:}",
					dtitle_list[x].text)
				)
			)
--			table.insert(title_list, raw_tex "{\\sffamily")
			table.insert(title_list, raw_tex '\\begin{quote}')
			table.insert(title_list, dbody_list[x].text)
			table.insert(title_list, raw_tex '\\end{quote}')
--			table.insert(title_list, raw_tex '}')
--			table.insert(title_list, raw_tex '\\end{tcolorbox}\n')
--			table.insert(title_list, raw_tex '\\end{minipage}')
--			table.insert(title_list, raw_tex '}')
--			table.insert(title_list, raw_tex '\\end{quote}')
		end
	end

	print(string.rep('=', char_length), '\n')
	return title_list
end
-- }}}
