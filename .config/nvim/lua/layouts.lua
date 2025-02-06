local opts = { noremap = true, silent = true }

local colemak = function()
	-- Colemak mnei(hjkl), t(i), <C-n>(f), <C-e>(e)
	vim.keymap.set({ "n", "v" }, "m", "h", opts) -- move Left
	vim.keymap.set({ "n", "v" }, "n", "j", opts) -- move Down
	vim.keymap.set({ "n", "v" }, "e", "k", opts) -- move Up
	vim.keymap.set({ "n", "v" }, "i", "l", opts) -- move Right

	vim.keymap.set({ "n", "v" }, "t", "i", opts) -- (t)ype replaces (i)nsert
	vim.keymap.set({ "n", "v" }, "T", "I", opts) -- (T)ype at bol replaces (I)nsert

	vim.keymap.set({ "n", "v" }, "l", "e", opts) -- end of word replaces (e)nd
	vim.keymap.set({ "n", "v" }, "h", "m", opts) -- (h)ighlight to remap marks

	-- vim.keymap.set('n', 'h', 'n', opts);          -- next match replaces (n)ext
	-- vim.keymap.set('n', 'k', 'N', opts);          -- previous match replaces (N) prev

	vim.keymap.set({ "n", "v" }, "<C-m>", "m", opts) -- mark replaces (m)ark

	-- vim.keymap.set('n', '<C-n>', '<C-f>', opts);  -- Page down
	-- vim.keymap.set('n', '<C-e>', '<C-b>H', opts); -- Page up, cursor up
end

local qwerty = function()
	vim.keymap.set({ "n", "v" }, "h", "h", opts)
	vim.keymap.set({ "n", "v" }, "j", "j", opts)
	vim.keymap.set({ "n", "v" }, "k", "k", opts)
	vim.keymap.set({ "n", "v" }, "l", "l", opts)

	vim.keymap.set({ "n", "v" }, "i", "i", opts)
	vim.keymap.set({ "n", "v" }, "I", "I", opts)

	vim.keymap.set({ "n", "v" }, "e", "e", opts)
	vim.keymap.set({ "n", "v" }, "n", "n", opts)
	vim.keymap.set({ "n", "v" }, "N", "N", opts)
	vim.keymap.set({ "n", "v" }, "m", "m", opts)
end

vim.api.nvim_create_user_command("Colemak", colemak, { nargs = 0 })
vim.api.nvim_create_user_command("Qwerty", qwerty, { nargs = 0 })

-- return remaps to invoke in init.lua
return {
	colemak = colemak,
	qwerty = qwerty,
}
