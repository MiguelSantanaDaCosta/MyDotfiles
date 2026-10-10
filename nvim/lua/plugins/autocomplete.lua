return {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },

    opts = {
        keymap = { preset = "super-tab" },
        appearance = { nerd_font_variant = "mono" },

        completion = {
            menu = { border = "rounded" },
            ghost_text = { enabled = true },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = { border = "rounded" },
            },
        },

        signature = { enabled = true, window = { border = "rounded" } },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            per_filetype = {
                lua = { inherit_defaults = true, "lazydev" },
            },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },

    opts_extend = { "sources.default" },
}
