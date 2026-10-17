return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",

    keys = {
        { "<leader>uc", "<cmd>ColorizerToggle<cr>", desc = "Alternar cores no código" },
    },

    config = function()
        require("colorizer").setup({
            -- "*" = todos, "!nome" = exceto (evita pintar a interface dos plugins)
            filetypes = {
                "*",
                "!lazy",
                "!mason",
                "!neo-tree",
                "!alpha",
                "!TelescopePrompt",
                "!notify",
                "!noice",
                "!oil",
            },
            user_default_options = {
                RGB = true, -- #RGB
                RRGGBB = true, -- #RRGGBB
                RRGGBBAA = true, -- #RRGGBBAA (com transparência)
                AARRGGBB = false,
                rgb_fn = true, -- rgb() e rgba()
                hsl_fn = true, -- hsl() e hsla()
                css = true, -- liga todos os formatos CSS
                css_fn = true,
                tailwind = true, -- bg-red-500, text-sky-400...
                names = false, -- não pinta "red", "blue" em texto comum

                -- Quadradinho colorido no fim da cor, sem pintar o texto todo
                mode = "virtualtext",
                virtualtext = "■",
                virtualtext_inline = true,

                always_update = true, -- atualiza ao editar, sem precisar salvar
            },
        })
    end,
}
