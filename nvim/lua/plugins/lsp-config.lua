return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim", -- Melhora a escrita de plugins em Lua
    },
    config = function()
        require("neodev").setup()
        require("mason").setup({ ui = { border = "rounded" } })
        
        require("mason-lspconfig").setup({
            -- Adicionei jdtls (Java) e basedpyright (Python melhorado)
            ensure_installed = { "lua_ls", "clangd", "basedpyright", "ts_ls", "html", "cssls", "jdtls" },
            automatic_installation = true,
        })

        local lspconfig = require("lspconfig")
        
        -- Atalhos globais do LSP
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local opts = { buffer = event.buf, silent = true }
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            end,
        })

        -- Setup automático dos servidores (exceto JDTLS que é especial)
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                if server_name ~= "jdtls" then
                    lspconfig[server_name].setup({})
                end
            end,
        })
    end
}