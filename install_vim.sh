#!/bin/bash

echo Removing currently installed vim packages
sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-common vim-gui-common
sudo rm -rf /usr/local/share/vim
sudo rm -rf /usr/share/vim
sudo rm /usr/bin/vim
dpkg -r vim

echo Installing deps such as lua, luajit, perl etc
sudo apt-get install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev mercurial libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev

echo Symlinking lualib.so
sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.1.so /usr/local/lib/liblua.so

echo Entering directory /usr/include/lua5.1/ 
cd /usr/include/lua5.1/
sudo mkdir include
sudo mv lauxlib.h luaconf.h lua.h lua.hpp lualib.h include/
echo Leaving directory /usr/include/lua5.1/ 

echo Entering home directory 
cd ~
echo Cloning vim mercurial
hg clone https://code.google.com/p/vim/
echo Entering directory ~/vim 
cd vim
make distclean


echo Running ./configure
./configure --with-features=huge \
			--enable-cscope \
            --enable-rubyinterp \
            --enable-largefile \
            --disable-netbeans \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --with-luajit \
	    	--enable-gui=auto \
            --enable-fail-if-missing \
            --with-lua-prefix=/usr/include/lua5.1 

echo Running make 
make

# uncomment in case you prefer VIMRUNTIMEDIR=/usr/share/vim/vim74  
# echo Running make with VIMRUNTIMEDIR=/usr/share/vim/vim74
# make VIMRUNTIMEDIR=/usr/share/vim/vim74

echo Running checkinstall
sudo checkinstall

echo cleaning the build directory
make distclean

# uncomment in case you prefer VIMRUNTIMEDIR=/usr/share/vim/vim74 
# echo Symlinking
# sudo ln -s /usr/local/share/vim/vim74 /usr/share/vim/vim74

# Run <:syntax on> in case vim74 directory has been symlinked.
# you may need to run it twice 
