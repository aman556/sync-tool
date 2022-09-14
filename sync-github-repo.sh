#!/bin/bash

syncingBranch=$1

git fetch upstream upstream/"${syncingBranch}"

git checkout -b "${syncingBranch}"

git rebase upstream/"${syncingBranch}"/"${syncingBranch}"
