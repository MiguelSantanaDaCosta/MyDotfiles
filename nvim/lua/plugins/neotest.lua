return {
    "nvim-neotest/neotest",

    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",

        "nvim-neotest/neotest-python",

        "rcasia/neotest-java",

        -- necessário para Java
        "mfussenegger/nvim-jdtls",
    },

    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = {
                        justMyCode = false,
                    },
                }),

                require("neotest-java")({
                    ignore_wrapper = false,
                }),
            },
        })
    end,

    keys = {
        {
            "<leader>tr",
            function()
                require("neotest").run.run()
            end,
            desc = "Run Test",
        },

        {
            "<leader>ts",
            function()
                require("neotest").summary.toggle()
            end,
            desc = "Test Summary",
        },
    },
}
