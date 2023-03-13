-- helper {{{
local api = vim.api
local expand = vim.fn.expand
--local ft = vim.bo.filetype
--local g = vim.g
--local vim.notify = require("")

-- map() {{{
local function map(mode, key, command, opts)
	if not mode or not key then
		vim.notify('map(mode, key) must have at least two arguments', 4,
			{title = 'Error on using map()'})
		return 1
	end
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
-- }}}
---- umap {{{
--local function umap(mode, key)
--	if not mode or not key then
--		print('Error on using umap()')
--		print('umap(mode, key) must have both arguments')
--		return 1
--	end
--	api.nvim_del_keymap(mode, key)
--end
---- }}}
---- autocmd {{{
--local function au(commands, patterns, evnt)
--	if evnt == nil then
--		evnt = 'FileType'
--	end
--	api.nvim_create_autocmd(evnt, {
--		pattern = patterns,
--		command = commands,
----		 group = patterns .. 'groups'
--	})
--end
---- }}}
-- }}}

WindowStyle = 'horizontal'

-- Toggle WindowStyle {{{
local WindowStyles = {
	'horizontal', 'vertical', 'floating'
}

function WindowStyle_Toggle(i)
	WindowStyle = WindowStyles[i]
	print("term split => style: " .. WindowStyle)
end

	for witem_counter = 1, #WindowStyles, 1 do
--		print(bitem_counter)
		if #WindowStyles > 9 then
			print("You cannot have more than 9 themes")
			print("WindowStyle_Toggle() mapping failed")
			return 9
		end
		map("n", "<leader>vs"..witem_counter, ":lua WindowStyle_Toggle("..witem_counter..")<CR>",
			{ silent = true, desc = "term split: " .. WindowStyles[witem_counter] }
		)
	end

--map('n', '<leader>vs1', ":lua WindowStyle_Toggle(1)<CR>",
--	{ silent = true, desc = "term › horizontal split" })
--
--map('n', '<leader>vs2', ":lua WindowStyle_Toggle(2)<CR>",
--	{ silent = true, desc = "term › vertical split" })
--
--map('n', '<leader>vs3', ":lua WindowStyle_Toggle(3)<CR>",
--	{ silent = true, desc = "term › float Window" })
-- }}}
-- Float Term {{{
function Fterminal(wrapand)
	local buf --, win

	buf = api.nvim_create_buf(false, true) -- create new emtpy buffer
	api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

	-- get dimensions {{{
	local width = api.nvim_get_option("columns")
	local height = api.nvim_get_option("lines")
	-- }}}

	-- calculate our floating window size {{{
	local scale = 0.7
	local win_height = math.ceil(height * scale - 4)
	local win_width = math.ceil(width * scale)
	-- }}}

	-- and its starting position {{{
	local row = math.ceil((height - win_height) / 2 - 2)
	local col = math.ceil((width - win_width) / 2)
	-- }}}

	-- set some options {{{
	local borderstyle = {
		ascii = {
			{ "/", 'FloatBorder' },
			{ "-", 'FloatBorder' },
			{ "\\", 'FloatBorder' },
			{ "|", 'FloatBorder' },
		},
		single = {
			{ "┌", 'FloatBorder' },
			{ "─", 'FloatBorder' },
			{ "┐", 'FloatBorder' },
			{ "│", 'FloatBorder' },
			{ "┘", 'FloatBorder' },
			{ "─", 'FloatBorder' },
			{ "└", 'FloatBorder' },
			{ "│", 'FloatBorder' },
		},
		double = {
			{ "╔", 'FloatBorder' },
			{ "═", 'FloatBorder' },
			{ "╗", 'FloatBorder' },
			{ "║", 'FloatBorder' },
			{ "╝", 'FloatBorder' },
			{ "═", 'FloatBorder' },
			{ "╚", 'FloatBorder' },
			{ "║", 'FloatBorder' },
		},
		round = {
			{ "╭", 'FloatBorder' },
			{ "─", 'FloatBorder' },
			{ "╮", 'FloatBorder' },
			{ "│", 'FloatBorder' },
			{ "╯", 'FloatBorder' },
			{ "─", 'FloatBorder' },
			{ "╰", 'FloatBorder' },
			{ "│", 'FloatBorder' },
		},
	}
	-- }}}

	local opts = {
		noautocmd = true,
		style = "minimal",
		border = borderstyle['round'],
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col
	}

	-- and finally create it with buffer attached
	api.nvim_open_win(buf, true, opts)

	if wrapand then
		api.nvim_command("term " .. wrapand)
	else
		api.nvim_command('term')
	end
	api.nvim_command('startinsert')
end

-- }}}
-- V/H Term {{{
function VHterminal(wrapand)
	if not WindowStyle then
		WindowStyle = 'horizontal'
		Notify('VHterminal',
			string.format("WindowStyle is not set, swtiched to default (%s)",
				WindowStyle),
			3
		)
	end

	if WindowStyle == 'vertical' then
		Buffercmd = 'vs '
	elseif WindowStyle == 'horizontal' then
		Buffercmd = 'split '
	else
		Notify('VHterminal',
			string.format("** WindowStyle is not set %s",
				"to use `VHterminal()`\n** try `Fterminal()`"),
			4
		)
--		print("ERROR!")
--		print("** WindowStyle is not set to use `VHterminal()`")
--		print("** try `Fterminal()`")
		return -1
	end

--	print(wrapandrun)
	api.nvim_command(Buffercmd)
	api.nvim_command('set nornu nonu')
	if wrapand then
		api.nvim_command("term " .. wrapand)
	else
		api.nvim_command('term')
	end
	api.nvim_command('startinsert')
end
-- }}}

