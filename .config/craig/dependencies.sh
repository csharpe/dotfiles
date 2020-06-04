#!/bin/bash
YELLOW='\e[1;33m'
RED='\e[1;31m'
GREEN='\e[1;32m'
NC='\033[0m'
ZSH_CUSTOM="${HOME}/.oh-my-zsh"

if [[ -e /usr/bin/pacman ]]; then
	# Archlinux based distro
	UPDATE_CMD="sudo pacman -Sy "
	INSTALL_CMD="sudo pacman -S --noconfirm  -- "
	ZSH_SYNTAX_INSTALL_LOC="/usr/share/zsh/plugins/zsh-syntax-highlighting"
elif [[ -e /usr/bin/apt ]]; then
	# Debian based distro
	UPDATE_CMD="sudo apt update"
	INSTALL_CMD="sudo apt install -y -- "
	ZSH_SYNTAX_INSTALL_LOC="/usr/share/zsh-syntax-highlighting"
elif [[ -e /usr/bin/brew ]]; then
	# OSX
	UPDATE_CMD="brew update ";
	INSTALL_CMD="brew install -- ";
	ZSH_SYNTAX_INSTALL_LOC="/usr/share/zsh-syntax-highlighting ";
else
	echo -e "${RED}Unsupported or unknown package manager${NC}";
	echo -e "${YELLOW}Installation of dependencies and dotfiles aborted${NC}";
	exit 1;
fi;

# ########################################################################
# Installation of dependencies for Linux environment 
echo -e "Updating package databases..."
echo

${UPDATE_CMD}
if [[ -e /usr/bin/git ]];then echo -e "${YELLOW}git already installed${NC}";else echo -e "${GREEN}Installing git${NC}"; ${INSTALL_CMD} git; fi;
if [[ -e /usr/bin/vim ]];then echo -e "${YELLOW}vim already installed${NC}";else echo -e "${GREEN}Installing vim${NC}"; ${INSTALL_CMD} vim ;  fi;
if [[ -e /usr/bin/zsh ]];then echo -e "${YELLOW}zsh already installed${NC}";else echo -e "${GREEN}Installing zsh${NC}"; ${INSTALL_CMD} zsh ;  fi;
if [[ -e /usr/bin/curl ]];then echo -e "${YELLOW}curl already installed${NC}";else echo -e "${GREEN}Installing curl${NC}"; ${INSTALL_CMD} curl ;  fi;
if [[ -e /usr/bin/wget ]];then echo -e "${YELLOW}wget already installed${NC}";else echo -e "${GREEN}Installing wget${NC}"; ${INSTALL_CMD} wget ;  fi;

if [[ -e /usr/share/powerline ]]; then 
	echo -e "${YELLOW}powerline already installed${NC}";
else 
	echo -e "${GREEN}Installing powerline${NC}"; 
	${INSTALL_CMD} powerline
fi;

if [[ -e ${ZSH_SYNTAX_INSTALL_LOC} ]]; then
	echo -e "${YELLOW}zsh-syntax-highlighting already installed${NC}";
else
	echo -e "${GREEN}Installing zsh-syntax-highlighting${NC}"
	${INSTALL_CMD} zsh-syntax-highlighting
fi;

# ########################################################################
# Install oh-my-zsh
# Some distros already have a package oh-my-zsh (Arch/Manjero) but many
# dont (debian/ubuntu) so we will install this package using the standard
# installation script.  This will install the package into the users
# local Directory
if [[ -e ${ZSH_CUSTOM} ]]; then
	echo -e "${YELLOW}oh-my-zsh already installed${NC}"
else
	echo -e "${GREEN}Installing oh-mh-zsh${NC}"
	curl -Lo /tmp/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh;
	ZSH=${HOME}/.oh-my-zsh sh /tmp/install.sh --unattended --keep-zshrc;
#	rm /tmp/install.sh
fi;

# ########################################################################
# Themes for zsh
if [[ ! ( -e ${ZSH_CUSTOM}/themes ) ]]; then mkdir -p ${ZSH_CUSTOM}/themes;fi

# Clone the shaceship-prompt theme git repository, only if it doesn't exist 
if [[ ! (-e ${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme) ]]; then 
	rm -rf ${ZSH_CUSTOM}/themes/spaceship-prompt; 
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s ${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM}/themes/spaceship.zsh-theme
fi

if [[ -e ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting ]]; then
	echo -e "${YELLOW}zsh-syntax-highlighting symbolic link already exists in ${ZSH_CUSTOM}${NC}"
else
	echo -e "${GREEN}Creating zsh-syntax-highlighting symbolic link${NC}";
	ln -s ${ZSH_SYNTAX_INSTALL_LOC} ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting;
fi;

# ########################################################################
# Plugins for zsh
if [[ -e ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]]; then
	echo -e "${YELLOW}zsh-syntax-highlighting.plugin.zsh already exists${NC}";
else
	if [[ -e ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
		ln -s ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh;
	else
		echo -e "${RED}Error: ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh does not exist, unable to create the symbolic link${NC}";
	fi;
fi;

# ########################################################################
# ZSH Cache directory
if [[ -e ${HOME}/.cache/oh-my-zsh ]]; then
	echo -e "${YELLOW}Local cache direcotry already exists${NC}";
else
	echo -e "${GREEN}Create local cache directory for oh-my-zsh${NC}";
	mkdir -p ${HOME}/.cache/oh-my-zsh
fi;

# ########################################################################
# Pull down the dotfiles repository
if [[ -e ${HOME}/dotfiles.git ]]; then
	echo -e "${YELLOW}dotfiles.git already downloaded from github${NC}";
else
	echo -e "${GREEN}Cloning dotfiles.git repository from github${NC}";
	git clone --bare https://github.com/csharpe/dotfiles ${HOME}/dotfiles.git;
fi;

git --work-tree ${HOME} --git-dir ${HOME}/dotfiles.git checkout --force

echo -e "${GREEN}Installation of dependencies and dotfiles complete${NC}";

