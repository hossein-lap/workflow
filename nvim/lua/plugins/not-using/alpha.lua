 local alpha = require'alpha'
 local dashboard = require'alpha.themes.dashboard'
 dashboard.section.header.val = {
	----[[                                     ]],
	----[[                        _            ]],
	----[[  _ __   ___  _____   _(_)_ __ ___   ]],
	----[[ | '_ \ / _ \/ _ \ \ / / | '_ ` _ \  ]],
	----[[ | | | |  __/ (_) \ V /| | | | | | | ]],
	----[[ |_| |_|\___|\___/ \_/ |_|_| |_| |_| ]],
 }
	 ---[[                               __                ]],
	 ---[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	 ---[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	 ---[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	 ---[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	 ---[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	 
 dashboard.section.buttons.val = {
	 dashboard.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
	 dashboard.button( "q", "  Quit NVIM" , ":qa<CR>"),
	 dashboard.button( "c", "+  New " , ":e "),
 }
 local handle = io.popen('start-say.sh')
 local fortune = handle:read("*a")
 handle:close()
 dashboard.section.footer.val = fortune

 dashboard.config.opts.noautocmd = true

 vim.cmd[[autocmd User AlphaReady echo 'ready']]

 alpha.setup(dashboard.config)
