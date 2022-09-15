#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

upstreamRepo=$1
upstreamBranch=$2
midstreamRepo=$3
midstreamBranch=$4

tmp_dir=$(mktemp -d -t syncrepo)

cd "${tmp_dir}" || exit

git clone "${midstreamRepo}"

midstreamRepoName=$(ls)
cd "${midstreamRepoName}" || exit

git remote add upstream "${upstreamRepo}"

git fetch upstream "${upstreamBranch}"

# checkout to downstream branch and creating if not exist
git checkout "${midstreamBranch}" || git checkout -b "${midstreamBranch}"

# Only covered the case when upstream is ahead of midstream
# ToDo: Cover the below case
#       - When midstream and upstream both have some commits 
#         then have to resolve the merge conflicts first
if [ -n "$(git diff remotes/upstream/"${upstreamBranch}" "${midstreamBranch}")" ]
then
    git merge remotes/upstream/"${upstreamBranch}"
    git push "${midstreamRepo}" "${midstreamBranch}"
else
    echo "Both branches are already Synced."
fi

rm -rf "${tmp_dir}"
