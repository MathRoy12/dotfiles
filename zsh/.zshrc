
# The following lines were added by compinstall

zstyle ':completion:*' completer _ignored _approximate
zstyle :compinstall filename '/home/mathieu/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=1000
setopt autocd
unsetopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

export EDITOR=nvim
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/1_shell.json)"
alias vim='nvim'
alias ls='exa -lah'

eval "$(zoxide init zsh --cmd cd)"

fastfetch
