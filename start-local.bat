@echo off
setlocal
cd /d "%~dp0"
set "DOCKER_HOST=npipe:////./pipe/dockerDesktopLinuxEngine"
set "DOCKER_CONFIG=%~dp0.docker-local"
docker desktop start
for /l %%i in (1,1,30) do (
    docker info --format "{{.ServerVersion}}" >nul 2>&1
    if not errorlevel 1 goto ready
    timeout /t 2 /nobreak >nul 2>&1
)
echo Docker Desktop is not ready. Wait for the Linux engine, then try again.
exit /b 1
:ready
docker compose -f docker-compose.local.yml up -d
if errorlevel 1 exit /b 1
echo Open the local port configured in docker-compose.local.yml or .env.
echo Default: http://127.0.0.1:3000
