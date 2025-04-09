# Base image
FROM rockylinux:9

# Step 1: Install EPEL release
RUN dnf install -y epel-release

# Step 2: Update the system
RUN dnf update -y

ENV DEBIAN_FRONTEND=noninteractive

# Step 3: Install GNOME Desktop Environment
RUN dnf groupinstall -y "Server with GUI" --skip-broken

# Step 4: Install required packages in smaller groups
RUN dnf install -y wget unzip flatpak && \
dnf install -y python3 python3-pip java-11-openjdk gedit

# Install RDP
RUN dnf install -y xrdp tigervnc-server

# Enable graphical target
RUN systemctl set-default graphical.target

# Configure xrdp to use GNOME
RUN echo "exec /usr/bin/gnome-session" > /etc/skel/.xsession && \
mkdir -p /root/.config && \
echo "exec /usr/bin/gnome-session" > /root/.xsession

RUN curl -s "https://get.sdkman.io" | bash && \
bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install groovy"

# Configure Flatpak and install QGIS
RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && \
flatpak install -y flathub app/org.qgis.qgis/aarch64/stable


WORKDIR /root
RUN wget https://plugins.qgis.org/plugins/hrisk-noisemodelling-master/version/0.5.0/download/ -O hrisk-noisemodelling.zip && \
    unzip hrisk-noisemodelling.zip && \
    mv hrisk-noisemodelling-master hrisk-noisemodelling && \
    mkdir -p ~/.var/app/org.qgis.qgis/data/QGIS/QGIS3/profiles/default/python/plugins && \
    mv hrisk-noisemodelling ~/.var/app/org.qgis.qgis/data/QGIS/QGIS3/profiles/default/python/plugins/.

# Download and set up NoiseModelling
RUN wget https://github.com/Universite-Gustave-Eiffel/NoiseModelling/releases/download/v4.0.5/NoiseModelling_without_gui.zip && \
    unzip NoiseModelling_without_gui.zip -d NoiseModelling && \
    mkdir -p ~/.pfiles && \
    mv NoiseModelling ~/.pfiles/.

# Add environment variables to shell configuration
RUN echo "export NOISEMODELLING_HOME=/root/.pfiles/NoiseModelling/scriptrunner" >> ~/.bashrc && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.25.0.9-2.el9.aarch64" >> ~/.bashrc && \
    echo "export JAVA_FOR_NOISEMODELLING=/usr/lib/jvm/java-11-openjdk-11.0.25.0.9-2.el9.aarch64" >> ~/.bashrc && \
    echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc

RUN systemctl enable xrdp

# Set root password
RUN echo "root:123abc" | chpasswd

EXPOSE 3389

STOPSIGNAL SIGRTMIN+3
CMD ["/usr/sbin/init"]
