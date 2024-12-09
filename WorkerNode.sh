#!/bin/bash

# Update package list
sudo apt-get update -y

# Install Docker
sudo apt-get install docker.io -y

# Install necessary packages
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

# Add Kubernetes keyring and repository
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

# Update package list and install Kubernetes components
sudo apt-get update
sudo apt-get install -y kubectl kubeadm kubelet

#after join copy token which is present on master node at the end 
#sudo kubeadm join <MASTER_IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<HASH>

