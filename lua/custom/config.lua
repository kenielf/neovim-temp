--- Custom Neovim Plugin Configuration ---
-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
local plugins = {
    --- Interface ---
    -- Dracula Theme
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("custom.ui.theme.dracula")
        end,
    },

    -- Components
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("custom.ui.components.rework")
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    {
        "stevearc/dressing.nvim",
        config = function ()
            require("custom.ui.components.dressing")
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("custom.ui.components.indent-guides")
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        --lazy = false,
        config = function()
            require("custom.ui.components.file-tree")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
       "nvimdev/dashboard-nvim",
       --lazy = false,
       event = 'vimEnter',
       config = function()
           require("custom.ui.components.dashboard")
       end,
       dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    -- Informational
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("custom.ui.informational.status")
        end,
    },

    {
        "akinsho/bufferline.nvim",
        version = "*",
        config = function()
            require("custom.ui.informational.buffers")
        end,
    },

    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        config = function ()
            require("custom.ui.informational.context")
        end,
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
    },

    --- Syntax Highlighting ---
    {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            vim.cmd [[:TSUpdate]]
        end,
        config = function()
            require("custom.syntax-highlighting.treesitter")
        end,
    },

    {
        "yioneko/nvim-yati",
        version = "*",
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },

    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("custom.syntax-highlighting.search")
        end,
    },

    {
        "RRethy/vim-illuminate"
    },

    {
        --"norcalli/nvim-colorizer.lua",
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("custom.syntax-highlighting.colors")
        end,
    },

    {
        "folke/todo-comments.nvim",
        config = function()
            require("custom.syntax-highlighting.todos")
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    --- Navigation ---
    {
        "karb94/neoscroll.nvim",
        config = function ()
            require("custom.navigation.scrolling")
        end
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function ()
            require("custom.navigation.search.harpoon")
        end,
        --lazy = false,
        --priority = 600,
        dependencies = {
            {"nvim-lua/plenary.nvim"}
        }
    },

    {
        "nvim-telescope/telescope.nvim",
        config = function ()
            require("custom.navigation.search.telescope")
        end,
        --lazy = false,
        --priority = 500,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-project.nvim",
            "ThePrimeagen/harpoon",
        },
    },


    {
        "folke/flash.nvim",
        event = "VeryLazy",
        config = function()
            require("custom.navigation.search.flash")
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            require("custom.navigation.keymap-info")
        end
    },

    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("custom.navigation.terminal")
        end,
    },

    -- LSP ---
    {
        "VonHeikemen/lsp-zero.nvim",
        version = "v1.x",
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            {
                'windwp/nvim-autopairs',
                event = "InsertEnter",
            },

            -- Formatter
            { 'lukas-reineke/lsp-format.nvim' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- Specific Language Tweaks
            {
                "mfussenegger/nvim-jdtls",
                --lazy = false,
                config = function()
                    require("custom.lsp.language-tweaks.java")
                end
            },
        },
        config = function()
            require("custom.lsp.config")
        end,
    },

    {
        'folke/trouble.nvim',
        config = function()
            require('custom.lsp.trouble')
        end,
    },

    --- Motions ---
    {
        "terrortylor/nvim-comment",
        config = function ()
            require("custom.motions.comments")
        end
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("custom.motions.surround")
        end
    },

    {
        "christoomey/vim-sort-motion",
        config = function ()
            require("custom.motions.sorting")
        end
    },

    {
        "Wansmer/treesj",
    },

    --- Git ---
    {
        "NeogitOrg/neogit",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function ()
            require("custom.git.neogit")
        end
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("custom.git.signs")
        end
    },

    --- Extras ---
    -- Discord Rich Presence
    {
        "andweeb/presence.nvim",
        config = function()
            require("custom.extras.rich-presence")
        end,
        lazy = false,
    },

    -- Startup Time
    {
        "dstein64/vim-startuptime"
    },
}

-- Load and set keybinds
require("lazy").setup({ plugins })

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy's Menu." })

-- Load extra keybinds
require("custom.extras.custom-keybinds")

