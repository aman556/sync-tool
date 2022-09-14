#!/bin/bash

syncingBranch=$1

git fetch upstream

git checkout -b "${syncingBranch}"

git rebase "${syncingBranch}" remotes/upstream/"${syncingBranch}"
