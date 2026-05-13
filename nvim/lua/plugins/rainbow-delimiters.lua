-- No arquivo do rainbow-delimiters.lua
return {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        local rb = require("rainbow-delimiters")
        require("rainbow-delimiters.setup").setup({
            strategy = {
                [''] = rb.strategy['global'],
            },
            query = {
                [''] = 'rainbow-delimiters',
            },
            -- Cores que combinam com o Fahrenheit (tons de laranja/queimado)
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterOrange',
            },
        })
    end
}