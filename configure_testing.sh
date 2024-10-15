#!/bin/bash

set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install a package using the appropriate package manager
install_package() {
    if command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y "$1"
    elif command_exists brew; then
        brew install "$1"
    else
        echo "Unable to install $1. Please install it manually."
        exit 1
    fi
}

# Check and install Go
if ! command_exists go; then
    echo "Installing Go..."
    install_package golang
fi

# Check and install Terraform
if ! command_exists terraform; then
    echo "Installing Terraform..."
    if command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
        curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
        sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
        sudo apt-get update && sudo apt-get install -y terraform
    elif command_exists brew; then
        brew tap hashicorp/tap
        brew install hashicorp/tap/terraform
    else
        echo "Unable to install Terraform. Please install it manually."
        exit 1
    fi
fi

# Check and install kubectl
if ! command_exists kubectl; then
    echo "Installing kubectl..."
    if command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl
        sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
        echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
        sudo apt-get update && sudo apt-get install -y kubectl
    elif command_exists brew; then
        brew install kubectl
    else
        echo "Unable to install kubectl. Please install it manually."
        exit 1
    fi
fi

# Check and install Kind
if ! command_exists kind; then
    echo "Installing Kind..."
    if command_exists go; then
        GO111MODULE="on" go install sigs.k8s.io/kind@latest
    else
        echo "Go is required to install Kind. Please install Go first."
        exit 1
    fi
fi

# Initialize Go module if go.mod doesn't exist
if [ ! -f "go.mod" ]; then
    echo "Initializing Go module..."
    go mod init github.com/kadreio/relativistic
fi

# Install Go dependencies
echo "Installing Go dependencies..."
go mod tidy

echo "All dependencies are installed and configured."
echo "You can now run the E2E tests using ./run_local_tests.sh"
