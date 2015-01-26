# Environment variables
export HISTFILE=${HOME}/.zshhistfile
export HISTSIZE=65536
export SAVEHIST=65536

export EDITOR=hack

export MIRALIB=$HOME/lib/miralib

export DCF_ROOT=~/apportable/repos/dcf

# Path.
typeset -U path
typeset -U fpath

path=(
    ~/bin
    ~/code/scripts
    $DCF_ROOT/toolchain/macosx/android-sdk/platform-tools
    $DCF_ROOT/toolchain/macosx/android-sdk/tools
    $DCF_ROOT/bin
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

alias ls='ls -FGh'
alias l='ls'
alias la='ls -A'
alias ll='ls -l'


# Nix
export NIX_PATH=$HOME/code/nixpkgs:nixpkgs=$HOME/code/nixpkgs
export NIX_CONF_DIR=$HOME/code/dotfiles/nix.conf
source $HOME/.nix-profile/etc/profile.d/nix.sh


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
    local subshell_depth
    case $TERM in
        dumb|eterm*)
            subshell_depth=4 ;;
        screen*)
            subshell_depth=3 ;;
        *)
            subshell_depth=2 ;;
    esac
    local subshell="%${subshell_depth}(L.%F{$2}+ .)"
    local error="%(?..%F{$2}%? )"

    PS1="
%F{$1}%n@%m:%~%f
${subshell}${error}%F{$1}$ %f"
    PS2="%F{$1}(%F{$1}%_%F{$1}): %f"
}
setup_prompt blue red
unfunction setup_prompt
