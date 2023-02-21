-- helper {{{
local api = vim.api
local expand = vim.fn.expand
local ft = vim.bo.filetype
local g = vim.g

-- map() {{{
local function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
-- }}}
---- keymap function {{{
--function map(mode, key, command, opts)
--	local options = { noremap = true }
--	if opts then
--		options = vim.tbl_extend("force", options, opts)
--	end
--	api.nvim_set_keymap(mode, key, command, options)
--end
---- }}}
---- unmap {{{
--local function umap(mode, key)
--	if not mode or not key then
--		print('Error on using umap()')
--		print('umap(mode, key) must have both arguments')
--		return 1
--	end
--	api.nvim_del_keymap(mode, key)
--end
---- }}}
-- autocmd {{{
local function au(commands, patterns, evnt)
	if evnt == nil then
		evnt = 'FileType'
	end
	api.nvim_create_autocmd(evnt, {
		pattern = patterns,
		command = commands,
--		 group = patterns .. 'groups'
	})
end
-- }}}
-- }}}

Wind_style = 'h'

-- Toggle Wind_style {{{
function Wind_style_Toggle(i)
	if i == 1 then
		Wind_style = 'h'
	elseif i == 2 then
		Wind_style = 'v'
	elseif i == 3 then
		Wind_style = 'f'
	end
end

map('n', '<leader>vs1', ":lua Wind_style_Toggle(1)<CR>",
	{ silent = true, desc = "term › horizontal split" })

map('n', '<leader>vs2', ":lua Wind_style_Toggle(2)<CR>",
	{ silent = true, desc = "term › vertical split" })

map('n', '<leader>vs3', ":lua Wind_style_Toggle(3)<CR>",
	{ silent = true, desc = "term › float Window" })
-- }}}
-- Float Term {{{
function fTerminal(wrapand)
	local buf, win

	buf = api.nvim_create_buf(false, true) -- create new emtpy buffer

	api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

	-- get dimensions
	local width = api.nvim_get_option("columns")
	local height = api.nvim_get_option("lines")

	-- calculate our floating window size
	local scale = 0.7
	local win_height = math.ceil(height * scale - 4)
	local win_width = math.ceil(width * scale)

	-- and its starting position
	local row = math.ceil((height - win_height) / 2 - 2)
	local col = math.ceil((width - win_width) / 2)

	-- set some options
	local borderstyle = {
		ascii = {
			{ "/", 'Normal' },
			{ "-", 'Normal' },
			{ "\\", 'Normal' },
			{ "|", 'Normal' },
		},
		single = {
			{ "┌", 'Normal' },
			{ "─", 'Normal' },
			{ "┐", 'Normal' },
			{ "│", 'Normal' },
			{ "┘", 'Normal' },
			{ "─", 'Normal' },
			{ "└", 'Normal' },
			{ "│", 'Normal' },
		},
		double = {
			{ "╔", 'Normal' },
			{ "═", 'Normal' },
			{ "╗", 'Normal' },
			{ "║", 'Normal' },
			{ "╝", 'Normal' },
			{ "═", 'Normal' },
			{ "╚", 'Normal' },
			{ "║", 'Normal' },
		},
		round = {
			{ "╭", 'Normal' },
			{ "─", 'Normal' },
			{ "╮", 'Normal' },
			{ "│", 'Normal' },
			{ "╯", 'Normal' },
			{ "─", 'Normal' },
			{ "╰", 'Normal' },
			{ "│", 'Normal' },
		},
	}

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
function vhTerminal(wrapand)
	if not Wind_style then
		Wind_style = 'h'
	end

	if Wind_style == 'v' then
		Buffercmd = 'vs '
	elseif Wind_style == 'h' then
		Buffercmd = 'split '
	else
		print("ERROR!")
		print("** Wind_style is not set to use `vhTerminal()`")
		print("** try `fTerminal()`")
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

function runTerminal(inp)
--	api.nvim_command('set ls=0')
	if Wind_style == 'f' then
		fTerminal(inp)
	else
		vhTerminal(inp)
	end
end

--au('set ls=2', '*', 'TermLeave')

-- swtich pandoc configs {{{
	-- article
	pandoc_article_list = {
		'dracula', 'solarized', 'english',
		'monochrome', 'persian'
	}

	pandoc_article_default = pandoc_article_list[1]
	function pandoc_article_switch(item)
		pandoc_article_default = pandoc_article_list[item]
	end

	map("n", "<leader>va1", ":lua pandoc_article_switch(1)<CR>",
			{ desc = "Pandoc › article → —dracula—" })

	map("n", "<leader>va2", ":lua pandoc_article_switch(2)<CR>",
			{ desc = "Pandoc › article —solarized—" })

	map("n", "<leader>va3", ":lua pandoc_article_switch(3)<CR>",
			{ desc = "Pandoc › article —english—" })

	map("n", "<leader>va4", ":lua pandoc_article_switch(4)<CR>",
			{ desc = "Pandoc › article —monochrome—" })

	map("n", "<leader>va5", ":lua pandoc_article_switch(5)<CR>",
			{ desc = "Pandoc › article —persian— " })

	-- beamer
	pandoc_beamer_list = {
		'english', 'persian'
	}

	pandoc_beamer_default = pandoc_beamer_list[1]
	function pandoc_beamer_switch(item)
		pandoc_beamer_default = pandoc_beamer_list[item]
	end

	map("n", "<leader>vb1", ":lua pandoc_beamer_switch(1)<CR>",
			{ desc = "Pandoc › beamer —english— " })

	map("n", "<leader>vb2", ":lua pandoc_beamer_switch(2)<CR>",
			{ desc = "Pandoc › beamer —persian—" })
-- }}}

-- Trigger functions
-- Run {{{
function TriggerRun(file_type)
	local src_name = expand('%')
	local out_name = expand('%:r')
	local pandoc_path = ' -t ms --highlight ~/.config/pandoc/highlight/monochrome.theme '
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

	runTerminal(runner[file_type])
end
-- }}}
-- Compile{{{
function TriggerCompile(file_type)
	local src_name = expand('%')
	local out_name = expand('%:r')
	local pandoc_path = ' ~/.config/pandoc/' .. pandoc_article_default .. '/' .. pandoc_article_default .. '.yaml '
	local r_cmd_s = [[Rscript -e "rmarkdown::render(input = ']]
	local r_cmd_e = [[', output_format = \"all\", params = \" ]] .. pandoc_path .. [[ \" )"]]

	local compiler = {
		c = 'gcc -Wall ' .. src_name .. ' -o ' .. out_name,
		cpp = 'g++ -Wall ' .. src_name .. ' -o ' .. out_name,
		rust = 'rustc ' .. src_name,
		go = 'go build ' .. src_name,
		sh = 'sh ' .. src_name,
		nroff = 'tbl '.. src_name .. ' | groff -mspdf -keGs -Tpdf > ' .. out_name .. '.pdf ',
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

	runTerminal(compiler[file_type])
end
-- }}}
-- Extra {{{
function TriggerExtra(file_type)
	local src_name = expand('%')
	local out_name = expand('%:r')
	local pdf_viewer = 'nohup zathura '
	local log_handler =  '.pdf & 2>&1 > /dev/null'
	local pandoc_path = ' -t beamer -V classoption:aspectratio=169 --defaults ~/.config/pandoc/beamer/' .. pandoc_beamer_default  .. '.yaml '

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

	runTerminal(extra[file_type])
end
-- }}}

-- Keymaps {{{
---- Compile/Run/Extra
map('n', '<leader>fe',  ':lua TriggerRun(vim.bo.filetype)<CR>',
	{ silent = true, desc = 'command › Run file' })
map('n', '<leader>fw',  ':lua TriggerCompile(vim.bo.filetype)<CR>',
	{ silent = true, desc = 'command › Compile file' })
map('n', '<leader>fq',  ':lua TriggerExtra(vim.bo.filetype)<CR>',
	{ silent = true, desc = 'command › Extra thing' })

---- makefile
map('n', '<leader>cc', ':lua runTerminal("make")<CR>',
		{ silent = true, desc = 'make › all' })
map('n', '<leader>cd', ':lua runTerminal("make clean")<CR>',
		{ silent = true, desc = 'make › clean' })
map('n', '<leader>cf', ':lua runTerminal("make force")<CR>',
		{ silent = true, desc = 'make › force' })
map('n', '<leader>ca', ':lua runTerminal("make full")<CR>',
		{ silent = true, desc = 'make › full' })

---- Run terminal
map('n', '<leader>ts', ':lua runTerminal("bash")<CR>',
		{ silent = true, desc = 'term › bash shell' })
map('n', '<leader>tt', ':lua runTerminal("zsh")<CR>',
		{ silent = true, desc = 'term › zsh shell' })
map('n', '<leader>td', ':lua runTerminal("dash")<CR>',
		{ silent = true, desc = 'term › dash shell' })

---- Git commands
map('n', '<leader>gi', ":lua runTerminal('git init')<CR>",
		{ silent = true, desc = "git › initial local repo" })
map('n', '<leader>gs', ":lua runTerminal('git status -s')<CR>",
		{ silent = true, desc = "git › current branch's status" })
map('n', '<leader>gl', ":lua runTerminal('git log --oneline --all --graph')<CR>",
		{ silent = true, desc = "git › log" })
map('n', '<leader>ga', ":lua runTerminal('git add %')<CR>",
		{ silent = true, desc = "git › add current file to stage area" })
map('n', '<leader>gd', ":lua runTerminal('git diff %')<CR>",
		{ silent = true, desc = "git › diff changes of current file" })
map('n', '<leader>gt', ":lua runTerminal('git tag')<CR>",
		{ silent = true, desc = "git › Tags" })
map('n', '<leader>gb', ":lua runTerminal('git branch')<CR>",
		{ silent = true, desc = "git › Branchs" })
map('n', '<leader>gc', ":lua runTerminal('git commit')<CR>",
		{ silent = true, desc = "git › Commit the changes" })
map('n', '<leader>gh', ":lua runTerminal('git show HEAD~1:./%')<CR>",
		{ silent = true, desc = "git › Previous version of the current file" })
-- }}}
