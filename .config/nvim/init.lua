vim.g.mapleader = " ";
vim.g.maplocalleader = "\\";

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim";

-- uv
if not vim.loop.fs_stat(lazypath) then
  local out = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
  });

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {});
    vim.fn.getchar();
    os.exit(1);
  end
end

-- Add lazy to the `runtimepath`, this allows us to `require` it
vim.opt.rtp:prepend(lazypath);

require("colemak_dhm");
require("remap"); -- TBD
require("set"); -- In progress
require("shortcuts"); -- TBD
require("theme");

-- Setup lazy.nvim
require("lazy").setup({ -- "plugins");
  import = "plugins"
  -- spec = { import = "plugins" }
}, {
  change_detection = { notify = false },
});

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

