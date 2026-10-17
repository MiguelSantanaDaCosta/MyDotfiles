-- lua/plugins/jdtls.lua (NOVO)
return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
        local jdtls = require("jdtls")
        local root = vim.fn.getcwd()
        local name = vim.fn.fnamemodify(root, ":t")
        local data_dir = vim.fn.stdpath("data") .. "/jdtls/" .. name

        jdtls.start_or_attach({
            cmd = { "jdtls", "-data", data_dir },
            root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
            settings = {
                java = {
                    signatureHelp = { enabled = true },
                    saveActions = { organizeImports = true },
                },
            },
        })
    end,
}
