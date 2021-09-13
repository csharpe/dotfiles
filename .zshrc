# ########################################################################
# Craig Sharpe's
# ZSH config
#
# My very own zshrc file.  This is my file, as such there is likely 
# better "zsh" ways to do things as this is really my first foray into
# zsh
# ########################################################################

# ########################################################################
# Environment Variables
# ########################################################################
declare -x DOTFILES_REPO="~/dotfiles.git"

autoload -U edit-command-line
autoload promptinit && promptinit

# zle -N edit-command-line
# bindkey '^[' edit-command-line
# bindkey '^xe' edit-command-line
# bindkey '^x^e' edit-command-line


# ########################################################################
# Aliases	
# ########################################################################
alias ll="ls -lah"
alias dotfiles="/usr/bin/git --git-dir $DOTFILES_REPO --work-tree ~/ "

# ########################################################################
#	Completions
#	The following lines were added by compinstallw# ########################################################################
# zstyle ':completion:*' list-colors ''
# zstyle :compinstall filename '/home/craig/.zshrc'
# autoload -Uz compinit
# compinit

# ########################################################################
# Oh-My-Zsh config
# https://github.com/ohmyzsh/ohmyzsh
# ########################################################################
declare -x ZSH="${HOME}/.oh-my-zsh"
declare -x ZSH_THEME="spaceship"

plugins=(
  git 
	colored-man-pages 
	colorize
	zsh-syntax-highlighting 
	vi-mode
)

ZSH_CACHE_DIR=${HOME}/.cache/oh-my-zsh
if [[ ! -d ${ZSH_CACHE_DIR} ]]; then
  mkdir ${ZSH_CACHE_DIR}
fi
source ${ZSH}/oh-my-zsh.sh

# ########################################################################
# Scripts to complete setup 
# ########################################################################

bindkey -v;


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/craigsharpe/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/craigsharpe/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/craigsharpe/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/craigsharpe/bin/google-cloud-sdk/completion.zsh.inc'; fi
