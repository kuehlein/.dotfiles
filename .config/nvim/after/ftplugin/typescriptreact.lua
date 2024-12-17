-- TODO: delete this file once i figure out how to fix filetypes
-- TODO: delete this file once i figure out how to fix filetypes
-- TODO: delete this file once i figure out how to fix filetypes
-- TODO: delete this file once i figure out how to fix filetypes
-- TODO: delete this file once i figure out how to fix filetypes
-- TODO: delete this file once i figure out how to fix filetypes

-- apply these settings every time

-- use 2 spaces for indents
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

-- don't reapply config if it is already active
if vim.g.typescript_ftplugin_is_active then
	return
end

vim.g.typescript_ftplugin_is_active = true

local theme_path = os.getenv("HOME") .. "/.dotfiles/.config/nvim/lua/utils/theme.lua"
package.page = package.path .. ";" .. theme_path

local theme_utils = require("utils.theme")

-- local set = vim.opt_local;
local p = theme_utils.palette
local colors = theme_utils.colors

theme_utils.apply_theme({
	["@function.typescript"] = { fg = colors.blue[2] },
	["@lsp.type.interface.typescriptreact"] = { fg = p.fg.purple },
	["@lsp.type.parameter.typescript"] = { fg = p.fg.orange },
	["@lsp.type.parameter.typescriptreact"] = { fg = p.fg.orange },
	["@lsp.type.type.typescriptreact"] = { fg = p.fg.purple },
	-- ["@lsp.type.variable.typescript"] = { fg = p.white },
	["@lsp.type.variable.typescriptreact"] = { fg = p.fg.blue },
	["@lsp.typemod.variable.readonly.typescript"] = { fg = colors.blue[2] }, -- p.fg.blue??
	["@lsp.typemod.parameter.declaration.typescript"] = { fg = p.fg.orange },
	["@lsp.typemod.parameter.declaration.typescriptreact"] = { fg = p.fg.orange },
	["@lsp.typemod.property.declaration.typescriptreact"] = { fg = p.white },
	["@none.tsx"] = { fg = p.white },
	["@punctuation.bracket.tsx"] = { fg = p.fg.green },
	["@punctuation.bracket.typescript"] = { fg = p.fg.green },
	["@punctuation.special.tsx"] = { fg = p.fg.red },
	["@string.escape.typescript"] = { fg = p.fg.red },
	["@tag.attribute.tsx"] = { fg = p.fg.purple },
	["@tag.builtin.tsx"] = { fg = colors.green[1] },
	["@tag.tsx"] = { fg = colors.blue[2] },
	["@type.builtin.tsx"] = { fg = p.fg.blue },
})
