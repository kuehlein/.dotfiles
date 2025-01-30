local function expand_error()
	-- first call opens the error window, second jumps inside
	vim.diagnostic.open_float()
	vim.diagnostic.open_float()
end

vim.api.nvim_set_keymap("n", "<leader>e", "", { callback = expand_error, noremap = true, silent = true })

-- copy to system clipboard in visual mode
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
