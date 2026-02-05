#!/bin/bash
# check if python3 installed

sudo yum install -y \
  pass \
  pass-import


# if ! command -v pimport &> /dev/null; then
#   echo "installing pass-import"
#   wget https://github.com/roddhjav/pass-import/releases/download/v3.5/pass-import-3.5.tar.gz
#   tar xzf pass-import-3.5.tar.gz
#   cd pass-import-3.5
#   sudo pip install .
# else
#   echo "pass-import is already installed system-wide."
# fi
