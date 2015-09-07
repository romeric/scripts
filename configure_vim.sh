#!/bin/bash

echo Entering directory $HOME
cd ~
echo Creating .vimrc & .vim directory
if [ ! -d ".vim" ]; then
	mkdir .vim 
fi
if [ ! -f ".vimrc" ]; then
	touch .vimrc 
fi

echo Cloning the vundle plugin manager
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo Modifying $HOME/.vimrc file for vundle
printf "set nocompatible
filetype off\n
set rtp+=~/.vim/bundle/Vundle.vim\n
call vundle#begin()\n
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'powerline/powerline'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'morhetz/gruvbox'\n
call vundle#end()\n
filetype plugin indent on\n" >> .vimrc

echo Minimal customisation of .vimrc 
printf "set number
set relativenumber
syntax on
set t_Co=256
set background=dark
colorscheme gruvbox\n
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup\n 
set laststatus=2" >> .vimrc

printf "
nnoremap ,s :w<CR>
nnoremap ,ss :wq<CR>
nnoremap ,ns :q!<CR>	
inoremap ,s <Esc>:w<CR>i
inoremap ,sa  <Esc>:wa<CR>

nnoremap ,vi :w<CR>:source ~/.vimrc<CR>"

echo Installing vim plugins
vim +PluginInstall +qall
vim +PluginUpdate +qall

cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer

cd ~/.vim/bundle/powerline
sudo python setup.py install 














