@echo off
setlocal
cd /d "%~dp0"
set "DOCKER_HOST=npipe:////./pipe/dockerDesktopLinuxEngine"
set "DOCKER_CONFIG=%~dp0.docker-local"
docker compose -f docker-compose.local.yml ps
docker compose -f docker-compose.local.yml logs --tail=40
