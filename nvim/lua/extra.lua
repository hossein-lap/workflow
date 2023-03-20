-- helper {{{
local api = vim.api
local cmd = vim.cmd
-- autocmd function {{{
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
--}}}
-- key map function {{{
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
-- umap 
local function umap(mode, key)
	if not mode or not key then
		vim.notify('umap(mode, key) must have both arguments', 4,
			{title = 'Error on using umap()'})
		return 1
	end
	api.nvim_del_keymap(mode, key)
end
--}}}
-- }}}

-- autocmds {{{
au("set filetype=nroff",	{'*.me'},	{'BufRead', 'BufNewFile'})
au("set filetype=nroff",	{'*.ms'},	{'BufRead', 'BufNewFile'})
au("set filetype=nroff",	{'*.mm'},	{'BufRead', 'BufNewFile'})
au("set filetype=nim",		{'*.nim'},	{'BufRead', 'BufNewFile'})
au("set filetype=c",		{'*.h'},	{'BufRead', 'BufNewFile'})
au("set filetype=json",		{'*.theme'},	{'BufRead', 'BufNewFile'})
au("set filetype=nasm",		{'*.s'},	{'BufRead', 'BufNewFile'})
au("set filetype=sent",		{'*.sent'},	{'BufRead', 'BufNewFile'})

au("set noexpandtab",		{'c', 'make', 'nasm'})
au("set tabstop=8",		{'c', 'make', 'nasm'})
au("set softtabstop=8",		{'c', 'make', 'nasm'})
au("set shiftwidth=8",		{'c', 'make', 'nasm'})

au("set filetype=tex",		{'plaintex'})

--au("set tabstop=2",		{'sent', 'text', })
--au("set softtabstop=2",	{'sent', 'text', })
--au("set shiftwidth=3",	{'sent', 'text', })

au("set tabstop=4", {
	'python', 'bash', 'sh', 'toml', 'yaml', 'nvim',
	'markdown', 'nim', 'rmd', 'sent', 'text'
})
au("set softtabstop=4", {
	'python', 'bash', 'sh', 'toml', 'yaml', 'nvim',
	'markdown', 'nim', 'rmd', 'sent', 'text'
})
au("set shiftwidth=4", {
	'python', 'bash', 'sh', 'toml', 'yaml', 'nvim',
	'markdown', 'nim', 'rmd', 'sent', 'text'
})
au("set expandtab", {
	'python', 'toml', 'yaml', 'markdown', 'nim', 'rmd',
	'sent', 'text'
})

au(":silent lua AutoFillAll()", {
	'c', 'cpp', 'python', 'lua', 'sh', 'make', 'tex',
	'rmd', 'markdown', 'sent', 'text', 'go', 'rust'
})
--}}}
-- autofill {{{
Autofill  = true
Mautofill = true
Sautofill = true
-- global autofill function {{{
function AutoFillAll()
	AutoFillEnable(false)
	AutoFillMarkdownEnable(false)
	AutoFillSentEnable(false)
end

function AutoFill(notify_me)
	notify_me = true
	AutoFillToggle(notify_me)
	AutoFillMarkdownToggle(notify_me)
	AutoFillSentToggle(notify_me)
end
-- }}}
-- basic autofill function {{{
function AutoFillToggle(notify_me)
	notify_me = true
	if Autofill == false then
		Autofill = true
		AutoFillEnable(notify_me)
	else
		Autofill = false
		AutoFillDisable(notify_me)
	end
end

function AutoFillEnable(notify_me)
	map('i', '"', '""<Left>')
	map("i", "'", "''<Left>")
	map('i', '`', '``<Left>')
	map('i', '(', '()<Left>')
	map('i', '[', '[]<Left>')
	map('i', '{', '{}<Left>')

	if notify_me then
		vim.notify("Autofill is enabled", 2, {title = 'extra.lua'})
	end
end

function AutoFillDisable(notify_me)
	umap('i', '"')
	umap("i", "'")
	umap('i', '`')
	umap('i', '(')
	umap('i', '[')
	umap('i', '{')

	if notify_me then
		vim.notify("Autofill is disabled", 2, {title = 'extra.lua'})
	end
end
--}}}
-- markdown autofill function {{{
function AutoFillMarkdownToggle(notify_me)
	notify_me = true
	if Mautofill == false then
		Mautofill = true
		AutoFillMarkdownEnable(notify_me)
	else
		Mautofill = false
		AutoFillMarkdownDisable(notify_me)
	end
end

function AutoFillMarkdownEnable(notify_me)
	local ft = vim.bo.filetype
	if ft == 'markdown' or ft == 'rmd' then
		map('i', '*', '**<Left>')
		map('i', '_', '__<Left>')

		if notify_me then
			vim.notify("Markdown Autofill is enabled", 2, {title = 'extra.lua'})
		end
	end
end

function AutoFillMarkdownDisable(notify_me)
	local ft = vim.bo.filetype
	if ft == 'markdown' or ft == 'rmd' then
		umap('i', '*')
		umap('i', '_')

		if notify_me then
			vim.notify("Markdown Autofill is disabled", 2, {title = 'extra.lua'})
		end
	end
end
--}}}
-- sent autofill function {{{
function AutoFillSentToggle(notify_me)
	notify_me = true
	if Sautofill == false then
		Sautofill = true
		AutoFillSentEnable(notify_me)
	else
		Sautofill = false
		AutoFillSentDisable(notify_me)
	end
end

function AutoFillSentEnable(notify_me)
	local ft = vim.bo.filetype
	if ft == 'sent' or ft == 'text' then
		map('i',	'`>',	'›')
		map('i',	'`<',	'‹')
		map('i',	'`>>',	'»')
		map('i',	'`<<',	'«')
		map('i',	'`>>>',	'⟩')
		map('i',	'`<<<',	'⟨')
		map('i',	'`|',	'¦')
		map('i',	'``',	'●')
		map('i',	'`1',	'○')
		map('i',	'`2',	'□')
		map('i',	'`3',	'◊')
		map('i',	'`4',	'¶')
		map('i',	'`5',	'✓')
		map('i',	'`.',	'•')
		map('i',	'`,',	'▸')
		map('i',	'`->',	'→')
		map('i',	'`-<',	'←')
		map('i',	'`=>',	'⇒')
		map('i',	'`=<',	'⇐')
		map('i',	'`x',	'×')
		map('i',	'`e',	'≡')
		map('i',	'`c',	'©')
		map('i',	'`r',	'®')
		map('i',	'`t',	'™')
		map('i',	'`<=',	'≤')
		map('i',	'`>=',	'≥')
		map('i',	'`!=',	'≠')
		map('i',	'`~=',	'≃')
		map('i',	'`~~',	'≈')

		if notify_me then
			vim.notify("Sent Autofill is enabled", 2, {title = 'extra.lua'})
		end
	end
end

function AutoFillSentDisable(notify_me)
	local ft = vim.bo.filetype
	if ft == 'sent' or ft == 'text' then
		umap('i',	'`>')
		umap('i',	'`<')
		umap('i',	'`>>')
		umap('i',	'`<<')
		umap('i',	'`>>>')
		umap('i',	'`<<<')
		umap('i',	'`|')
		umap('i',	'`->')
		umap('i',	'`-<')
		umap('i',	'`=>')
		umap('i',	'`=<')
		umap('i',	'`.')
		umap('i',	'`,')
		umap('i',	'``')
		umap('i',	'`1')
		umap('i',	'`2')
		umap('i',	'`3')
		umap('i',	'`4')
		umap('i',	'`5')
		umap('i',	'`x')
		umap('i',	'`e')
		umap('i',	'`c')
		umap('i',	'`r')
		umap('i',	'`t')
		umap('i',	'`<=')
		umap('i',	'`>=')
		umap('i',	'`!=')
		umap('i',	'`~=')
		umap('i',	'`~~')

		if notify_me then
			vim.notify("Sent Autofill is disabled", 2, {title = 'extra.lua'})
		end
	end
end
--}}}
-- }}}
---- paste mode toggle {{{
--Pastetoggle = 0
--function PasteToggle()
--	if Pastetoggle == 0 then
--		Pastetoggle = 1
--		cmd [[:set paste ]]
--	end
--	if Pastetoggle == 1 then
--		Pastetoggle = 0
--		cmd [[:set nopaste ]]
--	end
--end
---- }}}

-- FoldMethod
--au("loadview",	{}, { "BufRead" } )
--au("mkview",	{}, { "BufWrite" } )
