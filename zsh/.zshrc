# The following lines were added by compinstall

zstyle ':completion:*' completer _ignored _approximate
zstyle :compinstall filename '/home/mathieu/.zshrc'

#autoload -Uz compinit
#compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=1000
setopt autocd
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
unsetopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

export EDITOR=nvim
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/2_shell.json)"
alias vim='nvim'
alias ls='exa -lah'

eval "$(zoxide init zsh --cmd cd)"

export PATH="/home/mathieu/.cargo/bin: $PATH"
export PATH="/home/mathieu/dotfiles/bin: $PATH"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

autoload -U compinit && compinit


# If tmux is installed and we're not in a tmux session, start one
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
    tmux attach || tmux new
fi
