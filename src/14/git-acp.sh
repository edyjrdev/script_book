#!/bin/bash -e
# git-ace = git add/commit/push

# test if current directory is inside Git 
if ! git rev-parse --is-inside-work-tree >& /dev/null; then
    echo "not in git repo, exit"
    exit 1
fi

# test if remote repo for current branch is set up
if ! git ls-remote >& /dev/null; then
    echo "no git remote, exit"
    exit 1
fi

# show all modified and new files
echo "Dry run:"
git add -A --dry-run

# ask for commit message
echo "Do you want to add and commit all files listed above?"
echo "Enter commit message or press return to exit."
echo -n "> "
read msg

# add (without --dry-run), commit, pull + push
if [[ $msg ]]; then
    git add -A
    git commit -m "$msg"
    git pull
    git push
else
    echo "exit"
fi