function RUNterminal(inp)
--	api.nvim_command('set ls=0')
	if WindowStyle == 'floating' then
		Fterminal(inp)
	else
		VHterminal(inp)
	end
--	-- print the executed command
--	print('!' .. inp)
end

--au('set ls=0', '*', 'TermEnter')
--au('set ls=3', '*', 'TermLeave')

-- swtich pandoc configs {{{
	-- article {{{
	Pandoc_article_list = {
		'nord', 'dracula', 'solarized',
		'english', 'monochrome',
		'persian'
	}

	Pandoc_article_default = Pandoc_article_list[1]
	function Pandoc_article_switch(item)
		Pandoc_article_default = Pandoc_article_list[item]
--		print("pandoc article => style: " .. Pandoc_article_default)
--		vim.notify("pandoc article => style: " .. Pandoc_article_default)
--		vim.notify(Pandoc_article_default, 2, {title = "pandoc article style"})
		Notify("Pandoc article style", Pandoc_article_default, 2)
	end

--	print(#Pandoc_article_list)
	for aitem_counter = 1, #Pandoc_article_list, 1 do
--		print(aitem_counter)
		if #Pandoc_article_list > 9 then
			Notify('Pandoc_article_switch() mapping failed',
				'You cannot have more than 9 themes', 4)
			return 9
		end
		map("n", "<leader>va"..aitem_counter, ":lua Pandoc_article_switch("..aitem_counter..")<CR>",
			{ silent = true, desc = "Pandoc: article › " .. Pandoc_article_list[aitem_counter] }
		)
	end
	-- }}}
	-- beamer {{{
	Pandoc_beamer_list = {
		'en-manjaro', 'en-dracula', 'en-ubuntu',
		'fa-manjaro', 'fa-dracula', 'fa-ubuntu'
	}

	Pandoc_beamer_default = Pandoc_beamer_list[1]
	function Pandoc_beamer_switch(item)
		Pandoc_beamer_default = Pandoc_beamer_list[item]
		Notify("Pandoc beamer style", Pandoc_beamer_default, 2)
	end

--	print(#Pandoc_beamer_list)
	for bitem_counter = 1, #Pandoc_beamer_list, 1 do
--		print(bitem_counter)
		if #Pandoc_beamer_list > 9 then
			Notify('Pandoc_beamer_switch() mapping failed',
				'You cannot have more than 9 themes', 4)
			return 9
		end
		map("n", "<leader>vb"..bitem_counter, ":lua Pandoc_beamer_switch("..bitem_counter..")<CR>",
			{ silent = true, desc = "Pandoc: beamer › " .. Pandoc_beamer_list[bitem_counter] }
		)
	end
	-- }}}
-- }}}

-- Trigger functions:
-- Run {{{
function TriggerRun(file_type)
	local src_name = expand('%')
	local out_name = expand('%:r')
	local pandoc_path = ' -t ms --defaults ~/.config/pandoc/defaults/groff/groff.yaml '
--	local pandoc_path = ' -t ms --highlight monochrome '

	local runner = {
		c = './' .. out_name,
		cpp = './' .. out_name,
		rust = './' .. out_name,
		go = 'go run ' .. src_name,
		python = 'python ' .. src_name,
		lua = 'lua5.4 ' .. src_name,
		sh = 'bash ' .. src_name,
		csh = 'csh ' .. src_name,
		zsh = 'zsh ' .. src_name,
		sent = 'sent ' .. src_name,
		text = 'sent ' .. src_name,
		markdown = 'pandoc  ' .. pandoc_path .. src_name .. ' -o ' .. out_name .. '.pdf',
		rmd = [[Rscript -e "rmarkdown::render(input = ']] .. src_name .. [[', output_format = \"md_document\")"]],
	}

	if runner[file_type] == nil then
		print('Not exec')
		return 1
	end

	RUNterminal(runner[file_type])
end
-- }}}
-- Compile {{{
function TriggerCompile(file_type)
	local src_name = expand('%')
	local out_name = expand('%:r')
	local pandoc_path = ' ~/.config/pandoc/defaults/' .. Pandoc_article_default .. '/' .. Pandoc_article_default .. '.yaml '
	local r_cmd_s = [[Rscript -e "rmarkdown::render(input = ']]
	local r_cmd_e = [[', output_format = \"all\", params = \" ]] .. pandoc_path .. [[ \" )"]]

	local compiler = {
		c = 'gcc -Wall ' .. src_name .. ' -o ' .. out_name,
		cpp = 'g++ -Wall ' .. src_name .. ' -o ' .. out_name,
		rust = 'rustc ' .. src_name,
		go = 'go build ' .. src_name,
		sh = 'sh ' .. src_name,
		nroff = 'tbl '.. src_name .. ' | groff -mspdf -keUGs -Tpdf > ' .. out_name .. '.pdf ',
		tex = 'xelatex -shell-escape ' .. src_name,
		sent = 'sent -i ' .. src_name,
		text = 'sent -i ' .. src_name,
		markdown = 'pandoc --defaults ' .. pandoc_path .. src_name .. ' -o ' .. out_name .. '.pdf',
		rmd = r_cmd_s .. src_name .. r_cmd_e,
	}

	if compiler[file_type] == nil then
		print('Not src')
		return 1
	end

	RUNterminal(compiler[file_type])
end
-- }}}
-- Extra {{{
function TriggerExtra(file_type)
	local src_name = expand('%')
	local out_name = expand('%:r')
	local pdf_viewer = 'nohup zathura '
	local log_handler =  '.pdf & 2>&1 > /dev/null'
	local pandoc_path = ' -t beamer -V classoption:aspectratio=169 --defaults ~/.config/pandoc/defaults/beamer/' .. Pandoc_beamer_default  .. '.yaml '

	local extra = {
		rmd = pdf_viewer .. out_name .. log_handler,
		nroff = pdf_viewer .. out_name ..log_handler,
		sent = "sent -f 'Source Sans Pro' " .. src_name,
		text = "sent -f 'Source Sans Pro' " .. src_name,
		markdown = 'pandoc ' .. pandoc_path .. src_name .. ' -o ' .. out_name .. '.pdf'
	}

	if extra[file_type] == nil then
		print('No extra works yet :/')
		return 1
	end

	RUNterminal(extra[file_type])
end
-- }}}

-- Keymaps {{{
---- Compile/Run/Extra
map('n', '<leader>fe',  ':lua TriggerRun(vim.bo.filetype)<CR>',
	{ silent = true, desc = 'command1 › Run file' })
map('n', '<leader>fw',  ':lua TriggerCompile(vim.bo.filetype)<CR>',
	{ silent = true, desc = 'command2 › Compile file' })
map('n', '<leader>fq',  ':lua TriggerExtra(vim.bo.filetype)<CR>',
	{ silent = true, desc = 'command3 › Extra thing' })

---- makefile
map('n', '<leader>cc', ':lua RUNterminal("make")<CR>',
		{ silent = true, desc = 'make › all' })
map('n', '<leader>cd', ':lua RUNterminal("make clean")<CR>',
		{ silent = true, desc = 'make › clean' })
map('n', '<leader>cf', ':lua RUNterminal("make force")<CR>',
		{ silent = true, desc = 'make › force' })
map('n', '<leader>ca', ':lua RUNterminal("make full")<CR>',
		{ silent = true, desc = 'make › full' })

---- Run terminal
map('n', '<leader>ts', ':lua RUNterminal("bash")<CR>',
		{ silent = true, desc = 'term › bash shell' })
map('n', '<leader>tt', ':lua RUNterminal("zsh")<CR>',
		{ silent = true, desc = 'term › zsh shell' })
map('n', '<leader>td', ':lua RUNterminal("dash")<CR>',
		{ silent = true, desc = 'term › dash shell' })

---- Git commands
map('n', '<leader>gi', ":lua RUNterminal('git init')<CR>",
		{ silent = true, desc = "git › initial local repo" })
map('n', '<leader>gs', ":lua RUNterminal('git status -s')<CR>",
		{ silent = true, desc = "git › current branch's status" })
map('n', '<leader>gl', ":lua RUNterminal('git log --oneline --all --graph')<CR>",
		{ silent = true, desc = "git › log" })
map('n', '<leader>ga', ":lua RUNterminal('git add %')<CR>",
		{ silent = true, desc = "git › add current file to stage area" })
map('n', '<leader>gd', ":lua RUNterminal('git diff %')<CR>",
		{ silent = true, desc = "git › diff changes of current file" })
map('n', '<leader>gt', ":lua RUNterminal('git tag')<CR>",
		{ silent = true, desc = "git › Tags" })
map('n', '<leader>gb', ":lua RUNterminal('git branch')<CR>",
		{ silent = true, desc = "git › Branchs" })
map('n', '<leader>gc', ":lua RUNterminal('git commit')<CR>",
		{ silent = true, desc = "git › Commit the changes" })
map('n', '<leader>gh', ":lua RUNterminal('git show HEAD~1:./%')<CR>",
		{ silent = true, desc = "git › Previous version of the current file" })
-- }}}
