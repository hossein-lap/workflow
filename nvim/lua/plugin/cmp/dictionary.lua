local dict = require("cmp_dictionary")
local enDicPath = vim.fn.stdpath('config')..'/spell/en.dict'
--local deDicPath = string.format('%s/spell/de.dict', vim.fn.stdpath('config'))

dict.setup({
	-- The following are default values.
	exact = -1,
	first_case_insensitive = true,
	document = false,
	document_command = "wn %s -over",
	async = false,
	max_items = 10,
	capacity = 12,
	debug = false,
})

dict.switcher({
	filetype = {
		markdown = enDicPath,
		nroff = enDicPath,
		sent = enDicPath,
		tex = enDicPath,
		text = enDicPath,
	},
	filepath = {
		['*'] = { enDicPath }
	},
--	filepath = {
--		[".*xmake.lua"] = { "/path/to/xmake.dict", "/path/to/lua.dict" },
--		["%.tmux.*%.conf"] = { "/path/to/js.dict", "/path/to/js2.dict" },
--	},
	spelllang = {
		en = enDicPath,
	},
})
