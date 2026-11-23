-- Line numbers, cursor line, wrapping, and scroll margins
-- Show the absolute number on the cursor line and relative numbers elsewhere.
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Indentation and tab behavior
-- Use four columns for tab stops, automatic indentation, and Insert-mode tabs.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search case behavior
-- Ignore case unless the search pattern contains an uppercase character.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI, completion, and status-line appearance
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.matchtime = 2
vim.opt.cmdheight = 1

-- Show the completion menu without selecting or inserting an item automatically.
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.winborder = "rounded"
vim.opt.laststatus = 3

-- Backup and swap-file behavior
-- Disable write-backup files and swap files, including swap-based crash recovery.
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Word boundaries, file lookup, mouse, and clipboard
-- Include hyphens in words; '**' makes file lookup through 'path' recursive.
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.mouse = "a"
-- Use the system clipboard for unnamed-register operations when a provider is available.
vim.opt.clipboard:append("unnamedplus")


-- Default placement for new splits
-- Open horizontal splits below and vertical splits to the right.
vim.opt.splitbelow = true
vim.opt.splitright = true
