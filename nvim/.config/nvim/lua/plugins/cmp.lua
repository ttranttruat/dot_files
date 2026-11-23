-- Pin the stable v1 API instead of the actively changing v2 branch.
vim.pack.add({
    {
        src = "https://github.com/Saghen/blink.cmp",
        version = "v1.*",
    },
})

local blink = require("blink.cmp")
local completion_item_kind = require("blink.cmp.types").CompletionItemKind
local snippet_format = vim.lsp.protocol.InsertTextFormat.Snippet

blink.setup({
    -- Spell out Blink's default non-snippet mappings so each behavior is easy to edit.
    keymap = {
        preset = "none",

        -- Open, accept, or cancel the completion menu.
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },

        -- Move through suggestions; fall back to normal editor mappings when appropriate.
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },

        -- Scroll the completion documentation or toggle signature help.
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },

    completion = {
        -- Avoid selecting or inserting the first suggestion before the user chooses one.
        list = { selection = { preselect = false, auto_insert = false } },
        documentation = {
            -- Show the selected item's documentation after a short pause.
            auto_show = true,
            auto_show_delay_ms = 300,
            window = { border = "rounded" },
        },
        -- Preview the selected completion as ghost text in the current line.
        ghost_text = { enabled = true },
        menu = {
            border = "rounded",
            draw = {
                -- Keep the completion label and kind visible in separate columns.
                columns = {
                    { "label" },
                },
            },
        },
    },

    -- Use LSP, filesystem paths, and words from the current buffer; omit snippets.
    sources = {
        default = { "lsp", "path", "buffer" },
        transform_items = function(_, items)
            -- Remove snippet completions so the menu only offers plain-text insertions.
            return vim.tbl_filter(function(item)
                return item.kind ~= completion_item_kind.Snippet
                    and item.insertTextFormat ~= snippet_format
            end, items)
        end,
    },
})

-- Match the completion menu background to the editor and keep the theme's border color.
local function set_menu_highlights()
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Normal" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("user_blink_menu_highlights", { clear = true }),
    callback = set_menu_highlights,
})

set_menu_highlights()
