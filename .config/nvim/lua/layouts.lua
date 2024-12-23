local opts = { noremap = true, silent = true }

local colemak = function()
	-- Colemak mnei(hjkl), t(i), <C-n>(f), <C-e>(e)
	vim.keymap.set("n", "m", "h", opts) -- move Left (normal mode)
	vim.keymap.set("n", "n", "j", opts) -- move Down (normal mode)
	vim.keymap.set("n", "e", "k", opts) -- move Up (normal mode)
	vim.keymap.set("n", "i", "l", opts) -- move Right (normal mode)

	vim.keymap.set("v", "m", "h", opts) -- move Left (visual mode)
	vim.keymap.set("v", "n", "j", opts) -- move Down (visual mode)
	vim.keymap.set("v", "e", "k", opts) -- move Up (visual mode)
	vim.keymap.set("v", "i", "l", opts) -- move Right (visual mode)

	vim.keymap.set("n", "t", "i", opts) -- (t)ype replaces (i)nsert
	vim.keymap.set("n", "T", "I", opts) -- (T)ype at bol replaces (I)nsert

	vim.keymap.set("v", "t", "i", opts) -- (t)ype replaces (i)nsert
	vim.keymap.set("v", "T", "I", opts) -- (T)ype at bol replaces (I)nsert

	vim.keymap.set("n", "l", "e", opts) -- end of word replaces (e)nd
	vim.keymap.set("v", "l", "e", opts) -- end of word replaces (e)nd

	-- vim.keymap.set('n', 'h', 'n', opts);          -- next match replaces (n)ext
	-- vim.keymap.set('n', 'k', 'N', opts);          -- previous match replaces (N) prev
	-- vim.keymap.set('n', '<C-m>', 'm', opts);      -- mark replaces (m)ark
	--
	-- vim.keymap.set('n', '<C-n>', '<C-f>', opts);  -- Page down
	-- vim.keymap.set('n', '<C-e>', '<C-b>H', opts); -- Page up, cursor up

	-- Fix sequences like (c)hange (i)n (w)ord
	-- vim.keymap.set('n', 'ci', 'ci', opts)
	-- vim.keymap.set('n', 'di', 'di', opts)
	-- vim.keymap.set('n', 'vi', 'vi', opts)
	-- vim.keymap.set('n', 'yi', 'yi', opts)
	-- vim.keymap.set('n', 'ct', 'ct', opts)
	-- vim.keymap.set('n', 'dt', 'dt', opts)
	-- vim.keymap.set('n', 'vt', 'vt', opts)
	-- vim.keymap.set('n', 'yt', 'yt', opts)
end

local qwerty = function()
	vim.keymap.set("n", "h", "h", opts)
	vim.keymap.set("n", "j", "j", opts)
	vim.keymap.set("n", "k", "k", opts)
	vim.keymap.set("n", "l", "l", opts)

	vim.keymap.set("v", "h", "h", opts)
	vim.keymap.set("v", "j", "j", opts)
	vim.keymap.set("v", "k", "k", opts)
	vim.keymap.set("v", "l", "l", opts)

	vim.keymap.set("n", "i", "i", opts)
	vim.keymap.set("n", "I", "I", opts)

	vim.keymap.set("v", "i", "i", opts)
	vim.keymap.set("v", "I", "I", opts)

	vim.keymap.set("n", "e", "e", opts)
	vim.keymap.set("n", "n", "n", opts)
	vim.keymap.set("n", "N", "N", opts)
	vim.keymap.set("n", "m", "m", opts)

	vim.keymap.set("v", "e", "e", opts)
	vim.keymap.set("v", "n", "n", opts)
	vim.keymap.set("v", "N", "N", opts)
	vim.keymap.set("v", "m", "m", opts)
end

vim.api.nvim_create_user_command("Colemak", colemak, { nargs = 0 })
vim.api.nvim_create_user_command("Qwerty", qwerty, { nargs = 0 })

-- return remaps to invoke in init.lua
return {
	colemak = colemak,
	qwerty = qwerty,
}
