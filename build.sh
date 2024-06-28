#!/bin/bash

# Télécharger MinIO (remplacer VERSION par la version souhaitée)
MINIO_VERSION="RELEASE.2024-XX-XX"  # Remplacer par une version spécifique
MINIO_URL="https://dl.minio.io/server/minio/release/${MINIO_VERSION}/minio.linux-amd64"

curl -LO "$MINIO_URL" || { echo "Échec du téléchargement de MinIO. Vérifiez la connexion Internet ou l'URL"; exit 1; }

# Extraire l'archive
tar -xzvf minio.linux-amd64

# Vérifier les permissions du répertoire de données
if [ ! -w "./data" ]; then
  echo "Le répertoire de données ./data n'est pas accessible en écriture. Ajustez les permissions."
  exit 1
fi

# Démarrer le serveur MinIO
./minio server --data-dir ./data
