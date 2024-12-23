local init_lazy = require("lazy_init")

require("remap") -- TBD
require("set") -- In progress
require("shortcuts") -- TBD
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

init_lazy()
