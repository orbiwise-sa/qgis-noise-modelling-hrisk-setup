# Install docker on Rocky 9.4

```bash
# Install Docker
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker

# Add user to docker group
sudo usermod -aG docker $USER

```

or just run
    
```bash
./install-docker-rocky-9.4.sh
```

# Build docker image

Run `mkdocker` file

```bash
chmod +x mkdocker
./mkdocker
```

Or run the following command

```bash
docker build -t rocky-qgis-noisemodelling .
```

# Run docker image

```bash
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix rocky-qgis-noisemodelling
```

Exposing port 3389
    
    ```bash
    docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -p 3389:3389 rocky-qgis-noisemodelling
    ```

