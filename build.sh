#!/bin/bash

# Télécharger la dernière version de MinIO
MINIO_VERSION=$(curl -s https://dl.minio.io/server/minio/RELEASE.txt)
MINIO_DOWNLOAD_URL="https://dl.minio.io/server/minio/release/${MINIO_VERSION}/minio.linux-amd64"

curl -LO ${MINIO_DOWNLOAD_URL}

# Extraire l'archive téléchargée
tar -xzvf minio.linux-amd64

# Déplacer le binaire MinIO vers un emplacement permanent
sudo mv minio /usr/local/bin

# Créer un répertoire de données pour MinIO
sudo mkdir -p /data/minio

# Définir les permissions pour le répertoire de données
sudo chown -R 1000:1000 /data/minio

# Initialiser MinIO avec un accès complet
sudo /usr/local/bin/minio server --config-file /data/minio/config.json --data-dir /data/minio

# (Facultatif) Définir un alias pour lancer MinIO plus facilement
echo "alias minio='sudo /usr/local/bin/minio server --config-file /data/minio/config.json --data-dir /data/minio'" >> ~/.bashrc
