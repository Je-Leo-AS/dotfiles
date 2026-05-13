# Lazygit Cheatsheet

Lazygit e uma interface de terminal para Git. Ele ajuda a visualizar status, commits, branches e diffs sem memorizar todos os comandos.

---

## Comandos mais uteis

| Comando | Para que serve |
| --- | --- |
| `lazygit` | Abre a interface no repositorio atual |
| `lazygit -p <path>` | Abre Lazygit em outro diretorio |
| `git status` | Alternativa simples quando Lazygit nao esta instalado |

---

## Atalhos de teclado

| Atalho | Acao |
| --- | --- |
| `q` | Sair ou voltar |
| `?` | Ajuda de atalhos da tela atual |
| Setas ou `h/j/k/l` | Navegar entre paineis e itens |
| `Space` | Marcar/desmarcar arquivo ou hunk |
| `a` | Stage/unstage todos os arquivos |
| `c` | Criar commit |
| `P` | Push |
| `p` | Pull |
| `b` | Branches |
| `m` | Merge |

---

## Fluxos comuns

### Commit visual

```bash
lazygit
```

1. Entre no painel de arquivos.
2. Use `Space` para escolher o que entra no commit.
3. Aperte `c`.
4. Digite a mensagem.
5. Use `P` para enviar.

### Revisar diff antes de commitar

Abra `lazygit`, selecione um arquivo alterado e navegue pelo painel de diff antes de usar `Space`.

---

## Exemplos

Abrir Lazygit no repositorio de dotfiles:

```bash
cd ~/dotfiles
lazygit
```

---

## Troubleshooting

| Problema | Solucao |
| --- | --- |
| `command not found: lazygit` | Instale Lazygit ou use `git status`, `git diff`, `git add`, `git commit` |
| Tela confusa | Aperte `?` para ajuda contextual |
| Nao consegue fazer push | Confira remoto com `git remote -v` e autenticao SSH |
| Merge complicado | Saia com `q` e resolva os arquivos em conflito no editor |

