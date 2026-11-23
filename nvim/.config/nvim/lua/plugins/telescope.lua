-- Plenary provides Lua utilities required by Telescope.
vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
})

-- Use a horizontal picker with the prompt at the top for consistent navigation.
require("telescope").setup({
    defaults = {
        layout_strategy = "horizontal",
        layout_config = {
            prompt_position = "bottom",
        },
        sorting_strategy = "ascending",
    },
})

local builtin = require("telescope.builtin")

-- Find files, search file contents (requires ripgrep), list buffers, and browse help.
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search file contents" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help tags" })
