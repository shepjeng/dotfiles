return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "▏",
                    -- char = "⸽", -- ,⁞, ⋮, ┆, ┊, ┋, ┇, ︙,⸽,
                    -- tab_char = "▏",
                    smart_indent_cap = true,
                },
                scope = {
                    enabled = true,
                    show_start = false,
                    show_end = false,
                },
            })
        end
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = "BufReadPre",
        opts = {
            colorcolumn = {"100"},
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('lualine').setup({
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {
                        'branch', 'diff', 'diagnostics',
                        {
                            require("noice").api.statusline.mode.get,
                            cond = require("noice").api.statusline.mode.has,
                            color = { fg = "#ff9e64" },
                        },
                    },
                    lualine_c = {
                        {
                            'filename',
                            path = 3,
                        }
                    },
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
            })
        end
    },
    {
        "petertriho/nvim-scrollbar",
        event = "BufReadPre",
        config = function()
            require("scrollbar").setup({
                handle = {
                    blend = 10,
                    hide_if_all_visible = true, -- Hides everything if all lines are visible
                },
                handlers = {
                    cursor = true,
                    diagnostic = true,
                    gitsigns = false, -- Requires gitsigns
                    handle = true,
                    search = false, -- Requires hlslens
                    ale = false, -- Requires ALE
                },
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
        keys = {
            { "<LEADER>tn", mode = {"n"}, "<CMD>NoiceTelescope<CR>",  desc = "Noice" },
        },
        config = function()
            require("noice").setup({
                cmdline = {
                    enabled = true, -- enables the Noice cmdline UI
                    view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
                },
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
                views = {
                    hover = {
                        border = {
                            style = "rounded",
                        },
                        win_options = {
                            winblend = 10,
                        },
                    },
                },
                messages = {
                    view_search = false,
                },
                routes = {
                    {
                        view = "notify",
                        filter = { event = "msg_showmode" },
                    },
                },
            })
        end
    },
    {
        "levouh/tint.nvim",
        event = "VeryLazy",
        config = function()
            require("tint").setup({
                tint = -50,
            })
        end
    },
}
