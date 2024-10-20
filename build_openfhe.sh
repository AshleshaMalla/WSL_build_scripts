#!/bin/bash

# --- Set env vars
INSTALL_PREFIX="~/software/openfhe"
CORES=$(( $(nproc) - 2 ))

# --- Move to tmp dir
cd $TMPDIR

# --- Clone repo
rm -rf openfhe-development # nuke repo
if [ ! -d "openfhe-development" ]; then
  git clone git@github.com:openfheorg/openfhe-development.git
fi
cd openfhe-development

# --- Update submods, checkout release
git submodule update --init --recursive
git checkout tags/v1.2.1

# --- Setup build dir
rm -rf build
mkdir build
cd build

# --- Configure
#$export CC=clang
#$export CXX=clang++

cmake \
  -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
  ../

# --- Compile
make -j $CORES

# --- Install into prefix
make install -j $CORES
