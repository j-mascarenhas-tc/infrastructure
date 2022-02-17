#!/bin/bash
echo cleaning images, containers, networks
docker system prune -af
echo cleaning volumes
docker volume prune -f