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
--		vim.notify('umap(mode, key) must have at least two arguments', 4,
--			{title = 'Error on using umap()'})
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
	'horizontal', 'vertical', 'floating',
}

function WindowStyle_Toggle(i)
	WindowStyle = WindowStyles[i]
	vim.notify(string.format('term split => style: %s', WindowStyle),
		2, {title = 'WindowStyle_Toggle()'})
end

	for witem_counter = 1, #WindowStyles, 1 do
--		vim.notify(string.format('%s', bitem_counter) , 2)
		if #WindowStyles > 9 then
			vim.notify(string.format('You cannot have more than 9 themes\n%s',
					'WindowStyle_Toggle() mapping failed'), 4,
				{title = 'WindowStyle_Toggle()'})
			break
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
	-- border style {{{
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
		border = borderstyle['single'],
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
function VHterminal(wrapand, windowstyle)
	if windowstyle == nil then
		windowstyle = 'horizontal'
		vim.notify(string.format('windowstyle is not set, swtiched to default (%s)',
				windowstyle), 3,
			{title = 'VHterminal'})
	end

	if windowstyle == 'vertical' then
		Buffercmd = 'vs '
	elseif windowstyle == 'horizontal' then
		Buffercmd = 'split '
	else
		vim.notify(string.format('** windowstyle is not set %s',
				'to use `VHterminal()`\n** try `Fterminal()`'), 4,
			{title = 'VHterminal'})
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

function RUNterminal(inputcmd, ws)
	local windowstyle
	local ws_list = {
		h = 'horizontal',
		v = 'vertical',
		f = 'floating'
	}

--	api.nvim_command('set ls=0')
	if ws == nil then
		windowstyle = WindowStyle
	else
		windowstyle = ws_list[ws]
	end

	if windowstyle == 'floating' then
		Fterminal(inputcmd)
	else
		VHterminal(inputcmd, windowstyle)
	end

	-- print the executed command
----	print('!' .. inputcmd)
--	vim.notify(inputcmd, 2, {title = 'Command executed'})
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
		vim.notify(string.format('Pandoc article style => %s',
				Pandoc_article_default), 2,
			{title = 'Pandoc article style'})
	end

--	print(#Pandoc_article_list)
	for aitem_counter = 1, #Pandoc_article_list, 1 do
--		print(aitem_counter)
		if #Pandoc_article_list > 9 then
			vim.notify(string.format('Pandoc_article_switch() mapping failed\n%s',
					'You cannot have more than 9 themes'), 4,
				{title = 'Pandoc_article_switch()'})
			break
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
		vim.notify(string.format('Pandoc beamer style switched => %s',
				Pandoc_beamer_default), 2,
			{title = 'Pandoc beamer style'})
	end

--	print(#Pandoc_beamer_list)
	for bitem_counter = 1, #Pandoc_beamer_list, 1 do
--		print(bitem_counter)
		if #Pandoc_beamer_list > 9 then
			vim.notify(string.format('Pandoc_beamer_switch() mapping failed\n%s',
					'You cannot have more than 9 themes'), 4,
				{title = 'Pandoc_beamer_switch()'})
			break
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
	local pandoc_path = string.format(' %s %s ',
		'-t ms', '--defaults ~/.config/pandoc/defaults/groff/groff.yaml')
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
		markdown = string.format('pandoc %s %s -o %s.pdf',
			pandoc_path, src_name, out_name),
		rmd = string.format("%s = '%s', %s",
			'Rscript -e "rmarkdown::render(input', src_name,
			'output_format = \\"md_document\\")"')
	}

	if runner[file_type] == nil then
		vim.notify('Not exec', 2, {title = 'TriggerRun()'})
		return 1
	end

	RUNterminal(runner[file_type])
end
-- }}}
-- Compile {{{
function TriggerCompile(file_type)
	local src_name = expand('%')
	local out_name = expand('%:r')
	local pandoc_path = string.format(' %s%s/%s%s ',
		'~/.config/pandoc/defaults/', Pandoc_article_default,
		Pandoc_article_default, '.yaml')
	local rmd_path 

	local compiler = {
		c = string.format('gcc -Wall %s -o %s', src_name, out_name),
		cpp = string.format('g++ -Wall %s -o %s', src_name, out_name),
		rust = 'rustc ' .. src_name,
		go = 'go build ' .. src_name,
		sh = 'sh ' .. src_name,
--		nroff = string.format('pdfroff -U -mspdf %s > %s.pdf',
--			src_name, out_name),
		nroff = string.format('tbl %s | groff %s > %s.pdf',
			src_name, '-mspdf -keUGs -Tpdf', out_name),
		tex = 'xelatex ' .. src_name,
		sent = 'sent -i ' .. src_name,
		text = 'sent -i ' .. src_name,
		markdown = string.format('pandoc --defaults %s %s -o %s.pdf',
			pandoc_path, src_name, out_name),
		rmd = string.format([[%s(input='%s', %s, params='%s')"]],
			[[Rscript -e "rmarkdown::render]], src_name,
			[[output_format = 'all']], pandoc_path)
	}

	if compiler[file_type] == nil then
		vim.notify('Not src', 2, {title = 'TriggerCompile()'})
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
	local extra = {
		rmd = pdf_viewer .. out_name .. log_handler,
		nroff = pdf_viewer .. out_name ..log_handler,
		sent = "sent -f 'Source Sans Pro' " .. src_name,
		text = "sent -f 'Source Sans Pro' " .. src_name,
		tex = 'xelatex -interaction=nonstopmode -synctex=1 ' .. src_name,
		markdown = string.format('pandoc %s%s%s %s -o %s.pdf ',
			'--defaults ~/.config/pandoc/defaults/beamer/',
				Pandoc_beamer_default, '.yaml', src_name, out_name)

	}

	if extra[file_type] == nil then
		vim.notify('No extra works yet :/', 2, {title = 'TriggerExtra()'})
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
map('n', '<leader>tt', ':lua RUNterminal("bash")<CR>',
		{ silent = true, desc = 'term › bash shell' })
map('n', '<leader>tz', ':lua RUNterminal("zsh")<CR>',
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
