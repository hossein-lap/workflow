-- Example config in lua
vim.g.nord_contrast = false
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false

--require("headlines").setup({
--    markdown = {
--        headline_highlights = {
--            "Headline1",
--            "Headline2",
--            "Headline3",
--            "Headline4",
--            "Headline5",
--            "Headline6",
--        },
--        codeblock_highlight = "CodeBlock",
--        dash_highlight = "Dash",
--        quote_highlight = "Quote",
--    },
--})

-- Load the colorscheme
--require('nord').set()
vim.cmd.colorscheme "nord"
