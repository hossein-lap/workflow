-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--cmp_nvim_lsp.default_capabilities

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'texlab', 'pyright', 'lua_ls', 'gopls'}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
--		on_attach = my_custom_on_attach,
		capabilities = capabilities,
	}
end

-- luasnip setup
--vim.opt.completeopt = "menuone,noselect"

local function border(hl_name)
local borderstyle = { -- {{{
	ascii = {
		{ "/", hl_name },
		{ "-", hl_name },
		{ "\\", hl_name },
		{ "|", hl_name },
	},
	single = {
		{ "┌", hl_name },
		{ "─", hl_name },
		{ "┐", hl_name },
		{ "│", hl_name },
		{ "┘", hl_name },
		{ "─", hl_name },
		{ "└", hl_name },
		{ "│", hl_name },
	},
	double = {
		{ "╔", hl_name },
		{ "═", hl_name },
		{ "╗", hl_name },
		{ "║", hl_name },
		{ "╝", hl_name },
		{ "═", hl_name },
		{ "╚", hl_name },
		{ "║", hl_name },
	},
	round = {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	},
}
-- }}}
	return borderstyle['single']
end

local cmp_window = require "cmp.utils.window"

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
	local info = self:info_()
	info.scrollable = false
	return info
end

-- nvim-cmp setup
--local cmp = require 'cmp'
local present, cmp = pcall(require, "cmp")

if not present then
	return
end

---- If you want insert `(` after select function or method item
---- **requires** `nvim-autopairs`
--local cmp_autopairs = require('nvim-autopairs.completion.cmp')
--cmp.event:on(
--	'confirm_done',
--	cmp_autopairs.on_confirm_done()
--)

--   פּ ﯟ   some other good icons
local kind_icons = { -- {{{
	Text = " ",
	Method = " ",
	Function = " ",
	Constructor = " ",
	Field = " ",
	Variable = "v ",
	Class = " ",
	Interface = " ",
	Module = " ",
	Property = " ",
	Unit = " ",
	Value = " ",
	Enum = " ",
	Keyword = " ",
	Snippet = " ",
	Color = " ",
	File = " ",
	Reference = " ",
	Folder = " ",
	EnumMember = " ",
	Constant = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
} -- }}}

-- all options as a table {{{
local options = {
	-- window {{{
	window = {
		completion = {
			border = border "CmpBorder",
			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
		},
		documentation = {
			border = border "CmpDocBorder",
		},
	},
	-- }}}
	-- snippet {{{
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	-- }}}
	-- formatting {{{
	formatting = {
--		format = function(_, vim_item)
----			local icons = require("nvchad_ui.icons").lspkind
----			vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
--			return vim_item
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
			 	-- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lsp = '[lsp]',
				luasnip = '[snippet]',
				nvim_lua = '[nvim_lua]',
				buffer = '[buffer]',
				path = '[path]',
				dictionary = '[dictionary]'
			})[entry.source.name]
			return vim_item
		end,
	}, -- }}}
	-- mappings {{{
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		["<C-s>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes(
						"<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<C-a>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes(
						"<Plug>luasnip-jump-prev", true, true, true) , "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	-- }}}
	-- sources {{{
	sources = {
		{ name = "nvim_lsp", priority = 5 },
		{ name = "nvim_lua", priority = 4 },
		{ name = "path", priority = 3 },
		{ name = "buffer", priority = 3 },
		{ name = 'dictionary', keyword_lenth = 3, priority = 2 },
		{ name = "luasnip", priority = 1 },
	},
	-- }}}
--	-- sorting {{{
--	sorting = {
--		priority_weight = 1.0,
--		comparators = {
----			compare.score_offset, -- not good at all
--			compare.locality,
--			compare.recently_used,
--			-- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
--			compare.score,
--			compare.offset,
--			compare.order,
----			compare.scopes, -- what?
----			compare.sort_text,
----			compare.exact,
----			compare.kind,
----			compare.length, -- useless 
--		},
--	},
--	-- }}}
}
-- }}}

-- check for any override
--options = require("core.utils").load_override(options, "hrsh7th/nvim-cmp")

cmp.setup(options)

require('plugin.cmp.dictionary')
