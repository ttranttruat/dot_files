---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
            -- Prevent LuaLS from offering function-call or keyword snippets.
            completion = {
                callSnippet = "Disable",
                keywordSnippet = "Disable",
            },
        },
    },
}
