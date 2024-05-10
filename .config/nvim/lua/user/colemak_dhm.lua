-- -- === EasyMotion ===
--
-- -- Set leader key
-- vim.g.mapleader = ' '
--
-- -- EasyMotion commands
-- -- vim.api.nvim_set_keymap('n', '<Leader>', '<Plug>(easymotion-prefix)', {})
-- -- vim.api.nvim_set_keymap('n', 's', '<Plug>(easymotion-overwin-f2)', {})
--
-- -- === Colemak Mod-DHM ===
--
-- local opts = { noremap = true, silent = true }
--
-- -- Colemak mnei(hjkl), t(i), <C-n>(f), <C-e>(e)
-- vim.keymap.set('n', 'm', 'h', opts);          -- move Left
-- vim.keymap.set('n', 'n', 'gj', opts);         -- move Down
-- vim.keymap.set('n', 'e', 'gk', opts);         -- move Up
-- vim.keymap.set('n', 'i', 'l', opts);          -- move Right
-- vim.keymap.set('n', 't', 'i', opts);          -- (t)ype replaces (i)nsert
-- vim.keymap.set('n', 'T', 'I', opts);          -- (T)ype at bol replaces (I)nsert
-- vim.keymap.set('n', 'E', 'e', opts);          -- end of word replaces (e)nd
-- vim.keymap.set('n', 'h', 'n', opts);          -- next match replaces (n)ext
-- vim.keymap.set('n', 'k', 'N', opts);          -- previous match replaces (N) prev
-- vim.keymap.set('n', '<C-m>', 'm', opts);      -- mark replaces (m)ark
--
-- vim.keymap.set('n', '<C-n>', '<C-f>', opts);  -- Page down
-- vim.keymap.set('n', '<C-e>', '<C-b>H', opts); -- Page up, cursor up
--
-- -- Make EasyMotion match the new mnei(hjkl) motions
-- vim.keymap.set('n', '<Leader>m', '<Plug>(easymotion-linebackward)', {})
-- vim.keymap.set('n', '<Leader>n', '<Plug>(easymotion-j)', {})
-- vim.keymap.set('n', '<Leader>e', '<Plug>(easymotion-k)', {})
-- vim.keymap.set('n', '<Leader>i', '<Plug>(easymotion-lineforward)', {})
--
-- -- Fix sequences like (c)hange (i)n (w)ord
-- vim.keymap.set('n', 'ci', 'ci', opts)
-- vim.keymap.set('n', 'di', 'di', opts)
-- vim.keymap.set('n', 'vi', 'vi', opts)
-- vim.keymap.set('n', 'yi', 'yi', opts)
-- vim.keymap.set('n', 'ct', 'ct', opts)
-- vim.keymap.set('n', 'dt', 'dt', opts)
-- vim.keymap.set('n', 'vt', 'vt', opts)
-- vim.keymap.set('n', 'yt', 'yt', opts)
--
