-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--     vim.fn.system({
--         "git",
--         "clone",
--         "--filter=blob:none",
--         "https://github.com/folke/lazy.nvim.git",
--         "--branch=stable", -- latest stable release
--         lazypath,
--     })
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- require("lazy").setup(plugins, opts)

-- colemak DHm remappings
require("user.colemak_dhm");

require("user.remap");
require("user.plugins");
require("user.set");
require("user.theme.theme"); -- scope this differently?
require("user.shortcuts");

