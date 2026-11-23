-- Install Fidget, which displays progress notifications sent by LSP servers.
vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })

-- Keep completed progress messages visible briefly and route vim.notify() through Fidget.
require("fidget").setup({
    progress = {
        display = {
            done_ttl = 3,
        },
    },
    notification = {
        override_vim_notify = true,
    },
})
