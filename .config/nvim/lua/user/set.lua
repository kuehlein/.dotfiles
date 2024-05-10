vim.opt.nu = true;
vim.opt.relativenumber = true;

vim.opt.tabstop = 4;
vim.opt.softtabstop = 4;
vim.opt.shiftwidth = 4;
vim.opt.expandtab = true;

vim.opt.smartindent = true;

vim.opt.wrap = false;

vim.opt.swapfile = false;
vim.opt.backup = false;
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir";
vim.opt.undofile = true;

-- vim.opt.hlse2arch = false; -- invalid option? causes error...
vim.opt.incsearch = true;

vim.opt.termguicolors = true;

vim.opt.scrolloff = 16;
vim.opt.signcolumn = "yes";
vim.opt.isfname:append("@-@");

vim.opt.updatetime = 50;

-- TODO: move theme related values to theme.lua

vim.opt.colorcolumn = "80,100";

vim.o.cursorline = true;

-- show white space
vim.opt.list = true;
vim.opt.listchars = {
    tab = "→ ",
    space = "·",
    nbsp = "⎵",
    precedes = "«",
    extends = "»",
};

-- linting/formatting
vim.g.ale_linters = { javascript = { "eslint" }, typescript = { "eslint" } };
vim.g.ale_fixers = { javascript = { "prettier" }, typescript = { "prettier" } };
vim.g.ale_fix_on_save = 1;

-- spell check
vim.opt.spell = true;

-- transparent background color
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

