vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window management: split the current window and navigate between windows.
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Use the black-hole register so deleting with x does not overwrite yanked text.
vim.keymap.set("n", "x", '"_x', { desc = "Delete character without yanking" })

-- Tab management: create a tab and move between open tabs.
vim.keymap.set("n", "<leader>tn", "<Cmd>tabnew<CR>", { desc = "Create new tab" })
vim.keymap.set("n", "<leader>tp", "<Cmd>tabprevious<CR>", { desc = "Move to previous tab" })
vim.keymap.set("n", "<leader>tn", "<Cmd>tabnext<CR>", { desc = "Move to next tab" })

-- Select every line in the current buffer, like Ctrl+A in a GUI editor.
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Visual mode: keep the selection after indenting; reindent moved lines.
vim.keymap.set("x", ">", ">gv", { desc = "Indent selection" })
vim.keymap.set("x", "<", "<gv", { desc = "Unindent selection" })
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
