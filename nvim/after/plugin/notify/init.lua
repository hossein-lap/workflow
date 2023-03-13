local width = math.floor(vim.api.nvim_get_option("columns") / 5)

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
	render = "default",
	stages = "static",
	timeout = 5000,
	top_down = true
})
