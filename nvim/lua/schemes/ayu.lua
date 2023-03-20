local colors = require('ayu.colors')
colors.generate() -- Pass `true` to enable mirage

require('ayu').setup({
	-- Set to `true` to use `mirage` variant instead of `dark` for dark background.
	mirage = false,

	-- A dictionary of group names, each associated with
	-- a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
	overrides = function()
--			if vim.o.background == 'dark' then
--				return {
--					Comment = { fg = colors.comment },
--					NormalNC = {bg = '#0f151e', fg = '#808080'}
--				}
--			else
--				return {
--					Comment = { fg = colors.comment },
--					NormalNC = {bg = '#f0f0f0', fg = '#808080'}
--				}
--			end
--
			return {
				Comment = { fg = colors.comment },
			}
		end,
	})

vim.cmd.colorscheme "ayu-dark"
--require('ayu').colorscheme()
