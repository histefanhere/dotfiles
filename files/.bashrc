# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#========================
# CUSTOM STUFF
#=======================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# My own custom colouring scheme
PS1="${debian_chroot:+($debian_chroot)}\[\033[36m\][\@] \[\033[32;1m\]\u\[\033[00m\]@\[\033[34;1m\]\h\[\033[00m\]: \[\033[31;1m\]\w\[\033[33m\]\$\[\033[00m\] "

# Add $HOME/.local/bin to my PATH
export PATH="$PATH:$HOME/.local/bin"

# Useful screen aliases
alias scrls='screen -ls '
alias scrr='screen -r '

# Aliases for copying and pasting from the X Clipboard.
# e.g, `cat file | clipset` will copy the contents of a file into your clipboard.
# For these to work `xclip` must be installed.
alias clipget='xclip -selection clipboard -o'
alias clipset='xclip -selection clipboard'

# Sets Vim as my default text editor, duh.
export VISUAL=vim
export EDITOR="$VISUAL"

# Magic space, wow so magic
bind Space:magic-space

# Use https://github.com/chubin/cheat.sh as an awesome cheat sheet, only requirement is curl and an internet connection
function cheat() {
    curl cheat.sh/"$@";
}

# I saw a funny meme on the internet where you alias sudo to please, adds so much humor to your commands
alias please="sudo"

# Load in my bash secrets file which ISN'T apart of the git repository.
if [ -f ~/.bash_secrets ]; then
    . ~/.bash_secrets
else
    echo "NOTE: ~/.bash_secrets not available. Some features might not work."
fi

# docker-compose aliases to save me lots of time
alias dcup="docker-compose up -d"
alias dcdown="docker-compose down"
alias dcdownrm="docker-compose down --rmi all -v"

# mydf is a modification to df that only shows real drives connected to the machine
alias mydf='df -hH -x squashfs -x tmpfs -x devtmpfs'

# mydu is a modification to du that shows the size of each folder in the current directory
alias mydu='du -h --max-depth 1 .'

# Source cargo env (if folder exists)
if [ -d "$HOME/.cargo" ]; then
    . "$HOME/.cargo/env"
fi

# From orion laptop but this was ALWAYS active for some reason??
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/stoofin/.anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/stoofin/.anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/stoofin/.anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/stoofin/.anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

