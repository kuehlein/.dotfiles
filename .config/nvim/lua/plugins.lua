-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- TODO: https://github.com/folke/neoconf.nvim


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
            {
                'neovim/nvim-lspconfig',
                settings = {
                    ["rust-analyzer"] = {
                        procMacro = {
                            ignored = {
                                -- https://book.leptos.dev/getting_started/leptos_dx.html#2-editor-autocompletion-inside-component-and-server
                                leptos_macro = {
                                    -- "component",
                                    "server",
                                },
                            },
                        },
                    },
                },
            },

            -- autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

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

