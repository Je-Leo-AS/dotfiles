#!/usr/bin/env bash

set -euo pipefail

profile="${HOME}/.profile"
marker_start="# >>> dotfiles ssh prompt >>>"
marker_end="# <<< dotfiles ssh prompt <<<"

touch "$profile"

if grep -qF "$marker_start" "$profile"; then
  echo "SSH prompt block already exists in $profile"
  exit 0
fi

cat >> "$profile" <<'EOF'

# >>> dotfiles ssh prompt >>>
if [ -n "${SSH_CONNECTION:-}" ] || [ -n "${SSH_CLIENT:-}" ] || [ -n "${SSH_TTY:-}" ]; then
  if [ -n "${BASH_VERSION:-}" ]; then
    PS1='[SSH \h] \w \$ '
  elif [ -n "${ZSH_VERSION:-}" ]; then
    PROMPT='[SSH %m] %~ %# '
  else
    PS1='[SSH $(hostname -s)] $PWD $ '
  fi
fi
# <<< dotfiles ssh prompt <<<
EOF

echo "Added SSH prompt block to $profile"
