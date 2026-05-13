return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "SmiteshP/nvim-navic", -- Dependência para o breadcrumb
    },

    config = function()
        local navic = require("nvim-navic")

        require("lualine").setup({
            options = {
                theme = "auto", -- Ele vai tentar puxar as cores do Fahrenheit automaticamente
                icons_enabled = true,
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                globalstatus = true, -- Mantém uma barra única mesmo com split (melhor visual)
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                
                -- C é a seção central: onde o Navic brilha
                lualine_c = {
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { "filename", path = 1 }, -- 1 mostra o caminho relativo (útil no seu TCC/Echoes)
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end,
                        color = { fg = "#e54b4b" }, -- Cor avermelhada para combinar com o Fahrenheit
                    },
                },
                
                lualine_x = { 
                    'encoding', 
                    'fileformat', 
                    'filetype' 
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        })
    end
}