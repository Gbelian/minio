#!/bin/bash
curl -LO https://dl.minio.io/server/minio/release/LATEST/minio.linux-amd64
tar -xzvf minio.linux-amd64
./minio server --data-dir ./data
