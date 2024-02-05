#!/bin/bash
#Book Name: Cloud Native CI/CD with Tekton & ArgoCD
#Authors: Arunvel Arunachalam/ Ajay Arunachalam
#Purpose: Switching Kubernetes Context
#Tested on Ubuntu 22.04

# Get the current context
current_context=$(kubectl config current-context)

echo "Current Kubernetes context: $current_context"

# List available contexts
echo -e "\nAvailable contexts:"
kubectl config get-contexts -o name

# Prompt user to choose a context
read -p "Enter the name of the context to switch to: " new_context

# Switch to the chosen context
kubectl config use-context "$new_context"

# Verify the switch
echo -e "\nSwitched to context: $new_context"
kubectl config current-context
