# Yazi Cheatsheet

Yazi e um gerenciador de arquivos no terminal. Ele permite navegar, abrir, copiar, mover, renomear e apagar arquivos usando teclado.

---

## Comandos mais uteis

| Comando | Para que serve |
| --- | --- |
| `yazi` | Abre no diretorio atual |
| `yazi <pasta>` | Abre em uma pasta especifica |
| `ya pack -l` | Lista plugins/pacotes, se o `ya` estiver instalado |

---

## Atalhos de teclado

| Atalho | Acao |
| --- | --- |
| `q` | Sair |
| `h/j/k/l` | Voltar, baixo, cima, entrar |
| `Enter` | Abrir arquivo ou pasta |
| `Space` | Selecionar arquivo |
| `y` | Copiar |
| `x` | Recortar |
| `p` | Colar |
| `r` | Renomear |
| `d` | Enviar para lixeira/remover, conforme configuracao |
| `/` | Buscar |
| `.` | Mostrar/ocultar arquivos ocultos |

---

## Fluxos comuns

### Navegar e abrir arquivo

```bash
yazi
```

Use `j/k` para mover, `l` ou Enter para abrir e `h` para voltar.

### Copiar arquivos

1. Marque com `Space`.
2. Aperte `y`.
3. Va para o destino.
4. Aperte `p`.

---

## Exemplos

Abrir Downloads:

```bash
yazi ~/Downloads
```

Abrir a pasta de dotfiles:

```bash
yazi ~/dotfiles
```

---

## Troubleshooting

| Problema | Solucao |
| --- | --- |
| Preview nao aparece | Instale dependencias opcionais de preview, como `ffmpegthumbnailer` ou `poppler` |
| Arquivo nao abre | Confira o programa padrao associado ao tipo de arquivo |
| `command not found: yazi` | Instale o pacote `yazi` |
| Operacao perigosa | Confirme selecao antes de apagar ou mover muitos arquivos |

