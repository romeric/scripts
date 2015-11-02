#!/bin/bash

# Change ~/VE to any oher directory of your choice where you have write privileges
cd ~/VE/
echo Downloading pypy
wget https://bitbucket.org/pypy/pypy/downloads/pypy-4.0.0-linux64.tar.bz2
echo Extracting tarball
tar -xf pypy-4.0.0-linux64.tar.bz2 

echo Making a virtual environment
virtualenv -p ~/VE/pypy-4.0.0-linux64/bin/pypy ~/VE/pypy_4_env --no-site-packages
echo Cloning numpypy
git clone https://bitbucket.org/pypy/numpy.git ~/VE/numpypy_4

echo Entering numpy
cd ~/VE/numpypy_4
echo Making a configuration file site.cfg for numpy to link against OpenBLAS 

printf "[DEFAULT]
library_dirs = /path/to/openblas/lib
include_dirs = /path/to/openblas/include

[atlas]
atlas_libs = openblas
libraries = openblas

[openblas]
libraries = openblas
library_dirs =  /path/to/openblas/lib
include_dirs =  /path/to/openblas/include" >> site.cfg

echo Activating virtual environment
source ~/VE/pypy_4_env/bin/activate

echo Building numpy
unset CPPFLAGS
unset LDFLAGS
python setup.py build --fcompiler=gnu95

python setup.py install 

echo Setuping up a few extra things, pip, yolk, ipython
pip install --upgrade pip 
pip install yolk 
pip install ipython
