#!/bin/bash


# Download and install llvm
echo Entering directory $HOME
cd ~
# Change the version if needed (numba is not compatible with every version)
echo Downloading LLVM
wget http://llvm.org/releases/3.6.1/clang+llvm-3.6.1-x86_64-linux-gnu-ubuntu-14.04.tar.xz 

echo Entering directory clang+llvm-3.6.1-x86_64-linux-gnu-ubuntu-14.04
cd clang+llvm-3.6.1-x86_64-linux-gnu-ubuntu-14.04
echo Installing clang+llvm 
sudo cp -R * /usr/local/


echo Installing dependencies
sudo apt-get install libedit-dev
# needed for python2.7
sudo pip install enum34

cd ~ 
echo Cloning llvmlite repository
git clone https://github.com/numba/llvmlite

echo Entering directory llvmlite
cd llvmlite
echo Building and Installing llvmlite
sudo python setup.py build
sudo python setup.py install

cd ~
echo Cloning numba repository
git clone https://github.com/numba/numba
echo Entering directory numba 
cd numba
echo Building and Installing numba
sudo pip install -r requirements.txt
sudo python setup.py build_ext --inplace
sudo python setup.py install
