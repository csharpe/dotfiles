#
# ~/.bashrc
#

# ########################################################################
# Set environment variables
declare -x DOTFILES_REPO="~/dotfiles.git"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lah'

PS1='[\u@\h \W]\$ '

declare -x PATH=$PATH:/var/lib/snapd/snap/bin:~/bin:$HOME/Applications

# ########################################################################
# Alias for git dotfile management - used to manage dotfiles with git.
# Handy how to article at:
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles="/usr/bin/git --git-dir $DOTFILES_REPO --work-tree ~/ "

