return {
    "ahmedkhalf/project.nvim",

    event = "VeryLazy",

    dependencies = {
        "nvim-telescope/telescope.nvim",
    },

    config = function()
        require("project_nvim").setup({
            detection_methods = {
                "pattern",
                "lsp",
            },

            patterns = {
                ".git",
                "pom.xml",
                "package.json",
                "Cargo.toml",
                "Makefile",
            },

            silent_chdir = true,
        })

        pcall(function()
            require("telescope")
                .load_extension("projects")
        end)
    end,

    keys = {
        {
            "<leader>fp",
            "<cmd>Telescope projects<cr>",
            desc = "Find Projects",
        },
    },
}
