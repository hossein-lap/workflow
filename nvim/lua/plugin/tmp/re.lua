local expand = vim.fn.expand
local api = vim.api
-- keymap function {{{
local function map(mode, key, command, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
--}}}

-- Floating term{{{
local Terminal  = require('toggleterm.terminal').Terminal
function runTerminal(wrapand)
	local execu = Terminal:new({
		size = function(execu)
				if execu.direction == "horizontal" then
					return 20
				elseif execu.direction == "vertical" then
					return 40 * 2
				end
			end,

		winbar = {
			enabled = true,
			name_formatter = function(execu) --  term: Terminal
				return execu.name
			end
		},

		highlights = {
			FloatBorder = {
				guifg = "#BD93F9",
			},
		},

		direction = 'float',
		float_opts = {
			border = 'double',
			winblend = 0, -- alpha % 0 to 100
		},

		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_terminals = true,
		cmd = wrapand,
		start_in_insert = true,
		close_on_exit = false,
	})
	execu:toggle()
end
--}}}

-- Trigger functions
-- Compile{{{
function TriggerCompile(file_type)
	SRC_NAME = expand('%')
	OUT_NAME = expand('%:r')

	if file_type == 'c' then
		CC = 'gcc'
		CARGS = '-std=c99 -Wall -o '
	elseif file_type == 'cpp' then
		CC = 'g++'
		CARGS = '-Wall -o '
	elseif file_type == 'rust' then
		CC = 'rustc'
		CARGS = ''
		OUT_NAME = ''
	elseif file_type == 'nroff' then
		CC = 'groff'
		CARGS = '-mspdf -Tpdf >'
	elseif file_type == 'rmd' then
		CC = 'Rscript'
		CARGS = ' && '
		SRC_NAME = [[-e "rmarkdown::render(input = ']] .. expand('%') .. [[', output_format = \"html_document\")"]]
		OUT_NAME = [[Rscript -e "rmarkdown::render(input = ']] .. expand('%') .. [[', output_format = \"pdf_document\")"]]
	elseif file_type == 'tex' then
		CC = 'xelatex'
		CARGS = ''
		OUT_NAME = ''
	else
		print('Not src')
		return 1
	end

	runTerminal(CC .. ' ' .. SRC_NAME .. ' ' .. CARGS .. ' ' .. OUT_NAME)
end
--}}}
-- Run{{{
function TriggerRun(file_type)
	SRC_NAME = expand('%')

-- C
	if file_type == 'c' or
		file_type == 'cpp' or
		file_type == 'rust' then
		CC = ''
		CARGS = ''
		SRC_NAME = './' .. expand('%:r')
-- Groff, Rmarkdown, LaTeX
	elseif file_type == 'nroff' or
		file_type == 'rmd' or
		file_type == 'tex' then
		CC = 'nohup zathura'
		CARGS = '>/dev/null &'
		SRC_NAME = SRC_NAME .. '.pdf'
-- Python
	elseif file_type == 'python' then
		CC = 'python'
		CARGS = ''
-- Shell
	elseif file_type == 'sh' then
		CC = 'bash'
		CARGS = ''
-- Lua
	elseif file_type == 'lua' then
		CC = 'lua'
		CARGS = ''
-- Markdown
	elseif file_type == 'markdown' then
		CC = 'glow'
		CARGS = '-p'
-- Sent
	elseif file_type == 'sent' then
		CC = 'sent -b "#000000" -c "#ffffff" '
		CARGS = ''
	else
		print('Not x')
		return 1
	end

	runTerminal(CC .. ' ' .. SRC_NAME .. ' ' .. CARGS)
end
--}}}
-- Debug{{{
function TriggerDebug(file_type)
	print("Debug function is not ready yet, sorry :.)")
end
--}}}

RunnerCMD = ':lua TriggerRun(vim.bo.filetype)<CR>'
CompilerCMD = ':lua TriggerCompile(vim.bo.filetype)<CR>'
DebugCMD = ':lua TriggerDebug(vim.bo.filetype)<CR>'

function Term(input)
	if Split_style then
		Split_style = 'h'
	end
	if input then
		runTerminal('echo "\27[33;1m' .. input ..'\27[0m"' .. ' && ' .. input)
	else
		runTerminal()
	end
end

-- Compile/Run keymaps {{{
map('n', '<leader>fe', RunnerCMD, { silent = true })
map('n', '<leader>fw', CompilerCMD, { silent = true })
map('n', '<leader>fq', DebugCMD, { silent = true })

-- makefile
map('n', '<leader>cc', ':lua runTerminal("make")<CR>', { silent = true })
-- }}}

--map('n', '<leader>tt', ":lua runTerminal()<CR>")
-- Git commands
map('n', '<leader>gs', ":lua Term('git status -s')<CR>")
map('n', '<leader>gl', ":lua Term('git log --oneline --all --graph')<CR>")
map('n', '<leader>ga', ":lua Term('git add .')<CR>")
map('n', '<leader>gd', ":lua Term('git diff .')<CR>")
map('n', '<leader>gt', ":lua Term('git tag')<CR>")
map('n', '<leader>gb', ":lua Term('git branch')<CR>")
