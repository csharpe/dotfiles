" Set the font size

if has("gui_running")
	" Gvim
	let s:uname = system("uname")
  if s:uname == "Darwin\n"
		:set guifont=SourceCodeProForPowerline-Regular:h18
	elseif has("gui_gtk2") || has("gui_gtk3")
    " Linux GUI
		set guifont=Source\ Code\ Pro\ 30
  endif
endif

" ************************************************************************ 
" Editor settings
"
" Set the tabstops
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Show line numbers
set number
set relativenumber
" :set norelativenumber

filetype on
:syntax on

" ************************************************************************
" Check if VIM has python3 support - if so enable Powerline
if has('python3')
	" Enable Powerline - Installed via PIP
	"
	python3 from powerline.vim import setup as powerline_setup
	python3 powerline_setup()
	python3 del powerline_setup
	set laststatus=2
endif

" ************************************************************************
" Enable support for FZF in VIM
set rtp+=/usr/local/opt/fzf

" ************************************************************************ 
" plug Ins Settings
"
" Plug in manager is vim plug
" Documentation located at: https://github.com/junegunn/vim-plug
" Install with:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
" 	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" After installation of vim-plug run
" :PlugInstall!
"

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/hashivim/vim-terraform.git'
Plug 'https://github.com/chiel92/vim-autoformat'
Plug 'https://github.com/powerline/powerline'
Plug 'https://github.com/chrisbra/Colorizer'

call plug#end()

:au BufWrite,BufEnter,FileType *.yml,*.css,yaml,yml,css :ColorToggle
