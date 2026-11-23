-- Install the statusline plugin without optional icon dependencies.
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

-- Use the active colorscheme's Lualine palette, moving each mode accent to its text.
local theme = require("lualine.themes.auto")
for mode, sections in pairs(theme) do
    if type(sections) == "table" then
        for section_name, colors in pairs(sections) do
            if type(colors) == "table" then
                if section_name == "a" and mode ~= "inactive" then
                    colors.fg = colors.bg
                end
                colors.bg = "NONE"
            end
        end
    end
end

-- Edit these labels to choose how each Lualine mode is abbreviated.
local mode_labels = {
    NORMAL = "Nor",
    ["O-PENDING"] = "O-P",
    VISUAL = "Vis",
    ["V-LINE"] = "V-L",
    ["V-BLOCK"] = "V-B",
    SELECT = "Sel",
    ["S-LINE"] = "S-L",
    ["S-BLOCK"] = "S-B",
    INSERT = "Ins",
    REPLACE = "Rep",
    ["V-REPLACE"] = "V-R",
    COMMAND = "Cmd",
    EX = "Ex",
    MORE = "Mor",
    CONFIRM = "Cfm",
    SHELL = "Sh",
    TERMINAL = "Ter",
}

local function shorten_mode(mode)
    return mode_labels[mode] or (mode:sub(1, 1) .. mode:sub(2, 3):lower())
end

require("lualine").setup({
    options = {
        -- Keep the active colorscheme's mode colors while making every section transparent.
        theme = theme,
        globalstatus = true,
        icons_enabled = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },

    -- Keep only the requested statusline components and let Lualine fill the middle gap.
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = shorten_mode,
            },
        },
        lualine_b = {
            {
                "filename",
                path = 0,
                symbols = {
                    modified = " [+]",
                    readonly = " [RO]",
                },
            },
        },
        lualine_c = {
            {
                "branch",
            },
            {
                "diff",
                symbols = {
                    added = "+",
                    modified = "~",
                    removed = "-",
                },
            },
        },
        lualine_x = {
            {
                "diagnostics",
                sections = { "warn", "error", "info" },
                symbols = {
                    warn = "● ",
                    error = "● ",
                    info = "● ",
                },
            },
        },
        lualine_y = { "lsp_status" },
        lualine_z = { "location" },
    },
})
