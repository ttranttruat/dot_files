if vim.loader then
	vim.loader.enable()
end

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("plugins.colorscheme")
require("plugins.oil")
require("plugins.telescope")
require("plugins.which-key")

require("plugins.treesitter")
require("plugins.fidget")
require("plugins.autopairs")
require("plugins.git")
require("plugins.snacks")
require("plugins.cmp")
require("plugins.lsp")
