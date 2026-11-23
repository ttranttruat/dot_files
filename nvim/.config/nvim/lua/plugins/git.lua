-- Install Gitsigns to show Git changes and provide hunk actions in buffers.
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

local gitsigns = require("gitsigns")

gitsigns.setup({
    -- Add buffer-local Git keymaps only when Gitsigns attaches to a Git buffer.
    on_attach = function(bufnr)
        local function map(lhs, rhs, description)
            vim.keymap.set("n", lhs, rhs, {
                buffer = bufnr,
                desc = description,
            })
        end

        -- ]c and [c jump between Git hunks; retain native navigation in diff windows.
        map("]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end, "Next Git hunk")

        map("[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end, "Previous Git hunk")

        -- Stage the current hunk, preview its diff, or inspect its line blame.
        map("<leader>gs", gitsigns.stage_hunk, "Stage Git hunk")
        map("<leader>gp", gitsigns.preview_hunk, "Preview Git hunk")
        map("<leader>gb", function()
            gitsigns.blame_line({ full = true })
        end, "Show Git blame")
        map("<leader>gB", gitsigns.toggle_current_line_blame, "Toggle inline Git blame")
    end,
})
