# -----------------------------
# Oh My Zsh
# -----------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
export TERMINAL=wezterm
plugins=(git)
source $ZSH/oh-my-zsh.sh

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

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
alias dotfiles='/usr/bin/git -C /home/je/dotfiles'
eval "$(starship init zsh)"
alias ise='bash -c "source /opt/Xilinx/14.7/ISE_DS/settings64.sh && ise"'

# Terminal cheatsheets
export DOTFILES_DOCS_DIR="$HOME/dotfiles/docs"

_render_markdown() {
  emulate -L zsh
  local file="$1"

  if command -v glow >/dev/null 2>&1; then
    glow "$file"
  elif command -v less >/dev/null 2>&1; then
    less -R "$file"
  else
    cat "$file"
  fi
}

docs() {
  emulate -L zsh
  local index="$DOTFILES_DOCS_DIR/README.md"

  if [[ ! -f "$index" ]]; then
    print "Docs index not found: $index" >&2
    return 1
  fi

  _render_markdown "$index"
}

cheats() {
  emulate -L zsh

  if [[ ! -d "$DOTFILES_DOCS_DIR" ]]; then
    print "Docs directory not found: $DOTFILES_DOCS_DIR" >&2
    return 1
  fi

  print "Available cheatsheets:"
  find "$DOTFILES_DOCS_DIR" -maxdepth 1 -type f -name "*.md" ! -name "README.md" -printf "  %f\n" | sed "s/\\.md$//" | sort
  print
  print "Open one with: cdocs <name>"
}

cdocs() {
  emulate -L zsh
  local name="$1"

  if [[ -z "$name" ]]; then
    print "Usage: cdocs <name>" >&2
    print "Example: cdocs yazi" >&2
    return 1
  fi

  name="${name%.md}"
  local file="$DOTFILES_DOCS_DIR/$name.md"

  if [[ ! -f "$file" ]]; then
    print "Cheatsheet not found: $name" >&2
    cheats
    return 1
  fi

  _render_markdown "$file"
}

alias update-pkgs='~/dotfiles/scripts/update-pkglist.sh'
alias dots='$HOME/dotfiles/scripts/update-dotfiles.sh'

# Cheat renderizado com glow
cshow() {
  command cheat "$@" | glow -
}

pc-info() {
  echo "==== CPU ===="
  lscpu

  echo -e "\n==== RAM ===="
  free -h

  echo -e "\n==== DISCO ===="
  lsblk

  echo -e "\n==== MODELO DA MÁQUINA ===="
  sudo dmidecode -t system | grep -E "Manufacturer|Product Name|Version"
}

export QSYS_ROOTDIR="/home/je/.cache/yay/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/25.1/quartus/sopc_builder/bin"


vsimq() {
    export PATH=/opt/intelFPGA/25.1/questa_fse/bin:$PATH

    export MGLS_LICENSE_FILE=$HOME/Applications/Xilinx_ISE_DS_Lin_14.7_1015_1/LR-167545_License.dat

    export SALT_LICENSE_SERVER=$MGLS_LICENSE_FILE

    unset LM_LICENSE_FILE

    ulimit -s unlimited

    if [ $# -gt 0 ]; then
        cd "$1" || return
    fi

    vsim
}

alias dashpane="wezterm cli split-pane --right --percent 45 -- bash -lc '~/.config/mydash/run'"
alias dash="~/.config/mydash/mydash"
