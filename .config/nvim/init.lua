vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- TODO: it would be nice to put the lazy stuff in its own file...

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- uv
if not vim.loop.fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

-- Add lazy to the `runtimepath`, this allows us to `require` it
vim.opt.rtp:prepend(lazypath)

require("colemak_dhm")
require("remap") -- TBD
require("set") -- In progress
require("shortcuts") -- TBD
require("theme")

-- TODO: is there a better place to put this??
vim.filetype.add({
	extension = {
		jsx = "javascriptreact",
		tsx = "typescriptreact",
		-- jsx = "javascript",
		-- tsx = "typescript",
	},
})

-- Setup lazy.nvim
require("lazy").setup({ import = "plugins" }, { change_detection = { notify = false } })

-- make it trans
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Comment", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Constant", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Special", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Identifier", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Statement", { bg = "none" })
-- vim.api.nvim_set_hl(0, "PreProc", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Type", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Underlined", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Todo", { bg = "none" })
-- vim.api.nvim_set_hl(0, "String", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Function", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Conditional", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Repeat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Operator", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Structure", { bg = "none" })
-- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
-- vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- automatically check for plugin updates
-- checker = { enabled = true },

-- import = {
--   -- 'wbthomason/packer.nvim' -- have packer manager itself
--   "nvim-telescope/telescope.nvim", -- {'nvim-telescope/telescope.nvim', tag = '0.1.5', requires = { {'nvim-lua/plenary.nvim'} } }
--   "nvim-treesitter/nvim-treesitter", -- {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
--   "nvim-treesitter/playground",
--   "theprimeagen/harpoon",
--   "mbbill/undotree",
--   "tpope/vim-fugitive",
--   -- "dense-analysis/ale" -- asynchronous linting
--
--   -- lsp
--   -- use {
--   --     'VonHeikemen/lsp-zero.nvim',
--   --     branch = 'v3.x',
--   --     requires = {
--   --         --- manage the language servers from neovim
--   --         {'williamboman/mason.nvim'},
--   --         {'williamboman/mason-lspconfig.nvim'},
--   --
--   --         -- LSP Support
--   --         {'neovim/nvim-lspconfig'},
--   --
--   --         -- autocompletion
--   --         {'hrsh7th/nvim-cmp'},
--   --         {'hrsh7th/cmp-nvim-lsp'},
--   --         {'L3MON4D3/LuaSnip'},
--   --     }
--   -- }
--
--   -- comment utility
--   -- use {
--   --     'numToStr/Comment.nvim',
--   --     config = function()
--   --         require('Comment').setup()
--   --     end
--   -- }
-- },
-- });
