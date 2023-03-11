local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'
local hhandle = io.popen('nvim --version | head -1')
local nvim_version = hhandle:read("*a")
	hhandle:close()
dashboard.section.header.val = nvim_version
--dashboard.section.header.val = {
--	[[ _   _ _____ _____     _____ __  __ ]],
--	[[| \ | | ____/ _ \ \   / /_ _|  \/  |]],
--	[[|  \| |  _|| | | \ \ / / | || |\/| |]],
--	[[| |\  | |__| |_| |\ V /  | || |  | |]],
--	[[|_| \_|_____\___/  \_/  |___|_|  |_|]],
--}
--	[[                        _            ]],
--	[[  _ __   ___  _____   _(_)_ __ ___   ]],
--	[[ | '_ \ / _ \/ _ \ \ / / | '_ ` _ \  ]],
--	[[ | | | |  __/ (_) \ V /| | | | | | | ]],
--	[[ |_| |_|\___|\___/ \_/ |_|_| |_| |_| ]],
----
---	[[                               __                ]],
---	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
---	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
---	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
---	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
---	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],

	 --[[  ]]
	 --
--local hhandle = io.popen('figlet neovim')
--local toppmsg = hhandle:read("*a")
--	hhandle:close()
--dashboard.section.header.val = toppmsg

dashboard.section.buttons.val = {
	 dashboard.button("i", "  Insert", ":ene <BAR> startinsert <CR>"),
	 dashboard.button("e", "  New ", ":e "),
	 dashboard.button("c", "  Clear", ":ene <CR>"),
	 dashboard.button("S", "ﮮ  Packer Sync ", ":PackerSync<CR>"),
	 dashboard.button("I", "  Packer Install ", ":PackerInstall<CR>"),
	 dashboard.button("C", "  Packer Compile ", ":PackerCompile profile=true<CR>"),
--	 dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
--	 dashboard.button("t", "  Terminal ", ":terminal zsh<CR>:setlocal nonu<CR>:norm a<CR>"),
}
local fhandle = io.popen('versions.sh')
local bottmsg = fhandle:read("*a")
	fhandle:close()
dashboard.section.footer.val = bottmsg

dashboard.config.opts.noautocmd = true

vim.cmd[[autocmd User AlphaReady echo 'ready']]

alpha.setup(dashboard.config)
