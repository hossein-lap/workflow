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
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	api.nvim_set_keymap(mode, key, command, options)
end
-- unmap 
local function umap(mode, key)
	if not mode or not key then
		print('Error on using umap()')
		print('umap(mode, key) must have both arguments')
		return 1
	end
	api.nvim_del_keymap(mode, key)
end
--}}}
-- }}}

-- autocmds {{{
--au( "set filetype=me syntax=nroff",		{'*.me'},	{'BufRead', 'BufNewFile'} )
--au( "set filetype=ms syntax=nroff",		{'*.ms'},	{'BufRead', 'BufNewFile'} )
au( "set filetype=nim",		{'*.nim'},			{'BufRead', 'BufNewFile'} )
au( "set filetype=c",		{'*.h'},			{'BufRead', 'BufNewFile'} )
au( "set filetype=json",	{'*.theme'},		{'BufRead', 'BufNewFile'} )
au( "set filetype=nasm",	{'*.s',	'*.asm'},	{'BufRead', 'BufNewFile'} )
au( "set filetype=sent",	{'*.sent'},			{'BufRead', 'BufNewFile'} )

au( "set noexpandtab",		{ 'c', 'make', 'nasm' })
au( "set tabstop=8",		{ 'c', 'make', 'nasm' })
au( "set softtabstop=8",	{ 'c', 'make', 'nasm' })
au( "set shiftwidth=8",		{ 'c', 'make', 'nasm' })

au( "set filetype=tex",		{ 'plaintex' })

--au( "set tabstop=2",		{ 'sent', 'text', })
--au( "set softtabstop=2",	{ 'sent', 'text', })
--au( "set shiftwidth=3",		{ 'sent', 'text', })

au( "set tabstop=4",		{ 'python', 'bash', 'sh', 'toml', 'yaml', 'nvim', 'markdown', 'nim', 'rmd', 'sent', 'text' })
au( "set softtabstop=4",	{ 'python', 'bash', 'sh', 'toml', 'yaml', 'nvim', 'markdown', 'nim', 'rmd', 'sent', 'text' })
au( "set shiftwidth=4",		{ 'python', 'bash', 'sh', 'toml', 'yaml', 'nvim', 'markdown', 'nim', 'rmd', 'sent', 'text' })
au( "set expandtab",		{ 'python', 'toml', 'yaml', 'markdown', 'nim', 'rmd', 'sent', 'text' })

au( ":silent lua AutoFillAll()", {
	'c', 'cpp', 'python', 'lua', 'sh', 'make', 'tex', 'rmd', 'markdown',
	'sent', 'text',
})
--}}}
-- autofill {{{
-- global autofill function {{{
function AutoFillAll()
	AutoFill()
	AutoFillMarkdown()
	AutoFillSent()
end
-- }}}
-- basic autofill function {{{
Autofill = 0
function AutoFill()
	if Autofill == 0 then
		Autofill = 1
		map('i', '"', '""<Left>')
		map("i", "'", "''<Left>")
		map('i', '`', '``<Left>')
		map('i', '(', '()<Left>')
		map('i', '[', '[]<Left>')
		map('i', '{', '{}<Left>')
--		print("AutoFill() [Enabled]")
	else
		Autofill = 0
		umap('i', '"')
		umap("i", "'")
		umap('i', '`')
		umap('i', '(')
		umap('i', '[')
		umap('i', '{')
--		print("AutoFill() [Disabled]")
	end
end
--}}}
-- markdown autofill function {{{
Mautofill = 0
function AutoFillMarkdown()
	local ft = vim.bo.filetype
	if ft == 'markdown' or ft == 'rmd' then
		if Mautofill == 0 then
			Mautofill = 1
			map('i', '*', '**<Left>')
			map('i', '_', '__<Left>')
		else
			Mautofill = 0
			umap('i', '*')
			umap('i', '_')
		end
	end
end
--}}}
-- sent autofill function {{{
Sautofill = 0
function AutoFillSent()
	local ft = vim.bo.filetype
	if ft == 'sent' or ft == 'text' then
		if Sautofill == 0 then
			Sautofill = 1
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
		else --[[   ]]
			Sautofill = 0
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
--au( "loadview",	{}, { "BufRead" } )
--au( "mkview",	{}, { "BufWrite" } )
