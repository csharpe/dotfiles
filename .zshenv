#########################################################################
# Source the shell environment varaibles file - keeps environments
# consistant between shells (bash and zsh)
#########################################################################
if [ -e $HOME/.shenv ]; then 
	source $HOME/.shenv;
fi

# ########################################################################
# Google Cloud components paths
# ########################################################################

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/bin/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/bin/google-cloud-sdk/path.zsh.inc" ; fi

