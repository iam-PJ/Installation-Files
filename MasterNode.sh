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

# Initialize Kubernetes cluster
sudo kubeadm init --ignore-preflight-errors=all

# Set up kubectl for the current user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Apply the Calico network plugin
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml

# Generate and print the join command
echo "Worker join command:"
kubeadm token create --print-join-command
