-- lua/plugins/formatting.lua
return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = { "stylua", "clang-format", "black", "prettier" },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    c = { "clang_format" },      -- nome do formatter interno
                    cpp = { "clang_format" },
                    python = { "black" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    html = { "prettier" },
                    css = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                },
                format_on_save = {
                    timeout_ms = 1000,
                    lsp_format = "fallback",
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>gf", function()
                conform.format({ async = true, lsp_format = "fallback" })
            end, { desc = "Format Code" })
        end,
    },
}
