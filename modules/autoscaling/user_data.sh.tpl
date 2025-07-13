#!/bin/bash
# Atualiza pacotes
apt-get update -y

# Instala Docker
apt-get install -y docker.io

# Habilita e inicia o serviço Docker
systemctl enable docker
systemctl start docker

# Executa o container
docker run -d -p 80:80 ${docker_image}