# Neovim Cheatsheet

Neovim e um editor modal. Isso significa que ele tem modos diferentes: modo normal para navegar e executar comandos, modo insert para digitar texto e modo visual para selecionar.

---

## Comandos mais uteis

| Comando | Para que serve |
| --- | --- |
| `nvim` | Abre o editor |
| `nvim <arquivo>` | Abre um arquivo |
| `:w` | Salva |
| `:q` | Sai |
| `:wq` | Salva e sai |
| `:q!` | Sai sem salvar |
| `:e <arquivo>` | Abre outro arquivo |
| `:split` | Divide a tela na horizontal |
| `:vsplit` | Divide a tela na vertical |

---

## Atalhos de teclado

| Atalho | Acao |
| --- | --- |
| `i` | Entra no modo de insercao |
| `Esc` | Volta para modo normal |
| `h/j/k/l` | Esquerda, baixo, cima, direita |
| `w` | Proxima palavra |
| `b` | Palavra anterior |
| `dd` | Apaga linha |
| `yy` | Copia linha |
| `p` | Cola |
| `u` | Desfaz |
| `Ctrl-r` | Refaz |
| `/texto` | Busca texto |
| `n` | Proximo resultado da busca |

---

## Fluxos comuns

### Editar e salvar

```bash
nvim arquivo.txt
```

1. Aperte `i`.
2. Digite o texto.
3. Aperte `Esc`.
4. Digite `:wq` e aperte Enter.

### Buscar e substituir

```vim
:%s/antigo/novo/g
```

Troca `antigo` por `novo` no arquivo inteiro.

---

## Exemplos

Abrir a configuracao do Neovim:

```bash
nvim ~/.config/nvim
```

Abrir varios arquivos:

```bash
nvim arquivo1.txt arquivo2.txt
```

---

## Troubleshooting

| Problema | Solucao |
| --- | --- |
| Nao consigo digitar | Aperte `i` para entrar no modo insert |
| Nao consigo sair | Aperte `Esc`, depois `:q` ou `:q!` |
| Salvar falhou por permissao | Abra com permissao correta ou salve em outro local |
| Busca nao acha texto | Confira maiusculas/minusculas e tente `/parte_do_texto` |

