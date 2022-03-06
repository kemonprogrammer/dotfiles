#!/bin/bash
cd $(git rev-parse --show-toplevel) # switch to git repo root
git config -f .gitmodules submodule.dotbot.ignore dirty # ignore dirty commits in the submodule
cp dotbot/tools/git-submodule/install .
touch install.conf.yaml
