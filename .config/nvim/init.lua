vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy_init")
require("remap") -- TBD
require("set") -- In progress
require("overwrite")
require("theme")

local layouts = require("layouts")
layouts.colemak()

-- TODO: is there a better place to put this??
vim.filetype.add({
	extension = {
		jsx = "javascriptreact", -- "javascript"
		tsx = "typescriptreact", -- "typescript"
	},
})
