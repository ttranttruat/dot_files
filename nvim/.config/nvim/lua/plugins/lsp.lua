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
        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, {
                buffer = event.buf,
                desc = desc,
            })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gr", vim.lsp.buf.references, "Find references")
        map("gi", vim.lsp.buf.implementation, "Go to implementation")
        map("gy", vim.lsp.buf.type_definition, "Go to type definition")
        map("K", vim.lsp.buf.hover, "Show hover documentation")
        map("<leader>ca", vim.lsp.buf.code_action, "Show code actions")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Go to previous diagnostic")
        map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Go to next diagnostic")
        map("<leader>e", vim.diagnostic.open_float, "Show line diagnostics")
    end,
})

-- Mason installs the Lua/Python servers and Ruff, then enables each configuration.
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
