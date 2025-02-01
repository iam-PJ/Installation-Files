#!/bin/bash

# Update package lists and install required dependencies
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

# Download and add the HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Verify the fingerprint of the key (optional but recommended)
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

# Add the HashiCorp repository to the system sources list
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package lists again to include HashiCorp repo
sudo apt update

# Install Terraform
sudo apt-get install -y terraform

# Verify installation
terraform -version

