-- Install Snacks, a collection of small Neovim UI utilities.
vim.pack.add({ "https://github.com/folke/snacks.nvim" })

-- Enable only indent guides and the custom status column.
require("snacks").setup({
    indent = {
        enabled = true,
        char = "│",
        scope = {
            enabled = true,
        },
    },

    -- Keep signs and marks on the left, with folds and Git changes on the right.
    statuscolumn = {
        enabled = true,
        left = { "mark", "sign" },
        right = { "fold", "git" },
    },
})
