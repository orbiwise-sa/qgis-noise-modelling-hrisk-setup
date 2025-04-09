#!/bin/bash

# Exit immediately if any command fails
set -e

# 1. Install epel-release
echo "Installing EPEL release..."
sudo dnf install -y epel-release

# 2. Update the system
echo "Updating the system..."
sudo dnf update -y

# 3. Install Python 3 and pip
echo "Installing Python 3 and pip..."
sudo dnf install -y python3 python3-pip

# 4. Install Java (OpenJDK 11) and set up JAVA_HOME
echo "Installing OpenJDK 11..."
sudo dnf install -y java-11-openjdk

echo "Setting up JAVA_HOME dynamically..."
# Add JAVA_HOME to .bashrc with a dynamic lookup
echo 'export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

# Source .bashrc to apply the JAVA_HOME in the current session
source ~/.bashrc

# Verify JAVA_HOME is set
echo "JAVA_HOME is set to: $JAVA_HOME"

# 5. Install SDKMAN! and use it to install Groovy
echo "Installing SDKMAN!..."
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

echo "Installing Groovy via SDKMAN!..."
sdk install groovy

# Verify Groovy installation
echo "Groovy version:"
groovy --version

# 6. Install Flatpak
echo "Installing Flatpak..."
sudo dnf install -y flatpak

# Add Flathub repository for Flatpak
echo "Adding Flathub repository for Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# 7. Install QGIS using Flatpak (prompt user for version selection)
echo "Installing QGIS via Flatpak."
sudo flatpak install -y flathub org.qgis.qgis

# 8. Install HRISK Plugin
echo "Installing HRISK plugin for QGIS..."
wget https://plugins.qgis.org/plugins/hrisk-noisemodelling-master/version/0.5.0/download/ -O hrisk-noisemodelling.zip
unzip hrisk-noisemodelling.zip
mv hrisk-noisemodelling-master hrisk-noisemodelling
mv hrisk-noisemodelling ~/.var/app/org.qgis.qgis/data/QGIS/QGIS3/profiles/default/python/plugins/.

# 9. Download, build, and install NoiseModelling
echo "Setting up NoiseModelling..."

# Clone NoiseModelling repository
wget https://github.com/Universite-Gustave-Eiffel/NoiseModelling/releases/download/v4.0.5/NoiseModelling_without_gui.zip
unzip NoiseModelling_without_gui.zip -d NoiseModelling
mkdir -p ~/.pfiles
mv NoiseModelling ~/.pfiles/.

# set NOISEMODELLING_HOME
echo 'export NOISEMODELLING_HOME=~/.pfiles/NoiseModelling/scriptrunner' >> ~/.bashrc

# set JAVA_FOR_NOISEMODELLING
echo 'export JAVA_FOR_NOISEMODELLING=$JAVA_HOME' >> ~/.bashrc

source ~/.bashrc

# Done
echo "Setup complete. Please restart your terminal session to apply changes."