# Docker Cheatsheet

Docker executa aplicacoes em containers. Um container e um processo isolado criado a partir de uma imagem.

---

## Comandos mais uteis

| Comando | Para que serve |
| --- | --- |
| `docker ps` | Lista containers em execucao |
| `docker ps -a` | Lista todos os containers |
| `docker images` | Lista imagens locais |
| `docker run hello-world` | Testa Docker |
| `docker run -it ubuntu bash` | Abre shell em container Ubuntu |
| `docker stop <container>` | Para um container |
| `docker rm <container>` | Remove container |
| `docker rmi <imagem>` | Remove imagem |
| `docker logs <container>` | Mostra logs |
| `docker exec -it <container> bash` | Entra em container rodando |
| `docker compose up` | Sobe servicos do Compose |
| `docker compose down` | Para e remove servicos do Compose |

---

## Atalhos e conceitos

| Conceito | Explicacao |
| --- | --- |
| Imagem | Modelo imutavel usado para criar containers |
| Container | Instancia em execucao de uma imagem |
| Volume | Persistencia de dados fora do container |
| Porta | Mapeamento entre host e container |
| Compose | Arquivo YAML para varios servicos |

Docker nao tem atalhos de teclado; use comandos no shell.

---

## Fluxos comuns

### Rodar servico com porta

```bash
docker run --name web -p 8080:80 nginx
```

Abra `http://localhost:8080`.

### Entrar em container

```bash
docker ps
docker exec -it nome_ou_id bash
```

### Limpar recursos nao usados

```bash
docker system prune
```

---

## Exemplos

Subir Compose:

```bash
docker compose up -d
docker compose logs -f
docker compose down
```

Rodar comando temporario:

```bash
docker run --rm alpine echo "ok"
```

---

## Troubleshooting

| Problema | Solucao |
| --- | --- |
| `permission denied` no socket | Adicione usuario ao grupo `docker` ou use `sudo` |
| Porta ja em uso | Troque `-p 8080:80` para outra porta |
| Container sai imediatamente | Veja logs com `docker logs <container>` |
| Disco cheio | Use `docker system df` e limpe recursos nao usados |

