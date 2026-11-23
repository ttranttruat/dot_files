-- Install Oil, the file manager that presents directories as editable buffers.
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("oil").setup({
    -- Skip prompts for edits Oil can safely apply as a simple filesystem operation.
    skip_confirm_for_simple_edits = true,

    view_options = {
        -- Show dotfiles, but keep the parent entry and Git metadata out of the listing.
        show_hidden = true,
        is_always_hidden = function(name)
            return name == ".." or name == ".git"
        end,
    },

    -- Enter opens the selected entry, Backspace navigates to its parent, and Escape closes Oil.
    keymaps = {
        ["<CR>"] = "actions.select",
        ["<BS>"] = "actions.parent",
        ["<Esc>"] = "actions.close",
    },

    -- Limit the floating window to a fraction of the editor and use a rounded border.
    float = {
        max_width = 0.3,
        max_height = 0.7,
        border = "rounded",
    },
})

-- Open Oil in a floating window with a double backslash.
vim.keymap.set("n", "\\\\", function()
    require("oil").toggle_float()
end)
