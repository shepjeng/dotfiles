return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        config = function()
            require("ibl").setup({})
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('lualine').setup()
        end
    },
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            require("scrollbar").setup({
                hide_if_all_visible = true, -- Hides everything if all lines are visible
                handlers = {
                    cursor = true,
                    diagnostic = true,
                    gitsigns = true, -- Requires gitsigns
                    handle = true,
                    search = false, -- Requires hlslens
                    ale = false, -- Requires ALE
                },
            })
        end
    },
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = function()
            require('mini.notify').setup({
            })

            require('mini.comment').setup({
            })
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
            })
        end
    },
}