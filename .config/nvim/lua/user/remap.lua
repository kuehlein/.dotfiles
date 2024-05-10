vim.g.mapleader = " ";
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex); -- should we use this?

-- vim grep
-- vim.keymap.set("n", "<leader>g", ":vimgrep // %<Left><Left><Left>"); -- search
-- vim.keymap.set("n", "<leader>j", ":cn<CR>"); -- next - "n"?
-- vim.keymap.set("n", "<leader>k", ":cp<CR>"); -- previous - "p"?
vim.keymap.set("n", "<leader>o", ":copen<CR>"); -- open match window
vim.keymap.set("n", "<leader>c", ":cclose<CR>"); -- close match window

vim.keymap.set("n", "<leader>sr", function()
    local old_text = vim.fn.input("search:");
    local new_text = vim.fn.input("replace:");
    vim.cmd("%s/" .. old_text .. "/" .. new_text .. "/gc");
end); -- substitute


-- resize reset
-- vim.api.nvim_set_keymap('n', '<C-=>', '<C-w><C-=>', { noremap = true, silent = true })

-- vertical resize
-- vim.api.nvim_set_keymap('n', '<C-+>', ':vertical resize +5<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-->', ':vertical resize -5<CR>', { noremap = true, silent = true })

-- horizontal resize
-- vim.api.nvim_set_keymap('n', '<C-<>', ':resize +5<CR>')
-- vim.api.nvim_set_keymap('n', '<C->>', ':resize -5<CR>')


-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--
-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
--
-- -- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])
--
-- -- next greatest remap ever : asbjornHaland
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
--
-- vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
--
-- -- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")
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
--
-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/user/packer.lua<CR>");
-- vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
--
-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)

