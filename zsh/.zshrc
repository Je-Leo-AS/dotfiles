# -----------------------------
# Oh My Zsh
# -----------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# -----------------------------
# Editor
# -----------------------------
export EDITOR=nvim

# carregar bashrc se existir
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# -----------------------------
# Prompt bonito
# -----------------------------
PROMPT='%F{cyan}$CONDA_PROMPT_MODIFIER%f%F{green}%n%f@%F{blue}%m%f %F{yellow}%1~%f ❯ '

# -----------------------------
# WezTerm Semantic Blocks
# -----------------------------

# prompt começou
_wezterm_prompt_start() {
  printf '\033]133;A\007'
}

# comando começou
_wezterm_command_start() {
  printf '\033]133;C\007'
}

# comando terminou
_wezterm_command_end() {
  printf '\033]133;D\007'
}

autoload -Uz add-zsh-hook

add-zsh-hook precmd _wezterm_prompt_start
add-zsh-hook preexec _wezterm_command_start
add-zsh-hook precmd _wezterm_command_end

# início do input
_OSC133B=$'\e]133;B\007'
PROMPT="%{${_OSC133B}%}"'%F{cyan}${CONDA_PROMPT_MODIFIER}%f%F{green}%n%f@%F{blue}%m%f %F{yellow}%1~%f $ '
alias dotfiles='/usr/bin/git --git-dir=/home/je/.dotfiles/ --work-tree=/home/je'
eval "$(starship init zsh)"

