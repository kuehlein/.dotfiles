vim.opt.nu = true
vim.opt.relativenumber = true

-- use 4 spaces for indents (overridden based on filetype in `after/ftplugin/`)
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- dont use this with filetype based indentation apparently? TBD on how to use this...
vim.opt.smartindent = true

vim.opt.wrap = false

-- prevent comment continuation
vim.opt_local.formatoptions:remove({ "r", "o" })

-- disables swapfiles/backup files
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.dotfiles/.config/nvim/.undodir"

-- SEARCH
vim.opt.incsearch = true -- enable incremental search
vim.opt.smartcase = true -- ignores case during search unless uppercase

-- scroll padding
vim.opt.scrolloff = 8

-- column to the left of line numbers with error indication
vim.opt.signcolumn = "yes"

-- enable "@" character in filenames - https://vi.stackexchange.com/questions/22423/in-file-names-and-gf-go-to-file
vim.opt.isfname:append("@-@")

-- time in milliseconds to wait before `CursorHold`
vim.opt.updatetime = 500

-- column markers
vim.opt.colorcolumn = "80,100"

-- highlight the line the cursor is currently on
vim.o.cursorline = true

-- netrw
vim.g.netrw_banner = 0

-- -- linting/formatting
-- vim.g.ale_linters = { javascript = { "eslint" }, typescript = { "eslint" } };
-- vim.g.ale_fixers = { javascript = { "prettier" }, typescript = { "prettier" } };
-- vim.g.ale_fix_on_save = 1;

-- spell check
vim.opt.spell = true
