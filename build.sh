#!/bin/bash

# Configuration des variables d'environnement pour le serveur Minio
export MINIO_ROOT_USER=$(openssl rand -base64 12)
export MINIO_ROOT_PASSWORD=$(openssl rand -base64 12)
export HOST="0.0.0.0"
export PORT=9000
export CONSOLE_PORT=9090

# Créer un réseau Docker pour les conteneurs
docker network create minio-network

# Lancer le serveur Minio
docker run -d \
  --name minio-server \
  --network minio-network \
  -p $PORT:$PORT \
  -p $CONSOLE_PORT:$CONSOLE_PORT \
  -e MINIO_ROOT_USER=$MINIO_ROOT_USER \
  -e MINIO_ROOT_PASSWORD=$MINIO_ROOT_PASSWORD \
  -e HOST=$HOST \
  -e PORT=$PORT \
  -e CONSOLE_PORT=$CONSOLE_PORT \
  -v minio-data:/data \
  docker.io/minio/minio:latest \
  minio server /data --address $HOST:$PORT --console-address $HOST:$CONSOLE_PORT

# Attendre quelques secondes pour que le serveur Minio démarre
sleep 10

# Configuration des variables d'environnement pour la console Minio
export MINIO_CONSOLE_PORT=10000

# Construire l'image Docker pour la console Minio
docker build -t minio-console .

# Lancer la console Minio
docker run -d \
  --name minio-console \
  --network minio-network \
  -p $MINIO_CONSOLE_PORT:80 \
  -e MINIO_HOST=minio-server \
  -e MINIO_CONSOLE_PORT=$CONSOLE_PORT \
  minio-console
