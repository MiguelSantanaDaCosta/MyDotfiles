return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",

    dependencies = {
        "nvim-lua/plenary.nvim",

        "nvim-telescope/telescope-ui-select.nvim",

        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },

        -- necessário para project.nvim
        "ahmedkhalf/project.nvim",
    },

    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                path_display = { "truncate" },
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                },
            },

            extensions = {
                ["ui-select"] = require("telescope.themes").get_dropdown({}),

                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
        telescope.load_extension("projects")

        local builtin = require("telescope.builtin")

        vim.keymap.set(
            "n",
            "<leader>ff",
            builtin.find_files,
            { desc = "Find Files" }
        )

        vim.keymap.set(
            "n",
            "<leader>fg",
            builtin.live_grep,
            { desc = "Live Grep" }
        )

        vim.keymap.set(
            "n",
            "<leader>fb",
            builtin.buffers,
            { desc = "Buffers" }
        )

        vim.keymap.set(
            "n",
            "<leader>fr",
            builtin.oldfiles,
            { desc = "Recent Files" }
        )
    end
}
