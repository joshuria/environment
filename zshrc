# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias ls='ls --color'
alias ll='ls -lh'
alias la='ls -alh'
alias sync='sync;sync;sync;'
alias cls='clear'
alias free='free -h'
alias df='df -h'
alias du='du -h'
# alias vim=nvim
alias gitco='git checkout'
alias gitlog='git log --oneline'
alias gitstat='git status'

export VCPKG_ROOT=~/tools/vcpkg

if [[ -z $ENV_INITED ]] && [[ -z $TMUX ]]; then
    # export PATH=~/tools/mold-2.37.1/bin:~/tools/:/snap/bin:$PATH:~/.nvm/versions/node/v22.14.0/bin
    export PATH=~/tools/:/snap/bin:$PATH:~/.nvm/versions/node/v22.14.0/bin
    export ENV_INITED=1
fi
export NODE_PATH=${NODE_PATH:+$NODE_PATH:}/usr/local/lib/node_modules

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

unset rc

export CMAKE_C_STANDARD=17
export CMAKE_CXX_STANDARD=26
export CMAKE_C_COMPILER_LAUNCHER=ccache
export CMAKE_CXX_COMPILER_LAUNCHER=ccache

export XMODIFIERS="@im=fcitx"
export EDITOR="vim"
export VISUAL="vim"

export PYTHON_BASIC_REPL=1
bindkey -v

. "$HOME/.cargo/env"

unset -f command_not_found_handler 2> /dev/null
unsetopt correct_all
unsetopt correct

# Auto suggestion
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^E' autosuggest-accept
# bindkey '\t' end-of-line

# Enable syntax highlight, must put at end of this file
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
