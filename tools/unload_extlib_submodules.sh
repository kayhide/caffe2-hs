#!/usr/bin/env bash

set -ex

PYTORCH_ROOT=$(pwd)/extlib/pytorch
PYTORCH_THIRD_PARTY_DIR=$PYTORCH_ROOT/third_party

pushd $PYTORCH_ROOT

rm -rf $PYTORCH_THIRD_PARTY_DIR
git reset --hard HEAD

popd
