local function create_option(key, icon, description, action)
    local options = {
        icon = icon,
        icon_hl = "file",
        desc = description,
        desc_hl = "group",
        key = key,
        key_hl = "group",
        key_format = " [%s]",
        action = action,
    }
    return options
end

require("dashboard").setup({
    theme = "doom",
    config = {
        header = {
            "╔════════════════════════════════════════════╗",
            "║    ▗▄  ▄▖             ▗▄         ▗▄  ▗▄▄▖  ║",
            "║    ▐█  █▌             ▝▀         ▐█  █▛▀▘  ║",
            "║    ▐█  █▌▗▄▄▄▄▄▄▄ ▄▄▄▖▗▄ ▄▄▄▄▄▄▄▖▐█  █▙▄▖  ║",
            "║    ▐█▄█▙▖▐█▀▀▀▀▜█ ▀▀▜▌▐█ █▛▀▀▀▀█▌▐█  ▀▀▀▘  ║",
            "║        █▌▐███████ █▌▐▌▐█ ███████▌▐█  █▌    ║",
            "║    ▐█  █▌         █▌▐▌▐█         ▐█  █▌    ║",
            "║    ▐█  █▌▐███████ █▌▐▌▐█ ███████▌▐█  █▌    ║",
            "║    ▐█  █▌         █▌▐▌▐█         ▐█  █▌    ║",
            "║    ▐█  █▌▐███████ █▌▐▌▐█ ███████▌▐█        ║",
            "║  ▗▄▄▄  █▌▐█▄▄▄▄▟█ █▌▐▙▄▄ █▙▄▄▄▄█▌▝▜█▀█▌    ║",
            "║  ▝▀▜█  █▌▝▀▀▀▀▀▀▀ ▀▘▝▀▀▀ ▀▀▀▀▀▀▀▘▐█  █▌    ║",
            "║  ▗▄▟█  █▌         ▄▖             ▐█  █▌    ║",
            "║  ▝▀▀▘  ▀▘         ▀▘             ▝▀  ▀▘    ║",
            "╚════════════════════════════════════════════╝"
        },
        center = {
            create_option("f", "󰱼 ", "Find File", "Telescope find_files"),
            create_option("n", " ", "New File", "ene!"),
            create_option("p", " ", "Projects", "Telescope project"),
            create_option("r", " ", "Recent Files", "Telescope oldfiles"),
            create_option("t", "󱎸 ", "Find Text", "Telescope live_grep"),
            create_option("c", " ", "Configuration",
                "cd ~/.config/nvim | e! init.lua | lua require('nvim-tree.api').tree.toggle({ focus = false })"),
            create_option("q", " ", "Quit", "quit"),
            create_option("?", "󰋖 ", "Help", "WhichKey"),
        }
    },
    disable_move = true,
    shortcut_type = "letter",
    hide = {
        statusline = true,
        tabline = true,
        winbar = true
    },
})
