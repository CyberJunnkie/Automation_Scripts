#!/bin/bash

apt upgrade
apt update
apt install default-jdk -y

# Set download URL
OPENFIRE_URL="https://github.com/igniterealtime/Openfire/releases/download/v4.5.5/openfire_4_5_5.tar.gz"

# Set installation directory
INSTALL_DIR="/opt/openfire"

# Create installation directory
sudo mkdir -p $INSTALL_DIR

# Download Openfire
echo "Downloading Openfire..."
sudo wget -O /tmp/openfire.tar.gz $OPENFIRE_URL

# Extract Openfire
echo "Extracting Openfire..."
sudo tar -xzvf /tmp/openfire.tar.gz -C $INSTALL_DIR --strip-components=1

# Create a symbolic link for easy access
sudo ln -s $INSTALL_DIR /opt/openfire


# Set ownership and permissions
#sudo chown -R openfire:openfire $INSTALL_DIR

# Start Openfire
echo "Starting Openfire..."
sudo  $INSTALL_DIR/bin/openfire start

# Clean up
rm /tmp/openfire.tar.gz

echo "Openfire has been installed and started successfully!"
echo "You can access the Openfire admin console at http://your_server_ip:9090"
