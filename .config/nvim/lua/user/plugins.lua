-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function(use)
    -- plugins
    use 'wbthomason/packer.nvim' -- have packer manager itself
    use {'nvim-telescope/telescope.nvim', tag = '0.1.5', requires = { {'nvim-lua/plenary.nvim'} } }
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'theprimeagen/harpoon'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use 'dense-analysis/ale' -- asynchronous linting

    -- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- manage the language servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

    -- diagnostics
    -- use {
    --     'folke/trouble.nvim',
    --     config = function()
    --         require('folke/trouble.nvim').setup {
    --             icons = false,
    --             fold_open = "v", -- icon used for open folds
    --             fold_closed = ">", -- icon used for closed folds
    --             indent_lines = false, -- add an indent guide below the fold icons
    --             signs = {
    --                 error = "error",
    --                 warning = "warn",
    --                 hint = "hint",
    --                 information = "info"
    --             },
    --             use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    --         }
    --     end
    -- }

    -- comment utility
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- indent guides
    -- use {
    --     "lukas-reineke/indent-blankline.nvim",
    --     config = function()
    --         require("ibl").setup()
    --     end
    -- }
end);

