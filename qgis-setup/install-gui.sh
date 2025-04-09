#!/bin/bash

echo "Updating system packages..."
sudo dnf update -y

echo "Installing GNOME Desktop Environment..."
sudo dnf groupinstall -y "Server with GUI"

echo "Setting graphical target as default..."
sudo systemctl set-default graphical.target

echo "Starting GNOME GUI..."
sudo systemctl isolate graphical.target

echo "Installing additional GNOME utilities..."
sudo dnf install -y gnome-terminal nautilus gnome-system-monitor

echo "GNOME installation and setup complete! Rebooting the system..."
sudo reboot

# Ask if RDP is needed
read -p "Do you need RDP access to the GUI? (y/n): " rdp_needed

if [ "$rdp_needed" != "y" ]; then
    echo "RDP access not needed. Exiting script..."
    exit 0
fi

# If RDP is needed, install xrdp and tigervnc-server
sudo dnf install -y epel-release
sudo dnf update -y
sudo dnf install -y xrdp tigervnc-server
sudo systemctl enable xrdp --now

# If firewall is enabled
sudo firewall-cmd --permanent --add-port=3389/tcp
sudo firewall-cmd --reload

# Configure SELinux to allow VNC connections
sudo dnf install -y policycoreutils-python-utils
sudo semanage port -a -t vnc_port_t -p tcp 3389

# Set GNOME as the default desktop environment for xrdp
echo "Configuring GNOME as the default session for xrdp..."
sudo sed -i 's|^test -x /etc/X11/Xsession && exec /etc/X11/Xsession|#&|' /etc/xrdp/startwm.sh
sudo sed -i 's|^exec /bin/sh /etc/X11/Xsession|#&|' /etc/xrdp/startwm.sh
echo "exec /usr/bin/gnome-session" | sudo tee -a /etc/xrdp/startwm.sh

sudo systemctl restart xrdp