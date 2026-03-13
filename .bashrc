#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
if [ -f ~/toggle_vpn.sh ]; then
    bash ~/toggle_vpn.sh
fi

alias start_vpn='~/toogle_vpn.sh'
alias disable_vpn='~/disable_vpns.sh'
alias syncod='rclone bisync "OneDrive Pessoal": /home/je/Clouds/OneDrive --progress --exclude "Cofre Pessoal/**"'
alias syncgd='rclone bisync "Google Drive Pessoal": /home/je/Clouds/GoogleDrive --progress --resync'
alias chat='aider --model openrouter/openrouter/free'

. "$HOME/.local/bin/env"

# Função para sair no diretório atual
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

alias copiar='wl-copy <'

