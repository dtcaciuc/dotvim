lspformat = require "lsp-format"
lspformat.setup {}

lspconfig = require "lspconfig"

-- require('cmp_nvim_lsp').setup()
-- 
-- cmp = require 'cmp'
-- cmp.setup {
--     sources = cmp.config.sources({
--         { name = 'nvim_lsp' },
--     })
-- }

-- local cmp = require 'cmp'
-- 
-- cmp.setup({
--     sources = cmp.config.sources({
--         { name = 'nvim_lsp' },
--     }, {
--         { name = 'buffer' },
--         { name = 'path' },
--     })
-- })
-- 
-- -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()


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
    cmd = { vim.fn.expand("~/opt/elixir-ls/language_server.sh") },
    settings = {
        elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = false
        }
    }
}

if vim.fn.executable('ruff-lsp') == 1 then
    lspconfig.ruff_lsp.setup {
        capabilities = capabilities,
        settings = {
            args = {}
        },
    }
else
-- elseif vim.fn.executable('.venv/bin/ruff-lsp') == 1 then
    lspconfig.ruff_lsp.setup {
        cmd = { ".venv/bin/ruff-lsp" },
        capabilities = capabilities,
        settings = {
            args = {}
        },
    }
end


lspconfig.terraformls.setup {}

lspconfig.clojure_lsp.setup {}

vim.keymap.set('n', '<leader>i', function()
    -- If we find a floating window, close it.
    local found_float = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative ~= '' then
            vim.api.nvim_win_close(win, true)
            found_float = true
        end
    end

    if found_float then
        return
    end

    vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
end, { desc = 'Toggle Diagnostics' })
