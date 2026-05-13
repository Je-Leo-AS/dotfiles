# Tmux Cheatsheet

Tmux mantem sessoes de terminal vivas. Voce pode desconectar e voltar depois, alem de dividir a tela em paineis.

---

## Comandos mais uteis

| Comando | Para que serve |
| --- | --- |
| `tmux` | Cria uma sessao |
| `tmux new -s nome` | Cria sessao com nome |
| `tmux ls` | Lista sessoes |
| `tmux attach -t nome` | Reconecta em uma sessao |
| `tmux kill-session -t nome` | Encerra uma sessao |
| `tmux rename-session -t antigo novo` | Renomeia sessao |

---

## Atalhos de teclado

O prefixo padrao e `Ctrl-b`. Aperte `Ctrl-b`, solte, depois aperte a tecla do comando.

| Atalho | Acao |
| --- | --- |
| `Ctrl-b d` | Desconectar da sessao |
| `Ctrl-b %` | Dividir painel verticalmente |
| `Ctrl-b "` | Dividir painel horizontalmente |
| `Ctrl-b setas` | Mover entre paineis |
| `Ctrl-b c` | Nova janela |
| `Ctrl-b n` | Proxima janela |
| `Ctrl-b p` | Janela anterior |
| `Ctrl-b ,` | Renomear janela |
| `Ctrl-b [` | Modo de copia/scroll |
| `Ctrl-b ?` | Ajuda de atalhos |

---

## Fluxos comuns

### Criar sessao de trabalho

```bash
tmux new -s trabalho
```

Para sair sem matar os processos: `Ctrl-b d`.

Para voltar:

```bash
tmux attach -t trabalho
```

### Dividir tela

1. `Ctrl-b %` para painel vertical.
2. `Ctrl-b "` para painel horizontal.
3. `Ctrl-b setas` para navegar.

---

## Exemplos

Criar sessao para servidor:

```bash
tmux new -s server
```

Listar e reconectar:

```bash
tmux ls
tmux attach -t server
```

---

## Troubleshooting

| Problema | Solucao |
| --- | --- |
| Nao sei sair | Use `Ctrl-b d` para desconectar ou `exit` para fechar shell |
| Sessao nao existe | Confira `tmux ls` |
| Atalho nao funciona | Aperte `Ctrl-b`, solte, depois a tecla |
| Terminal estranho | Tente `tmux kill-session -t nome` e abra nova sessao |

