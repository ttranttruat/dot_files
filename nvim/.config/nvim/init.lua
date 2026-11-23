if vim.loader then
	vim.loader.enable()
end

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load the colorscheme before UI plugins that derive their palette from it.
require("plugins.colorscheme")

-- Set up language and editing support; autopairs uses Tree-sitter parser data,
-- and the LSP configuration reads completion capabilities from Blink.
require("plugins.treesitter")
require("plugins.autopairs")
require("plugins.cmp")
require("plugins.lsp")
require("plugins.git")

-- Load tools and UI after their keymaps and visual dependencies are available.
require("plugins.oil")
require("plugins.telescope")
require("plugins.snacks")
require("plugins.which-key")

-- Lualine's "auto" theme reads the active colorscheme.
require("plugins.lualine")
