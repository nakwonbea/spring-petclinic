#!/bin/bash

echo "Remove existed container"
docker compose -f /home/ubuntu/deploy/scripts/docker-compose.yml down || true
