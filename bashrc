# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias ls='ls --color'
alias ll='ls -lh'
alias la='ls -alh'
alias sync='sync;sync;sync;'
alias cls='clear'
alias free='free -h'
alias df='df -h'
alias du='du -h'
alias vim=nvim
alias gitco='git checkout'
alias gitlog='git log --oneline'
alias gitstat='git status'
alias python3=/usr/bin/python3.12

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

format_exit_code() {
    code=$?
    [ $code -ne 0 ] && echo -e "\a\e[31;40mLastExitCode: $code\e[0m"
    # if [ $code -ne 0 ]; then 
    #     #echo -e "\a\[\e[31;40m\] Exit: $code\[\e[m\]"
    #     echo -e "\a\e[31;40mExit: $code\e[0m"
    # else 
    #     echo -e "\e[32mExit: $code\e[0m"
    # fi
}

if [ -t 1 ]; then
    #export PS1="[\[$(tput sgr0)\]\[\033[38;5;11m\]\@\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;6m\]\u\[$(tput sgr0)\]\[\033[38;5;175m\]@\[$(tput sgr0)\]\[\033[38;5;174m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]] \[$(tput sgr0)\]\[\033[38;5;121m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\\$ \[$(tput sgr0)\]"
export PS1="\$(format_exit_code)\n[\[$(tput sgr0)\]\[\033[38;5;11m\]\t\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;6m\]\u\[$(tput sgr0)\]\[\033[38;5;175m\]@\[$(tput sgr0)\]\[\033[38;5;174m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]] \[$(tput sgr0)\]\[\033[38;5;121m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n \[\e[91m\]\$(parse_git_branch)\[\e[00m\]\\$ \[$(tput sgr0)\]"
fi

export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LANG=en_US.UTF-8
export TERM=xterm-256color

if [[ -z $ENV_INITED ]] && [[ -z $TMUX ]]; then
    export PATH=~/tools/mold-2.32.0/bin:~/tools/:/snap/bin:$PATH:~/packages/node-v20.6.1-linux-x64/bin
    export ENV_INITED=1
fi
export NODE_PATH=${NODE_PATH:+$NODE_PATH:}/usr/local/lib/node_modules

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi

unset rc

export EDITOR=vim

export CMAKE_C_STANDARD=17
export CMAKE_CXX_STANDARD=23
export CMAKE_C_COMPILER_LAUNCHER=ccache
export CMAKE_CXX_COMPILER_LAUNCHER=ccache

. "$HOME/.cargo/env"
