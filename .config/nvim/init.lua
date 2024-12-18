local init_lazy = require("lazy_init")

require("colemak_dhm")
require("remap") -- TBD
require("set") -- In progress
require("shortcuts") -- TBD
require("theme")

-- TODO: is there a better place to put this??
vim.filetype.add({
	extension = {
		jsx = "javascriptreact",
		tsx = "typescriptreact",
		-- jsx = "javascript",
		-- tsx = "typescript",
	},
})

init_lazy()
