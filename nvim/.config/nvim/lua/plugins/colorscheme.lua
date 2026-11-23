-- Install Everforest with Neovim's built-in package manager.
vim.pack.add({ "https://github.com/sainnhe/everforest" })

-- Set theme globals before loading the colorscheme so its setup can read them.
vim.g.everforest_background = "hard"
vim.g.everforest_transparent_background = 2
vim.g.everforest_enable_italic = 1
vim.g.everforest_ui_contrast = "high"
vim.g.everforest_float_style = "blend"
vim.g.everforest_pmenu_style = "blend"

-- Apply the configured theme.
vim.cmd.colorscheme("everforest")
