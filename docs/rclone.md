# Rclone Cheatsheet

Rclone sincroniza arquivos com servicos de nuvem e servidores remotos. Ele trabalha com remotes configurados, como Google Drive, OneDrive, SFTP e outros.

---

## Comandos mais uteis

| Comando | Para que serve |
| --- | --- |
| `rclone config` | Criar ou editar remotes |
| `rclone listremotes` | Lista remotes configurados |
| `rclone lsd remote:` | Lista pastas no remote |
| `rclone ls remote:path` | Lista arquivos |
| `rclone copy origem destino` | Copia sem apagar extras |
| `rclone sync origem destino` | Sincroniza e apaga extras no destino |
| `rclone check origem destino` | Verifica diferencas |
| `rclone mount remote:path ~/mnt` | Monta remote como pasta |

---

## Atalhos e conceitos

| Conceito | Explicacao |
| --- | --- |
| Remote | Nome configurado para um servico |
| `remote:` | Raiz do remote |
| `copy` | Copia arquivos, nao apaga extras |
| `sync` | Espelha origem no destino, pode apagar |
| `--dry-run` | Simula sem alterar |

Rclone nao tem atalhos de teclado; o uso e por comandos.

---

## Fluxos comuns

### Copiar com seguranca

```bash
rclone copy ~/Documents remote:Backup/Documents --dry-run
rclone copy ~/Documents remote:Backup/Documents -P
```

### Sincronizar com cuidado

```bash
rclone sync ~/Documents remote:Backup/Documents --dry-run
rclone sync ~/Documents remote:Backup/Documents -P
```

### Listar remotes

```bash
rclone listremotes
rclone lsd remote:
```

---

## Exemplos

Ver tamanho de uma pasta remota:

```bash
rclone size remote:Backup
```

Copiar com progresso:

```bash
rclone copy ~/Pictures remote:Pictures -P
```

---

## Troubleshooting

| Problema | Solucao |
| --- | --- |
| Remote nao aparece | Rode `rclone listremotes` e confira `rclone config` |
| Medo de apagar arquivos | Use `copy` ou `sync --dry-run` primeiro |
| Montagem falha | Confira FUSE e permissoes do ponto de montagem |
| Transferencia lenta | Use `-P` para progresso e confira rede/limites do provedor |

