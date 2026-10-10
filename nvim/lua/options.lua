local opt = vim.opt

-- Setup Options Neovim --

opt.laststatus = 3
opt.showmode = false
opt.mouse = "a" -- Mouse em todos os modos (redimensionar splits, clicar)

-- Line numbers
opt.number = true -- Display line numbers
opt.numberwidth = 2 -- Set min number column width

-- Display and UI
opt.cursorline = true -- Highlight cursor line
opt.fillchars = { eob = " ", foldsep = " " } -- Hide '~' on empty buffer lines
opt.wrap = false -- Disable wrap line
opt.breakindent = true -- Linhas quebradas mantêm a indentação
opt.sidescroll = 1 -- Scroll 1-char horizontally
opt.sidescrolloff = 5 -- Keep 5-char margin
opt.signcolumn = "yes"
opt.winborder = "rounded"
opt.pumheight = 12 -- Menu de completion não ocupa a tela toda
opt.termguicolors = true

-- Set tab = 4 space
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true -- Indent sempre múltiplo do shiftwidth
opt.smartindent = true

-- Sync clipboard between OS and Neovim.
opt.clipboard = "unnamedplus"

-- Busca e navegação
opt.scrolloff = 8
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"
opt.virtualedit = "block" -- Seleção em bloco livre (Ctrl-v)
opt.jumpoptions = "view" -- Mantém a "vista" ao voltar com Ctrl-o

-- Timings
opt.updatetime = 250
opt.timeoutlen = 400

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Whitespace visível
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Folds via treesitter (abertos por padrão)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Arquivos e sessões
opt.confirm = true
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
