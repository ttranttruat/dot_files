-- This configuration uses the rewritten main branch and requires Neovim 0.12+.
-- Parser installation also requires curl, tar, tree-sitter-cli, and a C compiler.
local parser_languages = {
    "lua",
    "luadoc",
    "vim",
    "vimdoc",
    "query",
    "python",
    "markdown",
    "markdown_inline",
}

-- These Neovim filetypes will have Tree-sitter highlighting enabled.
local highlighted_filetypes = {
    "lua",
    "python",
    "vim",
    "help",
    "query",
    "markdown",
}

-- Keep this handler before vim.pack.add so parser queries update after install/update.
vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("treesitter_v2_pack_changed", { clear = true }),
    callback = function(event)
        local spec = event.data.spec
        local kind = event.data.kind

        if spec.name ~= "nvim-treesitter" or (kind ~= "install" and kind ~= "update") then
            return
        end

        -- The update command is provided by the plugin, so activate it if needed.
        if not event.data.active then
            vim.cmd.packadd("nvim-treesitter")
        end
        vim.cmd("TSUpdate")
    end,
})

-- Pin the rewritten API branch; it is incompatible with the legacy master branch.
vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
})

local treesitter = require("nvim-treesitter")

-- Store parsers and queries in Neovim's data directory.
treesitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

-- install() is a no-op for parsers that are already installed.
treesitter.install(parser_languages)

-- Neovim supplies the highlighter; this plugin supplies parsers and queries.
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter_v2_highlight", { clear = true }),
    pattern = highlighted_filetypes,
    callback = function(event)
        vim.treesitter.start(event.buf)

        -- Tree-sitter indentation is experimental; remove this line to use normal indent rules.
        vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})