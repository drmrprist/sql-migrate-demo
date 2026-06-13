#!/bin/bash
set -e
echo "Starting eShopOnWeb locally..."
git submodule update --init --recursive
cd docker
docker-compose -f docker-compose.onprem.yml up -d --build
cd ..
echo "Waiting 30 seconds for SQL Server to start..."
sleep 30
echo "App running at: http://localhost"
echo "To stop: docker-compose -f docker/docker-compose.onprem.yml down"
echo "To validate: python3 validation/reconciliation.py"
