-- Pin the stable v1 API instead of the actively changing v2 branch.
vim.pack.add({
    {
        src = "https://github.com/Saghen/blink.cmp",
        version = "v1.10.2",
    },
})

local blink = require("blink.cmp")
local completion_item_kind = require("blink.cmp.types").CompletionItemKind
local snippet_format = vim.lsp.protocol.InsertTextFormat.Snippet

blink.setup({
    -- Keep Blink's familiar built-in completion key bindings.
    keymap = {
        preset = "default",
    },

    -- Use LSP, filesystem paths, and words from the current buffer; omit snippets.
    sources = {
        default = { "lsp", "path", "buffer" },
        transform_items = function(_, items)
            -- Filter snippet-kind items and LSP items that use snippet formatting.
            return vim.tbl_filter(function(item)
                return item.kind ~= completion_item_kind.Snippet
                    and item.insertTextFormat ~= snippet_format
            end, items)
        end,
    },
})