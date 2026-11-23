-- Install the server definitions, Mason package manager, and their integration.
vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
})

-- Tell servers not to send snippet completions; Blink also filters any that remain.
local capabilities = require("blink.cmp").get_lsp_capabilities({
    textDocument = {
        completion = {
            completionItem = {
                snippetSupport = false,
            },
        },
    },
})

-- Configure the Lua server to avoid its own function and keyword snippets.
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            completion = {
                callSnippet = "Disable",
                keywordSnippet = "Disable",
            },
        },
    },
})

vim.lsp.config("pyright", {
    capabilities = capabilities,
})

-- Mason installs the Lua and Python servers and enables only these configurations.
-- Pyright may require Node.js/npm to be available for Mason's package installer.
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
    },
    automatic_enable = {
        "lua_ls",
        "pyright",
    },
})