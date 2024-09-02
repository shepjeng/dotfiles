
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Show cursor line only in active window
vim.api.nvim_create_autocmd({"InsertLeave", "WinEnter"}, {
    callback = function(event)
        if vim.bo[event.buf].buftype == "" then
            vim.opt_local.cursorline = true
        end
    end,
})
vim.api.nvim_create_autocmd({"InsertEnter", "WinLeave"}, {
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

