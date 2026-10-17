return {
	-- Diagnósticos inline mais bonitos
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 1000,
		opts = {
			preset = "modern",
			options = { multilines = { enabled = true } },
		},
	},
}
