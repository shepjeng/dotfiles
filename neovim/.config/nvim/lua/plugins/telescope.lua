return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            local telescope = require("telescope.builtin")
            local which_key = require("which-key")

            which_key.register({ ["<leader>t"] = { name = "+Telescope" } })
            which_key.register({ ["<leader>g"] = { name = "+Git/GPT" } })

            vim.keymap.set("n", "<leader>ts", telescope.find_files,  { desc = "Search files" })
            vim.keymap.set("n", "<leader>tg", telescope.live_grep,   { desc = "Live grep" })
            vim.keymap.set("n", "<leader>tG", telescope.grep_string, { desc = "Grep current string" })
            vim.keymap.set("n", "<leader>tb", telescope.buffers,     { desc = "Buffers" })
            vim.keymap.set("n", "<leader>th", telescope.help_tags,   { desc = "Help tags" })
            vim.keymap.set("n", "<leader>tk", telescope.keymaps,     { desc = "Show keymaps" })
            vim.keymap.set("n", "<leader>tm", "<cmd>Telescope man_pages<cr>", { desc = "Man pages" })
            vim.keymap.set("n", "<leader>tf", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "File browser" })
            vim.keymap.set("n", "<leader>tF", "<cmd>Telescope file_browser<cr>", { desc = "File browser" })
            vim.keymap.set("n", "<leader>tj", "<cmd>Telescope jumplist<cr>", { desc = "Jump list" })

            vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
            vim.keymap.set("n", "<leader>gB", "<cmd>Telescope git_bcommits<cr>", { desc = "Git commits of current buffer" })

            require("telescope").setup({
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            height = 0.9,
                            width = 0.95,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        theme = "ivy",
                        winblend = 10,
                    },
                    live_grep = {
                        theme = "ivy",
                        winblend = 10,
                    },
                    grep_string = {
                        theme = "ivy",
                        winblend = 10,
                    },
                    buffers = {
                        theme = "ivy",
                        winblend = 10,
                    },
                    help_tags = {
                        theme = "ivy",
                        winblend = 10,
                    },
                    git_status = {
                        theme = "ivy",
                        winblend = 10,
                    },
                    git_bcommits = {
                        theme = "ivy",
                        winblend = 10,
                    },
                    man_pages = {
                        theme = "ivy",
                        winblend = 10,
                    },
                    jumplist = {
                        theme = "ivy",
                        winblend = 10,
                    },
                    lsp_references = {
                        theme = "ivy",
                        winblend = 10,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            })

            require('telescope').load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        event = "VeryLazy",
        build = "make"
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            winblend = 10,
                        })
                    }
                }
            })

            require("telescope").load_extension("ui-select")
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    file_browser = {
                        theme = "ivy",
                        winblend = 10,
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                    },
                },
            })

            require("telescope").load_extension("file_browser")
        end
    }
}
