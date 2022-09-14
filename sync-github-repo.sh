#!/bin/bash

syncingBranch=$1

git fetch upstream "${syncingBranch}"

git checkout -b "${syncingBranch}"

git rebase upstream/"${syncingBranch}"
