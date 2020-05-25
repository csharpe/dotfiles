#
# ~/.bashrc
#
# If not running interactively, don't do anything
# [[ $- != *i* ]] && return
# [[ $(uname) == 'Darwin' ]]

# ########################################################################
# Set environment variables
# ########################################################################
declare -x DOTFILES_REPO="~/dotfiles.git"

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

#PS1='[\u@\h \W]\$ '

declare -x PATH=$PATH:/var/lib/snapd/snap/bin:~/bin:$HOME/Applications

# Enable QGtkStyle
# declare -x QT_QPA_PLATFORMTHEME=gtk2
declare -x QT_STYLE_OVERRIDE=gtk2

# ########################################################################
# bash history control
# ########################################################################

# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# ########################################################################
# Bash options
# ########################################################################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ########################################################################
# Color support
# ########################################################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
elif [[ $(uname) == 'Darwin' ]] && [[ $TERM == *'color'* ]]; then
	# dir and vdir do not exist in OSX, OSX also use a different
	# command option for color output than Linux
	alias ls='ls -G'
	export CLICOLOR=1

	# Use more pleasant colors from ls than the defaults
	export LSCOLORS='ExfxcxdxCxegedabagacad'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# ########################################################################
# Alias definitions.
# ########################################################################

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias for git dotfile management - used to manage dotfiles with git.
# Handy how to article at:
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles="/usr/bin/git --git-dir $DOTFILES_REPO --work-tree ~/ "

# Left this here, commented out  as a reminder of something 
# I may wish to do if my list of aliases continues to grow
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# ########################################################################
# Google Cloud components
# ########################################################################

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/bin/google-cloud-sdk/path.bash.inc" ]; then . "${HOME}/bin/google-cloud-sdk/path.bash.inc" ; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/bin/google-cloud-sdk/completion.bash.inc" ]; then . "${HOME}/bin/google-cloud-sdk/completion.bash.inc"; fi

# ########################################################################
# iTERM (OSX Terminal) integration
# ########################################################################
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# ########################################################################
# Enivronmental definitions.
# ########################################################################

declare -x EDITOR="/usr/bin/vim"

