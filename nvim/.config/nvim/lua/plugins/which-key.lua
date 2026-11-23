-- Install Which-Key, which displays available keymaps after a prefix is pressed.
vim.pack.add({ "https://github.com/folke/which-key.nvim" })

local which_key = require("which-key")

-- Use the modern popup layout and wait briefly before showing the menu.
which_key.setup({
    preset = "helix",
    delay = 200,
})

-- Name the prefixes used by window, tab, Telescope, Git, and LSP mappings.
which_key.add({
    { "<leader>s", group = "Splits and windows" },
    { "<leader>t", group = "Tabs" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>c", group = "Code actions" },
    { "<leader>r", group = "Rename" },
})
