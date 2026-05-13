return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup({})
        require('telescope').load_extension('projects')
    end,
    keys = {
        { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Projects" },
    }
}