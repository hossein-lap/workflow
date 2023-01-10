-- helper {{{
local api = vim.api
local expand = vim.fn.expand
local ft = vim.bo.filetype
local g = vim.g

-- term color {{{
g.terminal_color_0		=	"#3b4252"
g.terminal_color_1		=	"#bf616a"
g.terminal_color_2		=	"#a3be8c"
g.terminal_color_3		=	"#ebcb8b"
g.terminal_color_4		=	"#81a1c1"
g.terminal_color_5		=	"#b48ead"
g.terminal_color_6		=	"#88c0d0"
g.terminal_color_7		=	"#e5e9f0"
g.terminal_color_8		=	"#373e4d"
g.terminal_color_9		=	"#94545d"
g.terminal_color_10		=	"#809575"
g.terminal_color_11		=	"#b29e75"
g.terminal_color_12		=	"#68809a"
g.terminal_color_13		=	"#8c738c"
g.terminal_color_14		=	"#6d96a5"
g.terminal_color_15		=	"#aeb3bb"
-- }}}

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
	{ silent = true, desc = "Horizontal Window" })

map('n', '<leader>vs2', ":lua Wind_style_Toggle(2)<CR>",
	{ silent = true, desc = "Vertical Window" })

map('n', '<leader>vs3', ":lua Wind_style_Toggle(3)<CR>",
	{ silent = true, desc = "Float Window" })
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
	local win_height = math.ceil(height * 0.8 - 4)
	local win_width = math.ceil(width * 0.8)

	-- and its starting position
	local row = math.ceil((height - win_height) / 2 - 1)
	local col = math.ceil((width - win_width) / 2)

	-- set some options
	local opts = {
		style = "minimal",
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
		print("ERROR! Wind_style have not a valid value (must be 'h' or 'v')")
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
	api.nvim_command('set ls=0')
	if Wind_style == 'f' then
		fTerminal(inp)
	else
		vhTerminal(inp)
	end
end

au('set ls=2', '*', 'TermLeave')

-- swtich pandoc configs {{{
pandoc_list = { 'dracula', 'solarized', 'english', 'monochrome' }
pandoc_defaults = pandoc_list[1]

function pandoc_switch(list)
	pandoc_defaults = list
end

map("n", "<leader>vd1", ":lua pandoc_switch('dracula')<CR>",
		{ desc = "Pandoc's `dracula` config" })

map("n", "<leader>vd2", ":lua pandoc_switch('solarized')<CR>",
		{ desc = "Pandoc's `solarized` config" })

map("n", "<leader>vd3", ":lua pandoc_switch('english')<CR>",
		{ desc = "Pandoc's `english` config" })

map("n", "<leader>vd4", ":lua pandoc_switch('monochrome')<CR>",
		{ desc = "Pandoc's `monochrome` config" })
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
	local pandoc_path = ' ~/.config/pandoc/' .. pandoc_defaults .. '/' .. pandoc_defaults .. '.yaml '
	local r_cmd_s = [[Rscript -e "rmarkdown::render(input = ']]
	local r_cmd_e = [[', output_format = \"all\", params = \" ]] .. pandoc_path .. [[ \" )"]]

	local compiler = {
		c = 'gcc -Wall ' .. src_name .. ' -o ' .. out_name,
		cpp = 'g++ -Wall ' .. src_name .. ' -o ' .. out_name,
		rust = 'rustc ' .. src_name,
		go = 'go build ' .. src_name,
		nroff = 'tbl '.. src_name .. ' | groff -mspdf -keGs -Tpdf > ' .. out_name .. '.pdf ',
		tex = 'xelatex -shell-escape ' .. src_name,
		sent = 'sent -f LibertinusSerif ' .. src_name,
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
	local pandoc_path = '--defaults ~/.config/pandoc/persian/persian.yaml '

	local extra = {
		rmd = pdf_viewer .. out_name .. log_handler,
		nroff = pdf_viewer .. out_name ..log_handler,
		sent = 'sent -f SourceSansPro ' .. src_name,
		markdown = 'pandoc ' .. pandoc_path .. src_name .. ' -o ' .. out_name .. '.pdf'
	}

	if extra[file_type] == nil then
		print('No extra works yet :/')
		return 1
	end

	runTerminal(extra[file_type])
end
-- }}}

RunnerCMD = ':lua TriggerRun(vim.bo.filetype)<CR>'
CompilerCMD = ':lua TriggerCompile(vim.bo.filetype)<CR>'
ExtraCMD = ':lua TriggerExtra(vim.bo.filetype)<CR>'

-- Keymaps {{{
---- Compile/Run/Extra
map('n', '<leader>fe', RunnerCMD, { silent = true, desc = 'cmd1: Run file' })
map('n', '<leader>fw', CompilerCMD, { silent = true, desc = 'cmd2: Compile file' })
map('n', '<leader>fq', ExtraCMD, { silent = true, desc = 'cmd3: Extra thing' })

---- makefile
map('n', '<leader>cc', ':lua runTerminal("make")<CR>',
		{ silent = true, desc = 'Run `make` command' })

---- Run terminal
map('n', '<leader>tt', ':lua runTerminal("bash")<CR>',
		{ silent = true, desc = 'Run intractive `bash` shell' })

---- Git commands
map('n', '<leader>gs', ":lua runTerminal('git status -s')<CR>",
		{ silent = true, desc = "Show current branch's status" })
map('n', '<leader>gl', ":lua runTerminal('git log --oneline --all --graph')<CR>",
		{ silent = true, desc = "Show git log" })
map('n', '<leader>ga', ":lua runTerminal('git add %')<CR>",
		{ silent = true, desc = "Add current file to stage area" })
map('n', '<leader>gd', ":lua runTerminal('git diff %')<CR>",
		{ silent = true, desc = "Changes of current file" })
map('n', '<leader>gt', ":lua runTerminal('git tag')<CR>",
		{ silent = true, desc = "Tags" })
map('n', '<leader>gb', ":lua runTerminal('git branch')<CR>",
		{ silent = true, desc = "Branchs" })
map('n', '<leader>gc', ":lua runTerminal('git commit')<CR>",
		{ silent = true, desc = "Commit the changes" })
map('n', '<leader>gh', ":lua runTerminal('git show HEAD~1:./%')<CR>",
		{ silent = true, desc = "Previous version of the current file" })
-- }}}
