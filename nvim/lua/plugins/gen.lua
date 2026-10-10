return {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "qwen-coder", -- O nome que demos ao seu modelo no Ollama
      display_mode = "split", -- Como a resposta aparece (pode ser "float" ou "split")
      show_prompt = false,
      show_model = true,
      no_auto_close = true,
      init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
      command = function(options)
        return "curl --silent --no-buffer -X POST http://localhost:11434/api/chat -d $body"
      end,
    },
  },
}
