vim.g.solarized_italics = 1
vim.g.solarized_visibility = 'normal'
vim.g.solarized_diffmode = 'normal'
vim.g.solarized_termtrans = 0
vim.g.solarized_statusline = 'normal'

---- To enable transparency
--if vim.fn.has('gui_running') == 0 then
--    vim.g.solarized_termtrans = 1
--else
--    vim.g.solarized_termtrans = 0
--end

vim.cmd.colorscheme "solarized"
