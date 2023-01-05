-- helper {{{
local api = vim.api
local expand = vim.fn.expand
local ft = vim.bo.filetype
-- map() {{{
local function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
-- keymap function {{{
function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
--}}}
 
-- }}}
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

Split_style = 'h'

-- Toggle Split_style {{{
function Split_style_Toggle()
	if Split_style == 'h' then
		Split_style = 'v'
	else
		Split_style = 'h'
	end
end
map('n', '<leader>vs', ":lua Split_style_Toggle()<CR>", { silent = true })
--}}}
-- Term-Wrapper function {{{
function runTerminal(wrapand)
	if not Split_style then
		Split_style = 'h'
	end

	if Split_style == 'v' then
		Buffercmd = 'vs '
	elseif Split_style == 'h' then
		Buffercmd = 'split '
	else
		print("ERROR! Split_style have not a valid value (must be 'h' or 'v')")
		return -1
	end

--	print(wrapandrun)
	api.nvim_command(Buffercmd)
	api.nvim_command('set nornu nonu')
	if wrapand then
--		api.nvim_command('set ls=0')
		api.nvim_command("term " .. wrapand)
	else
		api.nvim_command('term')
	end
	api.nvim_command('startinsert')
end

-- }}}

au('set ls=2', '*', 'TermLeave')

-- swtich pandoc configs {{{
pandoc_list = { 'dracula', 'solarized', 'english', 'monochrome' }
pandoc_defaults = pandoc_list[2]

function pandoc_switch(list)
	pandoc_defaults = list
end

map("n", "<leader>vd1", ":lua pandoc_switch('dracula')<CR>")
map("n", "<leader>vd2", ":lua pandoc_switch('solarized')<CR>")
map("n", "<leader>vd3", ":lua pandoc_switch('english')<CR>")
map("n", "<leader>vd4", ":lua pandoc_switch('monochrome')<CR>")

-- }}}

-- Trigger functions
-- Run {{{
function TriggerRun(file_type)
	local src_name = expand('%')
	local out_name = expand('%:r')
--	local pandoc_path = '/home/hos/.config/pandoc/plain/'
	local pandoc_path = ' -t ms ' -- '--defaults /home/hos/.config/pandoc/beamer/beamer.yaml '

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
--		markdown = 'pandoc --defaults ' .. pandoc_path .. 'persian.yaml ' .. src_name .. ' -o ' .. out_name .. '.pdf'
		markdown = 'pandoc  ' .. pandoc_path .. src_name .. ' -o ' .. out_name .. '.pdf',
--		markdown = 'glow -p ' .. src_name,
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
	local r_cmd_e = [[', output_format = \"all\", params = \"~/.config/pandoc/english/english.yaml\" )"]]

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
--		markdown = pdf_viewer .. out_name .. log_handler,
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
map('n', '<leader>fe', RunnerCMD, { silent = true })
map('n', '<leader>fw', CompilerCMD, { silent = true })
map('n', '<leader>fq', ExtraCMD, { silent = true })

---- makefile
map('n', '<leader>cc', ':lua runTerminal("make")<CR>', { silent = true })

---- Run terminal
map('n', '<leader>tt', ':lua runTerminal("bash")<CR>', { silent = true })

---- Git commands
map('n', '<leader>gs', ":lua runTerminal('git status -s')<CR>", { silent = true })
map('n', '<leader>gl', ":lua runTerminal('git log --oneline --all --graph')<CR>", { silent = true })
map('n', '<leader>ga', ":lua runTerminal('git add .')<CR>", { silent = true })
map('n', '<leader>gd', ":lua runTerminal('git diff .')<CR>", { silent = true })
map('n', '<leader>gt', ":lua runTerminal('git tag')<CR>", { silent = true })
map('n', '<leader>gb', ":lua runTerminal('git branch')<CR>", { silent = true })
-- }}}
