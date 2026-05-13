# SSH Cheatsheet

SSH permite acessar maquinas remotas e autenticar em servicos como GitHub de forma segura. Arquivos de chave privada nunca devem ser publicados.

---

## Comandos mais uteis

| Comando | Para que serve |
| --- | --- |
| `ssh usuario@host` | Conecta em uma maquina remota |
| `ssh -p 2222 usuario@host` | Conecta usando porta especifica |
| `ssh -i ~/.ssh/chave usuario@host` | Usa chave especifica |
| `ssh-keygen -t ed25519 -C "email"` | Cria uma chave nova |
| `ssh-add ~/.ssh/chave` | Adiciona chave ao agente |
| `ssh -T git@github.com` | Testa autenticacao com GitHub |

---

## Atalhos e arquivos importantes

| Item | Explicacao |
| --- | --- |
| `~/.ssh/config` | Apelidos e configuracoes de hosts |
| `~/.ssh/known_hosts` | Hosts ja conhecidos |
| `~/.ssh/*.pub` | Chaves publicas, podem ser compartilhadas |
| `~/.ssh/id_*` | Chaves privadas, nao compartilhe |

SSH nao tem atalhos de teclado comuns; o uso principal e por comando.

---

## Fluxos comuns

### Conectar usando alias

No `~/.ssh/config`:

```sshconfig
Host servidor
  HostName exemplo.com
  User usuario
  Port 22
```

Depois:

```bash
ssh servidor
```

### Corrigir permissoes

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/*.pub
```

---

## Exemplos

Testar GitHub:

```bash
ssh -T git@github.com
```

Gerar chave moderna:

```bash
ssh-keygen -t ed25519 -C "seu-email"
```

---

## Troubleshooting

| Problema | Solucao |
| --- | --- |
| `Permission denied (publickey)` | Confira chave, usuario, `ssh-add` e chave publica no servidor |
| `Bad permissions` | Ajuste permissoes com `chmod` |
| Host mudou chave | Verifique se e legitimo antes de editar `known_hosts` |
| Chave privada no Git | Remova imediatamente e gere uma chave nova |

