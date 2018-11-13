# Environment variables
export HISTFILE=${HOME}/.zshhistfile
export HISTSIZE=65536
export SAVEHIST=65536

export EDITOR=hack

export GOMA_DIR=$HOME/goma

# Path.
typeset -U path
typeset -U fpath

path=(
    ~/bin
    ~/code/scripts
    ~/.cargo/bin
    $path
)

fpath=(
    ~/code/dotfiles/zsh-functions
    $fpath
)


# Aliases and functions
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ls='ls -Fh --color=auto'
alias l='ls'
alias la='ls -A'
alias ll='ls -l'


# Git
__git_files () {
    _wanted files expl 'local files' _files
}


# Autoloads
autoload -Uz compinit
compinit


# Options
setopt append_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history

setopt extended_glob
unsetopt flowcontrol
setopt nomatch
setopt notify


# Prompts
function setup_prompt {
    local error="%(?..%F{$2}%? )"
    PS1="
%F{$1}%n@%m:%~%f
${error}%F{$1}$ %f"
    PS2="%F{$1}(%F{$1}%_%F{$1}): %f"
}
setup_prompt blue red
unfunction setup_prompt
