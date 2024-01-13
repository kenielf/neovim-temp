local dracula = require("dracula")

dracula.setup({
    -- show the '~' characters after the end of buffers
    show_end_of_buffer = true, -- default false

    -- set custom lualine background color
    lualine_bg_color = "#44475a", -- default nil

    -- set italic comment
    italic_comment = true, -- default false

    -- overrides the default highlights with table see `:h synIDattr`
    overrides = {
        -- Indentation
        IndentBlanklineContextStart = { sp = dracula.colors().purple, underline = 1 },
        IndentBlanklineContextChar = { fg = dracula.colors().purple, nocombine = 1 },

        -- Notify
        NotifyBackground = { bg = dracula.colors().comment }
    },
})

-- Set the colorscheme
vim.cmd [[ colorscheme dracula]]
