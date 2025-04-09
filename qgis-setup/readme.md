# Scripts for setting up QGIS on Rocky 9.4
The scripts in this directroy can help you to setup QGIS on Rocky 9.4. The scripts are tested on Rocky 9.4 and QGIS 3.22.3.

The following scripts are available:
1. [install_gui.sh](install_gui.sh): This script installs the GUI on Rocky 9.4. Only needed if you do not have a GUI installed already.
2. [setup_qgis_env.sh](setup_qgis_env.sh): This script sets up the QGIS and required dependencies on Rocky 9.4. It also sets up the environment variables for QGIS.

## What is installed by the scripts
The scripts install the following packages:
1. Python3
2. Java
3. Groovy
4. QGIS 
5. H-RISK Plugin
6. NoiseModelling without GUI

The scripts also set up the environment variables for QGIS.
1. JAVA_FOR_NOISEMODELLING
2. NOISEMODELLING_HOME

> The script installs noise modelling in ~/.pfiles directory. You can change the installation directory by changing the setup_qgis_env.sh script.

> H-RISK Plugin is installed but may not be enabled by default. You can enable it from the QGIS Plugin Manager.

## How to use the scripts

If you do not have a GUI installed on Rocky 9.4, you can run the following command to install the GUI:
```bash
./install_gui.sh
```

After installing the GUI, you can run the following command to setup QGIS and required dependencies:
```bash
./setup_qgis_env.sh
```

> While installing QGIS, script will ask if you want to install latest version or LTS version of QGIS. You can select the version you want to install.

