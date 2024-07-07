-- === Colemak Mod-DHM ===

local opts = { noremap = true, silent = true }

-- Colemak mnei(hjkl), t(i), <C-n>(f), <C-e>(e)
vim.keymap.set('n', 'h', 'h', opts);          -- move Left (normal mode)
vim.keymap.set('n', 'j', 'j', opts);          -- move Down (normal mode)
vim.keymap.set('n', 'k', 'k', opts);          -- move Up (normal mode)
vim.keymap.set('n', 'l', 'l', opts);          -- move Right (normal mode)

vim.keymap.set('v', 'h', 'h', opts);          -- move Left (visual mode)
vim.keymap.set('v', 'j', 'j', opts);          -- move Down (visual mode)
vim.keymap.set('v', 'k', 'k', opts);          -- move Up (visual mode)
vim.keymap.set('v', 'l', 'l', opts);          -- move Right (visual mode)

vim.keymap.set('n', 'i', 'i', opts);          -- (t)ype replaces (i)nsert
vim.keymap.set('n', 'I', 'I', opts);          -- (T)ype at bol replaces (I)nsert

vim.keymap.set('n', 'e', 'e', opts);          -- end of word replaces (e)nd
vim.keymap.set('n', 'h', 'n', opts);          -- next match replaces (n)ext
vim.keymap.set('n', 'N', 'N', opts);          -- previous match replaces (N) prev
vim.keymap.set('n', 'm', 'm', opts);      -- mark replaces (m)ark

-- Fix sequences like (c)hange (i)n (w)ord
vim.keymap.set('n', 'ci', 'ci', opts)
vim.keymap.set('n', 'di', 'di', opts)
vim.keymap.set('n', 'vi', 'vi', opts)
vim.keymap.set('n', 'yi', 'yi', opts)
vim.keymap.set('n', 'ct', 'ct', opts)
vim.keymap.set('n', 'dt', 'dt', opts)
vim.keymap.set('n', 'vt', 'vt', opts)
vim.keymap.set('n', 'yt', 'yt', opts)

