#!/bin/bash

upstream=$1
syncingBranch=$2

git fetch "${upstream}" "${upstream}"/"${syncingBranch}"

git checkout -b "${syncingBranch}"

git rebase "${upstream}"/"${syncingBranch}"/"${syncingBranch}"
