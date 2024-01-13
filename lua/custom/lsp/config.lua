local lsp_zero = require("lsp-zero").preset({
    name = 'recommended',
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = true,
})

local navic = require("nvim-navic")

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr }
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps(opts)

    -- Custom keybindings
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)

    -- Navic
    if vim.b.lsp_attached then return end
    vim.b.lsp_attached = true

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    -- Formatter
    if client.supports_method('textDocument/formatting') then
        require("lsp-format").on_attach(client)
    end
end)

local servers = {
    "dockerls", "docker_compose_language_service",
    "tsserver", "html", "cssls", "cssmodules_ls", "jsonls",
    "gopls",
    "texlab",
    "marksman",
    "jsonls",
    "lua_ls",
    "bashls",
    --"pylsp",
    "pyright",
    "rust_analyzer",
    "clangd",
    "jdtls",
    "texlab",
}

local tools = {
    "black", "isort", "flake8"
}

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = servers,
    handlers = {
        lsp_zero.default_setup,
        jdtls = lsp_zero.noop,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

lsp_zero.setup()

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = lsp_zero.cmp_format()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }),
})
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

require("mason-tool-installer").setup({
    ensure_installed = tools,
    auto_update = true,
})
