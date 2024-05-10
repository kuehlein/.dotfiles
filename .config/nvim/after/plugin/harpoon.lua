local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader><leader>", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>a", mark.add_file)

-- quick nav through marked files using up & down
vim.keymap.set("n", "<C-n>", ui.nav_next)
vim.keymap.set("n", "<C-p>", ui.nav_prev)

-- after configuring tmux, do some stuff here

