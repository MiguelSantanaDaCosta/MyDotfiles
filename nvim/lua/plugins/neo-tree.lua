return {
    "nvim-neo-tree/neo-tree.nvim",

    branch = "v3.x",

    cmd = "Neotree",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    keys = {
        {
            "<leader>e",
            function()
                require("neo-tree.command").execute({
                    toggle = true,
                    reveal = true,
                    dir = vim.uv.cwd(),
                })
            end,
            desc = "Open File Explorer",
        },
    },

    config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
            },

            window = {
                width = 25,
            },
        })
    end,
}
