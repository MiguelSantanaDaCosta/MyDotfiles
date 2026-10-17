-- Lâmpada quando há code action disponível
return {
	"kosayoda/nvim-lightbulb",
	event = "LspAttach",
	opts = { autocmd = { enabled = true } },
}
