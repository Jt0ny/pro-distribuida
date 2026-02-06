@echo off
cd /d "%~dp0"
echo Deteniendo servicios...
docker-compose down
echo.
echo Levantando servicios...
docker-compose up -d
echo.
echo Esperando a que los servicios se inicien...
timeout /t 5 /nobreak
echo.
echo Estado de los contenedores:
docker ps
echo.
echo Accede a: http://localhost:3000
pause

