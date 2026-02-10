#!/bin/bash

sudo yum install -y \
  pass \

GPG_KEY_PATH="$HOME/key.asc"
GIT_REPO="git@github.com:kemonprogrammer/passwordstore.git"

echo "⚙️ Setting up password store..."

# Import and silence
gpg --import "$GPG_KEY_PATH" 

# Get Fingerprint
FINGERPRINT=$(gpg --with-colons --import-options show-only --import "$GPG_KEY_PATH" | awk -F: '$1 == "fpr" {print $10; exit}')

# Set Trust and silence
echo -e "trust\n5\ny\n" | gpg --command-fd 0 --edit-key "$FINGERPRINT" >/dev/null 2>&1

# Clone and Init
if [ ! -d "$HOME/.password-store" ]; then
    echo "Cloning git"
    git clone "$GIT_REPO" "$HOME/.password-store" >/dev/null 2>&1
fi

pass init "$FINGERPRINT" 

echo "✅ Setup Pass Done!"
