-- Install the server definitions, Mason package manager, and their integration.
vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
})

-- Show diagnostics inline and in the sign column; use floats for full messages.
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "●",
            [vim.diagnostic.severity.INFO] = "●",
            [vim.diagnostic.severity.HINT] = "●",
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    virtual_text = {
        spacing = 2,
        source = "if_many",
        prefix = "",
    },
    float = {
        border = "rounded",
        source = "if_many",
    },
})

-- Apply Blink's completion capabilities to every server and disable snippet support.
local capabilities = require("blink.cmp").get_lsp_capabilities({
    textDocument = {
        completion = {
            completionItem = {
                snippetSupport = false,
            },
        },
    },
})
vim.lsp.config("*", {
    capabilities = capabilities,
})

-- Create buffer-local mappings only when an LSP client attaches.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
            buffer = event.buf,
            desc = "Go to definition",
        })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
            buffer = event.buf,
            desc = "Go to declaration",
        })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, {
            buffer = event.buf,
            desc = "Find references",
        })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
            buffer = event.buf,
            desc = "Go to implementation",
        })
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, {
            buffer = event.buf,
            desc = "Go to type definition",
        })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {
            buffer = event.buf,
            desc = "Show hover documentation",
        })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
            buffer = event.buf,
            desc = "Show code actions",
        })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
            buffer = event.buf,
            desc = "Rename symbol",
        })
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, {
            buffer = event.buf,
            desc = "Go to previous diagnostic",
        })
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, {
            buffer = event.buf,
            desc = "Go to next diagnostic",
        })
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
            buffer = event.buf,
            desc = "Show line diagnostics",
        })
    end,
})

-- Mason installs the Lua/Python servers then enables each configuration.
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
