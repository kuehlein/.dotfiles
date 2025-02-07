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
-- if vim.g.typescript_ftplugin_is_active then
-- 	return
-- end

vim.g.typescript_ftplugin_is_active = true

local theme_path = os.getenv("HOME") .. "/.dotfiles/.config/nvim/lua/utils/theme.lua"
package.page = package.path .. ";" .. theme_path

local theme_utils = require("utils.theme")

-- local set = vim.opt_local;
local p = theme_utils.palette
local colors = theme_utils.colors

theme_utils.apply_theme({
	-- lsp
	["@lsp.type.interface.typescriptreact"] = { fg = p.fg.purple },
	["@lsp.type.member.typescriptreact"] = { fg = p.fg.purple },
	["@lsp.type.parameter.typescriptreact"] = { fg = p.fg.orange },
	["@lsp.type.property.typescriptreact"] = { fg = p.white },
	["@lsp.type.type.typescriptreact"] = { fg = p.fg.purple },
	["@lsp.type.typeparameter.typescriptreact"] = { fg = p.fg.purple },
	["@lsp.typemod.class.defaultLibrary.typescriptreact"] = { fg = p.fg.blue },
	["@lsp.typemod.member.declaration.typescriptreact"] = { fg = p.fg.purple },
	["@lsp.typemod.property.declaration.typescriptreact"] = { fg = p.white },
	["@lsp.typemod.variable.defaultLibrary.typescriptreact"] = { fg = p.fg.blue },
	["@lsp.typemod.variable.readonly.typescriptreact"] = { fg = p.fg.blue },

	-- tsx
	["tsxAttrib"] = { fg = p.fg.purple },
	["tsxCloseTag"] = { fg = p.white },
	["tsxEqual"] = { fg = p.fg.red },
	["tsxIntrinsicTagName"] = { fg = colors.green[0] },
	["tsxTagName"] = { fg = p.fg.blue },

	-- typescript
	["typescriptAssign"] = { fg = p.fg.red },
	["typescriptBinaryOp"] = { fg = p.fg.red },
	["typescriptBlock"] = { fg = p.white },
	["typescriptBraces"] = { fg = p.fg.green },
	["typescriptCastKeyword"] = { fg = p.fg.red },
	["typescriptConditionalParen"] = { fg = p.fg.red },
	["typescriptDefaultParam"] = { fg = p.fg.red },
	["typescriptDotNotation"] = { fg = p.white },
	["typescriptEndColons"] = { fg = p.white },
	["typescriptExceptions"] = { fg = p.fg.red },
	["typescriptExport"] = { fg = p.fg.red },
	["typescriptFuncCallArg"] = { fg = p.fg.orange },
	["typescriptIdentifierName"] = { fg = p.white },
	["typescriptProperty"] = { fg = p.white },
	["typescriptImport"] = { fg = p.fg.red },
	["typescriptInterfaceTypeParameter"] = { fg = p.fg.green },
	["typescriptLoopParen"] = { fg = p.white },
	["typescriptMagicComment"] = { bg = p.bg.green, fg = p.fg.green },
	["typescriptMemberOptionality"] = { fg = p.fg.red },
	["typescriptObjectColon"] = { fg = p.white },
	["typescriptObjectSpread"] = { fg = p.fg.red },
	["typescriptObjectLiteral"] = { fg = p.white },
	["typescriptOperator"] = { fg = p.fg.red },
	["typescriptOptionalMark"] = { fg = p.fg.red },
	["typescriptParenExp"] = { fg = p.fg.red },
	["typescriptParens"] = { fg = p.fg.green },
	["typescriptPredefinedType"] = { fg = colors.blue[1] },
	["typescriptTernaryOp"] = { fg = p.fg.red },
	["typescriptTypeAnnotation"] = { fg = p.fg.red },
	["typescriptTypeBracket"] = { fg = p.fg.green },
	["typescriptTypeBrackets"] = { fg = p.fg.green },
	["typescriptTypeReference"] = { fg = p.white },
	["typescriptUnaryOp"] = { fg = p.fg.red },
	["typescriptUnion"] = { fg = p.fg.red },
	["typescriptVariable"] = { fg = p.fg.red },
})
