local function expand_error()
	-- first call opens the error window, second jumps inside
	vim.diagnostic.open_float()
	vim.diagnostic.open_float()
end

vim.keymap.set("n", "<leader>e", "", { callback = expand_error, noremap = true, silent = true })

-- copy to system clipboard in visual mode
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true })
