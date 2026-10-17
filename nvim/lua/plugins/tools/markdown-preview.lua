-- No seu arquivo markdown-preview.lua
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end, -- Forma mais segura de build
}