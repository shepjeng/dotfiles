return {
    {
        "williamboman/mason.nvim",
        event = "BufReadPre",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "BufReadPre",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "rust_analyzer",
                    "ruby_lsp",
                    "bashls",
                    "autotools_ls",
                    "lua_ls",
                    "typos_lsp",
                    "gitlab_ci_ls",
                    "dotls",
                    "marksman", -- markdown
                    "yamlls",
                    "jsonls",
                    "taplo", -- toml
                    "dockerls",
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "p00f/clangd_extensions.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")

            -- nvim-cmp supports additional completion capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            local handlers = {
                -- none, single, double, rounded, shadow 
                ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
                ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
            }

            -- :help lspconfig-server-configurations
            local servers = {
                clangd = {
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(
                            "Makefile",
                            "configure.ac",
                            "configure.in",
                            "config.h.in",
                            ".clangd",
                            ".clang-tidy",
                            ".clang-format",
                            "compile_commands.json"
                        )(fname) or require("lspconfig.util").find_git_ancestor(fname)
                    end,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                        "--offset-encoding=utf-16",
                    },
                },
                rust_analyzer = {
                    -- on_attach = function(client, bufnr)
                    --     vim.lsp.inlay_hint.enable(bufnr)
                    -- end,
                    settings = {
                        ["rust-analyzer"] = {
                            imports = {
                                granularity = {
                                    group = "module",
                                },
                                prefix = "self",
                            },
                            cargo = {
                                buildScripts = {
                                    enable = true,
                                },
                            },
                            procMacro = {
                                enable = true,
                            },
                            check = {
                                command = "clippy",
                                features = "all",
                            },
                            diagnostics = {
                                enable = true,
                            }
                        },
                    }
                },
                ruby_lsp = {},
                bashls = {},
                autotools_ls = {},
                lua_ls = {},
                typos_lsp = {},
                gitlab_ci_ls = {},
                dotls = {},
                marksman = {},
                yamlls = {},
                jsonls = {},
                taplo = {},
                dockerls = {},
            }

            -- Iterate over our servers and set them up
            for name, config in pairs(servers) do
                lspconfig[name].setup({
                    capabilities = default_capabilities,
                    filetypes = config.filetypes,
                    settings = config.settings,
                    handlers = handlers,
                })
            end

            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                pattern = ".gitlab*",
                callback = function()
                    vim.bo.filetype = "yaml.gitlab"
                end,
            })

            vim.api.nvim_create_user_command("ToggleDiagnostics", function()
                if vim.g.diagnostics_enabled == nil then
                    vim.g.diagnostics_enabled = false
                    vim.diagnostic.disable()
                elseif vim.g.diagnostics_enabled then
                    vim.g.diagnostics_enabled = false
                    vim.diagnostic.disable()
                else
                    vim.g.diagnostics_enabled = true
                    vim.diagnostic.enable()
                end
            end, {})

            require("which-key").add({
                { "<leader>e", group = "Diagnostic" },
                { "<leader>l", group = "LSP" },
            })

            vim.keymap.set("n", "[e",          vim.diagnostic.goto_prev,            { desc = "Prev diagnostic" })
            vim.keymap.set("n", "]e",          vim.diagnostic.goto_next,            { desc = "Next diagnostic" })
            vim.keymap.set("n", "<leader>s",   vim.lsp.buf.hover,                   { desc = "Hover" })
            vim.keymap.set("n", "<leader>lD",  vim.lsp.buf.declaration,             { desc = "Declaration" })
            vim.keymap.set("n", "<leader>lf",  vim.lsp.buf.format,                  { desc = "Format" })
            vim.keymap.set("n", "<leader>la",  vim.lsp.buf.code_action,             { desc = "Code action" })
            vim.keymap.set("n", "<leader>ls",  vim.lsp.buf.signature_help,          { desc = "Signature" })
            vim.keymap.set("n", "<leader>lR",  vim.lsp.buf.rename,                  { desc = "Rename" })
            vim.keymap.set("n", "<leader>les", vim.diagnostic.open_float,           { desc = "Show diagnostic" })
            vim.keymap.set("n", "<leader>lel", vim.diagnostic.setloclist,           { desc = "Diagnostic List" })
            vim.keymap.set("n", "<leader>lee", "<cmd>ToggleDiagnostics<cr>",        { desc = "Toggle diagnostic" })
            vim.keymap.set("n", "<leader>lr",  "<cmd>Telescope lsp_references<cr>", { desc = "References" })
            vim.keymap.set("n", "<leader>lh",  "<cmd>ClangdToggleInlayHints<cr>",   { desc = "Toggle inlay hints" })
            vim.keymap.set("n", "<leader>lS",  "<cmd>LspStop<cr>",                  { desc = "Stop LSP" })
            vim.keymap.set("n", "<leader>lI",  "<cmd>LspInfo<cr>",                  { desc = "LSP Info" })
            vim.keymap.set("n", "<leader>ld", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "Definition" })
            -- vim.keymap.set("n", "<leader>lt", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { desc = "Type definition" })
            -- vim.keymap.set("n", "<leader>li", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { desc = "Implementation" })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = {
            "InsertEnter",
            "CmdlineEnter"
        },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-cmdline",
            -- "hrsh7th/vim-vsnip",  -- remove it after neovim 0.10
            -- "hrsh7th/cmp-vsnip",  -- remove it after neovim 0.10
        },
        config = function()
            local cmp = require("cmp")
            local select_opts = { behavior = cmp.SelectBehavior.Select }

            -- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

            cmp.setup({
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                    completion = {
                        winblend = 10,
                    },
                    documentation = {
                        winblend = 10,
                    },
                },
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)  -- Use native snippets. Only works on Neovim >= 0.10!
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                        -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                formatting = {
                    fields = {"menu", "abbr", "kind"},
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = "λ",
                            buffer = "Ω",
                            path = "🖫",
                            vsnip = "⋗",
                        }

                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping({
                        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }),
                    ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
                    ["<Down>"] = cmp.mapping.select_next_item(select_opts),
                    ["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
                    ["<C-j>"] = cmp.mapping.select_next_item(select_opts),
                    ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
                    ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                sources = cmp.config.sources({
                        { name = "nvim_lsp", max_item_count = 10 },
                        { name = "buffer",   max_item_count = 10, keyword_length = 2 },
                        { name = "path",     max_item_count = 10, keyword_length = 3 },
                        { name = "calc",     max_item_count = 10, keyword_length = 2 },
                        -- { name = "vsnip",    max_item_count = 10, keyword_length = 2 },
                }),
                -- experimental = {
                --     ghost_text = {
                --         hl_group = "CmpGhostText",
                --     },
                -- },
                -- sorting = require("cmp.config.default")().sorting,
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                },
                completion = {
                    autocomplete = false,
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" }
                }),
                completion = {
                    autocomplete = false,
                },
            })
        end
    },
    {
        "DNLHC/glance.nvim",
        event = "BufReadPre",
        config = function()
            local glance = require('glance')
            local actions = glance.actions

            require("glance").setup({
                mappings = {
                    list = {
                        ['<c-e>'] = actions.preview_scroll_win(-1),
                        ['<c-y>'] = actions.preview_scroll_win(1),
                    },
                },
            })

            vim.keymap.set("n", "<leader>d", "<cmd>Glance definitions<cr>", { desc = "Definition" })
            vim.keymap.set("n", "<leader>r", "<cmd>Glance references<cr>", { desc = "References" })
            vim.keymap.set("n", "<leader>lt", "<cmd>Glance type_definitions<cr>", { desc = "Type Definition" })
            vim.keymap.set("n", "<leader>li", "<cmd>Glance implementations<cr>", { desc = "Implementation" })
        end
    },
}
