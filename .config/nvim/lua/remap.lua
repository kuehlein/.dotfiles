vim.keymap.set("n", "<leader>-", vim.cmd.Ex)

-- increment/decrement
vim.keymap.set({ "n", "v" }, "+", "<C-a>", { desc = "Increment numbers", noremap = true })
vim.keymap.set({ "n", "v" }, "-", "<C-x>", { desc = "Decrement numbers", noremap = true })

---------------------------------------------------------------------------
-- probably dont keep these... vvv
--------------------------------------------------------------------------

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--
-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]]) -- deletes and pastes without yanking into any register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- deletes without yanking into any register

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({ "n", "v" }, "<leader>c", [["+y]])
-- vim.keymap.set("n", "<leader>C", [["+Y]])
--
-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
--
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
--
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
