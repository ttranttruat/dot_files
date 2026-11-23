-- Install Gitsigns to show Git changes and provide hunk actions in buffers.
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

local gitsigns = require("gitsigns")

gitsigns.setup({
    -- Add buffer-local Git keymaps only when Gitsigns attaches to a Git buffer.
    on_attach = function(bufnr)
        -- ]c and [c jump between Git hunks; retain native navigation in diff windows.
        vim.keymap.set("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end, {
            buffer = bufnr,
            desc = "Next Git hunk",
        })

        vim.keymap.set("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end, {
            buffer = bufnr,
            desc = "Previous Git hunk",
        })

        -- Stage the current hunk, preview its diff, or inspect its line blame.
        vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, {
            buffer = bufnr,
            desc = "Stage Git hunk",
        })
        vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, {
            buffer = bufnr,
            desc = "Preview Git hunk",
        })
        vim.keymap.set("n", "<leader>gb", function()
            gitsigns.blame_line({ full = true })
        end, {
            buffer = bufnr,
            desc = "Show Git blame",
        })
        vim.keymap.set("n", "<leader>gB", gitsigns.toggle_current_line_blame, {
            buffer = bufnr,
            desc = "Toggle inline Git blame",
        })
    end,
})
