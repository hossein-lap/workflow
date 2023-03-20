local width = math.floor(vim.api.nvim_get_option("columns") / 5)

vim.cmd [[
highlight NotifyERRORBorder guifg=#8A1F1F
highlight NotifyWARNBorder guifg=#79491D
highlight NotifyINFOBorder guifg=#4F6752
highlight NotifyDEBUGBorder guifg=#8B8B8B
highlight NotifyTRACEBorder guifg=#4F3552
highlight NotifyERRORIcon guifg=#F70067
highlight NotifyWARNIcon guifg=#F79000
highlight NotifyINFOIcon guifg=#A9FF68
highlight NotifyDEBUGIcon guifg=#8B8B8B
highlight NotifyTRACEIcon guifg=#D484FF
highlight NotifyERRORTitle  guifg=#F70067
highlight NotifyWARNTitle guifg=#F79000
highlight NotifyINFOTitle guifg=#A9FF68
highlight NotifyDEBUGTitle  guifg=#8B8B8B
highlight NotifyTRACETitle  guifg=#D484FF
highlight link NotifyERRORBody Normal
highlight link NotifyWARNBody Normal
highlight link NotifyINFOBody Normal
highlight link NotifyDEBUGBody Normal
highlight link NotifyTRACEBody Normal
]]

require('notify').setup({
	background_colour = "Normal",
	fps = 30,
	icons = {
		TRACE = "✎",
		DEBUG = "",
		INFO = "",
		WARN = "",
		ERROR = "",
	},
	level = 2,
	minimum_width = width,
--	render = "minimal",
--	render = "compact",
	render = "default",
	stages = "static",
	timeout = 5000,
	top_down = true
})

vim.notify = require("notify") -- notification plugin
