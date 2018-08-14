#!/usr/bin/env bash

set -ex

# Install library dependencies
brew bundle --file=- <<-EOS
brew "cmake"
brew "snappy"
brew "leveldb"
brew "gflags"
brew "glog"
brew "lmdb"
brew "protobuf"
brew "opencv"
EOS

# Update all git submodules
git submodule update --init --recursive


PYTORCH_ROOT=$(pwd)/extlib/pytorch
PYTORCH_BUILD_DIR=$PYTORCH_ROOT/build
PYTORCH_INSTALL_DIR=$PYTORCH_BUILD_DIR/install

pushd $PYTORCH_ROOT

rm -rf $PYTORCH_BUILD_DIR
mkdir $PYTORCH_BUILD_DIR
pushd $PYTORCH_BUILD_DIR

cmake -DCMAKE_INSTALL_PREFIX=$PYTORCH_INSTALL_DIR -DBUILD_PYTHON=OFF -DBUILD_CUSTOM_PROTOBUF=OFF -DUSE_CUDA=OFF ..
make
make install

pushd $PYTORCH_INSTALL_DIR/lib
install_name_tool -id $(pwd)/libcaffe2.dylib libcaffe2.dylib
popd

popd

popd
