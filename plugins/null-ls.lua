return function(config)
    local null_ls = require("null-ls")
    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
        null_ls.builtins.formatting.rufo,
        null_ls.builtins.diagnostics.rubocop,
        -- Lua
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.completion.luasnip,
        -- TS JS
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        -- Rust
        null_ls.builtins.formatting.rustfmt,
        -- PHP
        null_ls.builtins.diagnostics.php,
        null_ls.builtins.diagnostics.psalm,
        null_ls.builtins.formatting.pint,
    }
    -- set up null-ls's on_attach function
    config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
            vim.api.nvim_create_autocmd("BufWritePre", {
                desc = "Auto format before save",
                pattern = "<buffer>",
                callback = vim.lsp.buf.formatting_sync,
            })
        end
    end
    return config -- return final config table
end
