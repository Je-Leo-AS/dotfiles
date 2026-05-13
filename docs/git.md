# Git Cheatsheet

Git e um sistema de controle de versao. Ele registra alteracoes nos arquivos, permite voltar no tempo, criar branches e sincronizar trabalho com repositorios remotos como GitHub.

---

## Comandos mais uteis

| Comando | Para que serve |
| --- | --- |
| `git status` | Mostra arquivos modificados, adicionados ou pendentes |
| `git add <arquivo>` | Prepara um arquivo para commit |
| `git add .` | Prepara todas as alteracoes do diretorio atual |
| `git commit -m "mensagem"` | Salva um ponto de historico |
| `git log --oneline --graph --decorate` | Mostra historico compacto |
| `git diff` | Mostra alteracoes ainda nao adicionadas |
| `git diff --staged` | Mostra alteracoes ja adicionadas |
| `git branch` | Lista branches locais |
| `git switch <branch>` | Troca de branch |
| `git switch -c <branch>` | Cria e troca para uma branch nova |
| `git pull` | Baixa alteracoes do remoto |
| `git push` | Envia commits para o remoto |

---

## Atalhos e conceitos

| Conceito | Explicacao |
| --- | --- |
| Working tree | Arquivos como estao agora no disco |
| Staging area | Alteracoes preparadas com `git add` |
| Commit | Snapshot salvo no historico |
| Branch | Linha separada de trabalho |
| Remote | Repositorio externo, geralmente `origin` |

Git nao tem atalhos de teclado por padrao. O fluxo basico e feito por comandos.

---

## Fluxos comuns

### Salvar alteracoes

```bash
git status
git diff
git add .
git commit -m "update dotfiles"
git push
```

### Criar uma branch

```bash
git switch -c docs-cheatsheets
git status
```

### Ver o que mudou

```bash
git diff
git diff --staged
git log --oneline --graph --decorate -10
```

---

## Exemplos

Adicionar apenas um arquivo:

```bash
git add zsh/.zshrc
git commit -m "add zsh docs aliases"
```

Desfazer alteracoes ainda nao adicionadas em um arquivo:

```bash
git restore caminho/do/arquivo
```

---

## Troubleshooting

| Problema | Solucao |
| --- | --- |
| `nothing to commit` | Nao ha alteracoes preparadas; rode `git status` |
| Push rejeitado | Rode `git pull --rebase` e depois `git push` |
| Commit no branch errado | Crie branch com `git switch -c nome` antes de continuar |
| Arquivo sensivel apareceu | Remova do stage com `git restore --staged <arquivo>` |

