#!/usr/bin/env bash

pushd $(cd `dirname $0` && pwd)

# this will execute the etcaws with the current AWS user (assumes aws cli logged in)
# and updates the KUBECONFG
cd ../aws
echo "working in ...."
pwd

exec make ensureClusterCreated


popd