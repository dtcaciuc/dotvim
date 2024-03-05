lspformat = require "lsp-format"
lspformat.setup {}

lspconfig = require "lspconfig"
lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
    on_attach = lspformat.on_attach,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}

lspconfig.elixirls.setup {
    cmd = { vim.fn.expand("~/.local/opt/elixir-ls/language_server.sh") },
    settings = {
        elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = false
        }
    }
}
