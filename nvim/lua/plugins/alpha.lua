local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'
dashboard.section.header.val = {
	[[                        _            ]],
	[[  _ __   ___  _____   _(_)_ __ ___   ]],
	[[ | '_ \ / _ \/ _ \ \ / / | '_ ` _ \  ]],
	[[ | | | |  __/ (_) \ V /| | | | | | | ]],
	[[ |_| |_|\___|\___/ \_/ |_|_| |_| |_| ]],
 }
	 ---[[                               __                ]],
	 ---[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	 ---[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	 ---[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	 ---[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	 ---[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],

	 --[[  ]]
	 --
--local hhandle = io.popen('figlet neovim')
--local toppmsg = hhandle:read("*a")
--	hhandle:close()
--dashboard.section.header.val = toppmsg

dashboard.section.buttons.val = {
	 dashboard.button("e", "  Insert", ":ene <BAR> startinsert <CR>"),
	 dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
	 dashboard.button("c", "  Clear", ":ene <CR>"),
	 dashboard.button("s", "ﮮ  Packer Sync ", ":PackerSync<CR>"),
	 dashboard.button("n", "  New ", ":e "),
--	 dashboard.button("t", "  Terminal ", ":terminal zsh<CR>:setlocal nonu<CR>:norm a<CR>"),
}
local fhandle = io.popen('versions.sh')
local bottmsg = fhandle:read("*a")
	fhandle:close()
dashboard.section.footer.val = bottmsg

dashboard.config.opts.noautocmd = true

vim.cmd[[autocmd User AlphaReady echo 'ready']]

alpha.setup(dashboard.config)
