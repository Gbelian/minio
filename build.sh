#!/bin/bash

# Download MinIO binary
echo "Downloading MinIO binary..."
curl -LO https://dl.min.io/server/minio/release/LATEST/minio.linux-amd64

# Extract MinIO binary
echo "Extracting MinIO binary..."
tar -xzvf minio.linux-amd64

# Verify extraction success
if [ ! -f ./minio ]; then
    echo "Error: MinIO binary not found after extraction."
    exit 1
fi

# Give executable permission to MinIO binary
chmod +x minio

# Start MinIO server
echo "Starting MinIO server..."
./minio server --data-dir ./data
