# Plugins por funcionalidade

> Gerado por `organizar-plugins.sh` em 17/10/2026.

Cada pasta é carregada no `init.lua` com `{ import = "plugins.<pasta>" }` e tem um `README.md` com a função de cada plugin, o que ele impacta, a configuração atual e exemplos de uso.

| Pasta | O que agrega | Plugins | Arquivos |
|---|---|---|---|
| [`themes/`](themes/README.md) | Esquemas de cores (temas) | 12 | 7 |
| [`ui/`](ui/README.md) | Aparência: dashboard, statusline, bufferline, notificações, scroll, guia de atalhos | 16 | 16 |
| [`navigation/`](navigation/README.md) | Busca e navegação: arquivos, buffers, projetos, símbolos, saltos, TODOs, sessões | 12 | 12 |
| [`editor/`](editor/README.md) | Edição de texto: pares, cursores múltiplos, undo, yank, folds, mini.nvim | 11 | 11 |
| [`treesitter/`](treesitter/README.md) | Treesitter: parser, textobjects, contexto, autotag | 4 | 4 |
| [`lsp/`](lsp/README.md) | LSP: servidores, mason, diagnósticos, rename, breadcrumbs, Java | 9 | 9 |
| [`coding/`](coding/README.md) | Escrever código: completar, formatar, lint, refatorar, documentar | 6 | 5 |
| [`run-debug/`](run-debug/README.md) | Executar, depurar e testar: dap, neotest, overseer, REST, banco de dados | 7 | 7 |
| [`git/`](git/README.md) | Git: sinais, diff, conflitos, GitHub | 4 | 4 |
| [`tools/`](tools/README.md) | Ferramentas: terminal, markdown, startuptime, package.json | 5 | 5 |

## Adicionando um plugin novo

1. Crie `lua/plugins/<pasta>/nome.lua` na pasta que combina com a função do plugin.
2. O arquivo retorna o spec do lazy.nvim: `return { "dono/repo", opts = {} }`.
3. Rode `:Lazy sync`. Para regenerar os README, rode `organizar-plugins.sh` de novo.
