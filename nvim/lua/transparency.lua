-- Deixa um tema transparente em terminais translúcidos (wallpaper atrás do Neovim).
-- Limpa só o FUNDO dos grupos; as cores de texto do tema continuam.
local M = {}

-- Grupos que ficam sem fundo
M.clear = {
	"Normal",
	"NormalNC",
	"NormalFloat",
	"FloatBorder",
	"FloatTitle",
	"FloatFooter",
	"SignColumn",
	"LineNr",
	"LineNrAbove",
	"LineNrBelow",
	"CursorLineNr",
	"CursorLineSign",
	"FoldColumn",
	"EndOfBuffer",
	"MsgArea",
	"MsgSeparator",
	"WinSeparator",
	"VertSplit",
	"WinBar",
	"WinBarNC",
	"TabLine",
	"TabLineFill",
	-- neo-tree
	"NeoTreeNormal",
	"NeoTreeNormalNC",
	"NeoTreeEndOfBuffer",
	"NeoTreeWinSeparator",
	"NeoTreeFloatNormal",
	"NeoTreeFloatBorder",
	"NeoTreeFloatTitle",
	-- telescope
	"TelescopeNormal",
	"TelescopeBorder",
	"TelescopePromptNormal",
	"TelescopePromptBorder",
	"TelescopeResultsNormal",
	"TelescopeResultsBorder",
	"TelescopePreviewNormal",
	"TelescopePreviewBorder",
	-- bufferline, which-key, trouble, edgy, lazy, mason
	"BufferLineFill",
	"BufferLineBackground",
	"WhichKeyNormal",
	"WhichKeyBorder",
	"TroubleNormal",
	"TroubleNormalNC",
	"EdgyNormal",
	"LazyNormal",
	"MasonNormal",
}

-- Menus de completar: ficam SÓLIDOS (legibilidade sobre o wallpaper) quando opts.menu_bg é dado
M.menus = {
	"Pmenu",
	"PmenuSbar",
	"PmenuExtra",
	"BlinkCmpMenu",
	"BlinkCmpMenuBorder",
	"BlinkCmpDoc",
	"BlinkCmpDocBorder",
	"BlinkCmpDocSeparator",
	"BlinkCmpSignatureHelp",
	"BlinkCmpSignatureHelpBorder",
}

local function set_bg(group, bg)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
	if not ok then
		return
	end
	hl = hl or {}
	hl.bg = bg
	hl.ctermbg = (bg == "NONE") and "NONE" or nil
	pcall(vim.api.nvim_set_hl, 0, group, hl)
end

--- opts.menu_bg    hex  -> fundo sólido para os menus (nil = deixa como o tema definiu)
--- opts.float_bg   hex  -> fundo sólido para janelas flutuantes (nil = transparentes)
--- opts.clear_extra     -> lista de grupos extras para ficar sem fundo
function M.apply(opts)
	opts = opts or {}
	for _, g in ipairs(M.clear) do
		set_bg(g, "NONE")
	end
	for _, g in ipairs(opts.clear_extra or {}) do
		set_bg(g, "NONE")
	end
	if opts.float_bg then
		for _, g in ipairs({ "NormalFloat", "FloatBorder", "FloatTitle" }) do
			set_bg(g, opts.float_bg)
		end
	end
	if opts.menu_bg then
		for _, g in ipairs(M.menus) do
			set_bg(g, opts.menu_bg)
		end
	end
end

--- Reaplica a transparência sempre que um dos temas de `pattern` for carregado.
--- is_enabled (opcional): função que diz se a transparência está ligada agora.
function M.attach(name, pattern, opts, is_enabled)
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("ThemeTransparency_" .. name, { clear = true }),
		pattern = pattern,
		callback = function()
			if is_enabled and not is_enabled() then
				return
			end
			-- schedule: roda depois dos outros plugins (bufferline etc.) reaplicarem seus highlights
			vim.schedule(function()
				M.apply(opts)
			end)
		end,
	})
end

return M
