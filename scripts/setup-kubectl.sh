#!/bin/bash

# Define version
K8S_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

# Download binary and checksum
echo "Downloading kubectl $K8S_VERSION..."
curl -LO "https://dl.k8s.io/release/$K8S_VERSION/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$K8S_VERSION/bin/linux/amd64/kubectl.sha256"

# Validate checksum
if echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check --status; then
    echo "Checksum verified! Proceeding with installation..."
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    kubectl version --client
else
    echo "Checksum verification FAILED! Installation aborted."
    exit 1
fi

# Cleanup
rm kubectl kubectl.sha256
