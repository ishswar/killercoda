#!/bin/bash

apt-get install tree -y

# Define Miniconda installation directory
MINICONDA_DIR="$HOME/miniconda3"

# Install Miniconda if not already installed
if [ ! -d "$MINICONDA_DIR" ]; then
    echo "Installing Miniconda..."
    curl -fsSL -o Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b -p "$MINICONDA_DIR"
    rm Miniconda3-latest-Linux-x86_64.sh
else
    echo "Miniconda is already installed."
fi

# Initialize Conda for the current shell session
source "$MINICONDA_DIR/etc/profile.d/conda.sh"
conda init bash

# Create conda environment if it doesn't exist
if conda info --envs | grep -q "^mcp_env "; then
    echo "Conda environment 'mcp_env' already exists."
else
    echo "Creating Conda environment 'mcp_env' with Python 3.11..."
    conda create -y -n mcp_env python=3.11
fi

# Activate the environment
conda activate mcp_env
echo "conda activate mcp_env" >> ~/.bashrc
echo "Setup complete. The 'mcp_env' environment will be activated by default in new shell sessions."

# Install MCP CLI
echo "Installing MCP CLI..."
pip install -U "mcp[cli]"

# Install Java 24
echo "Installing Java 24..."
wget https://download.oracle.com/java/24/latest/jdk-24_linux-x64_bin.deb -O /tmp/jdk-24.deb
apt-get install -y ./tmp/jdk-24.deb

# Set JAVA_HOME (optional but useful)
echo 'export JAVA_HOME=/usr/lib/jvm/jdk-24' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
export JAVA_HOME=/usr/lib/jvm/jdk-24
export PATH=$JAVA_HOME/bin:$PATH

# Verify Java installation
java -version

# Install Maven
echo "Installing Maven..."
apt-get install -y maven

# Verify Maven installation
mvn -version

touch /tmp/background0
