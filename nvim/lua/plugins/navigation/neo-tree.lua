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
            desc = "Explorador de arquivos",
        },
        { "<leader>E", "<cmd>Neotree float reveal<cr>", desc = "Explorador flutuante" },
    },

    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            sort_case_insensitive = true,

            default_component_configs = {
                indent = {
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    with_expanders = true,
                },
                git_status = {
                    symbols = {
                        added = "+",
                        modified = "~",
                        deleted = "✖",
                        renamed = "➜",
                        untracked = "?",
                        ignored = "◌",
                        unstaged = "○",
                        staged = "●",
                        conflict = "!",
                    },
                },
            },

            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
            },

            window = {
                position = "left",
                width = 32,
                mappings = {
                    -- Navegação estilo Vim
                    ["h"] = "close_node", -- fecha a pasta aberta
                    ["l"] = "open", -- abre pasta/arquivo
                    ["<bs>"] = "navigate_up", -- sobe um nível (pasta anterior)
                    ["-"] = "navigate_up", -- idem
                    ["."] = "set_root", -- entra na pasta como nova raiz
                    ["H"] = "toggle_hidden",

                    -- Abrir em split
                    ["s"] = "open_vsplit",
                    ["S"] = "open_split",
                    ["P"] = { "toggle_preview", config = { use_float = true } },

                    -- Libera o <Space> para o <leader> funcionar dentro do tree
                    ["<space>"] = "none",
                },
            },
        })
    end,
}
