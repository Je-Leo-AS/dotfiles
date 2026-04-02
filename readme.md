# Dotfiles com GNU Stow

Este repositório usa o GNU Stow para gerenciar dotfiles por meio de links simbólicos.

A ideia é simples: os arquivos de configuração ficam versionados neste repositório, e o Stow cria os links no lugar certo dentro da home do usuário. Assim, fica mais fácil manter, portar e restaurar o ambiente em outra máquina.

## O que é o Stow

O GNU Stow é uma ferramenta que gerencia links simbólicos.

Em vez de copiar manualmente arquivos de configuração para a home, você mantém tudo versionado no repositório e usa o Stow para criar os links automaticamente.

Na prática, isso permite:

- manter configurações organizadas
- versionar mudanças com Git
- replicar o ambiente em outra máquina com menos esforço
- remover ou reaplicar configurações com poucos comandos

## Instalação

No Arch Linux:

```bash
sudo pacman -S stow git
