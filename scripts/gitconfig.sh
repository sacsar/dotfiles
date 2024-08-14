#!/bin/sh

# Do this via script in case it's been set by IT on a work machine
git config --global alias.adog "log --all --decorate --oneline --graph"
git config --global alias.alias-master-as-main "!git symbolic-ref refs/heads/main refs/heads/master && git symbolic-ref refs/remotes/origin/main refs/remotes/origin/master && git switch main"
