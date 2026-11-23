-- Install automatic bracket and quote pairing for Insert mode.
vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })

-- Keep the plugin's standard pair rules and explicitly enable Enter/Backspace support.
require("nvim-autopairs").setup({
    check_ts = true,
    map_cr = true,
    map_bs = true,
    disable_filetype = { "oil" }
})
