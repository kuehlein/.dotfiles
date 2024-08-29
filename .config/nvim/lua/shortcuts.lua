function expand_error()
    -- first call opens the error window, second jumps inside
    vim.diagnostic.open_float();
    vim.diagnostic.open_float();
end
vim.api.nvim_set_keymap("n", "<leader>e", "", { callback = expand_error, noremap = true, silent = true })

-- copy to system clipboard in visual mode
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true });


-- TODO: autocomplete brackets...
--       * auto open/close
--       * auto delete
--       * do nothing if manually closing
--       * format expanding... (hitting enter...)
--       * if opening brackets not followed by \n, normal behavior

-- TODO: what is prime's window manager? (how he navigates the file system so fast)

-- vim.api.nvim_set_keymap("i", "<CR>", "<CR>", { noremap = true, silent = true });


-- vim.api.nvim_exec([[
--     augroup js_ts_config
--         autocmd!
--         autocmd FileType javascript, typescript nnoremap <buffer> <leader>clg :lua my_func()<CR>
--     augroup END
-- ]], false);


-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "javascript", "typescript" },
--     callback = function()
--         vim.api.nvim_set_keymap("n", "", my_function, { buffer = true });
--     end,
-- });
--
--
-- -- TODO: this should go in .config/nvim/after/ftplugin/ (plugins that run after the defaults...)
--
-- local CURLY = { ["{"] = "}" };
-- local PAREN = { ["("] = ")" };
-- local SQUARE = { ["["] = "]" };
-- local ANGLE = { ["<"] = ">" };
-- local SINGLE = { ["'"] = "'" };
-- local DOUBLE = { ["\""] = "\"" };
-- local TICK = { ["`"] = "`" };
--
-- -- TODO: make this correct
-- local languages = {
--     default =    { unpack(CURLY), unpack(PAREN), unpack(SQUARE), unpack(DOUBLE) },
--     rust =       { unpack(CURLY), unpack(PAREN), unpack(SQUARE), unpack(DOUBLE), unpack(TICK), unpack(ANGLE)} },
--     javascript = { unpack(CURLY), unpack(PAREN), unpack(SQUARE), unpack(SINGLE), unpack(TICK) },
--     typescript = { unpack(CURLY), unpack(PAREN), unpack(SQUARE), unpack(SINGLE), unpack(TICK) },
--     -- lua =        { unpack(CURLY), unpack(PAREN), unpack(SQUARE), unpack(DOUBLE) },
--     -- toml =       { unpack(CURLY), unpack(PAREN), unpack(SQUARE), unpack(DOUBLE) },
--     -- json =       { unpack(CURLY), unpack(PAREN), unpack(SQUARE), unpack(DOUBLE) },
--     -- yaml =       { unpack(CURLY), unpack(PAREN), unpack(SQUARE), unpack(DOUBLE) },
-- };
--
-- local current_filetype = vim.bo.filetype;
-- local current_settings = languages[current_filetype];
--
-- function smart_brackets(bracket)
--     local row, col = unpack(vim.api.nvim_win_get_cursor(0));
--     
-- end
--
-- vim.api.nvim_set_keymap('n', '{', smart_brackets, { noremap = true, silent = true });
--
-- function configure_smart_brackets()
--     for start, end in pairs(languages) do
--         vim.api.nvim_set_keymap("n", start, smart_brackets(start), { noremap = true, silent = true });
--     end
-- end

