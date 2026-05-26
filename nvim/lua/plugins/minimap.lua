return {
    "gorbit99/codewindow.nvim",

    cmd = {
        "MinimapToggle",
    },

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },

    config = function()
        local codewindow = require("codewindow")

        codewindow.setup({
            active_in_terminals = false,
            auto_enable = false,
            exclude_filetypes = {
                "help",
                "neo-tree",
                "alpha",
            },
        })

        vim.api.nvim_create_user_command(
            "MinimapToggle",
            function()
                codewindow.toggle_minimap()
            end,
            {}
        )
    end,

    keys = {
        {
            "<leader>mm",
            function()
                require("codewindow")
                    .toggle_minimap()
            end,
            desc = "Toggle Minimap",
        },

        {
            "<leader>mf",
            function()
                require("codewindow")
                    .toggle_focus()
            end,
            desc = "Focus Minimap",
        },
    },
}
