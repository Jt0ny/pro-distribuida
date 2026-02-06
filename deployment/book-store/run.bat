@echo off
REM Script para gestionar el Docker Compose del proyecto

setlocal enabledelayedexpansion

cd /d "%~dp0"

echo.
echo ====================================
echo   Book Store - Docker Compose
echo ====================================
echo.

if "%1"=="" (
    echo Uso: run.bat [comando]
    echo.
    echo Comandos disponibles:
    echo   up          - Iniciar todos los servicios
    echo   down        - Detener todos los servicios
    echo   build       - Construir imagenes
    echo   logs        - Ver logs en tiempo real
    echo   ps          - Ver estado de contenedores
    echo   restart     - Reiniciar servicios
    echo   clean       - Limpiar todo (elimina volúmenes)
    echo   help        - Mostrar esta ayuda
    echo.
    exit /b 1
)

if "%1"=="up" (
    echo Iniciando servicios...
    docker-compose up -d
    echo.
    echo ✓ Servicios iniciados
    echo.
    echo URLs disponibles:
    echo   Frontend:     http://localhost:3000
    echo   Traefik:      http://localhost:8888
    echo   Consul:       http://localhost:8500
    echo   PostgreSQL:   localhost:54321
    echo.
    goto end
)

if "%1"=="down" (
    echo Deteniendo servicios...
    docker-compose down
    echo ✓ Servicios detenidos
    goto end
)

if "%1"=="build" (
    echo Construyendo imagenes...
    docker-compose build
    echo ✓ Imagenes construidas
    goto end
)

if "%1"=="logs" (
    echo Mostrando logs (Ctrl+C para salir)...
    docker-compose logs -f
    goto end
)

if "%1"=="ps" (
    echo Estado de contenedores:
    echo.
    docker-compose ps
    goto end
)

if "%1"=="restart" (
    echo Reiniciando servicios...
    docker-compose restart
    echo ✓ Servicios reiniciados
    goto end
)

if "%1"=="clean" (
    echo ADVERTENCIA: Se eliminarán todos los volúmenes y datos!
    set /p confirm="¿Estás seguro? (s/n): "
    if /i "!confirm!"=="s" (
        docker-compose down -v
        echo ✓ Todo limpiado
    ) else (
        echo Cancelado
    )
    goto end
)

if "%1"=="help" (
    echo.
    echo ====================================
    echo   Ayuda - Docker Compose
    echo ====================================
    echo.
    echo Servicios disponibles:
    echo   - PostgreSQL (54321:5432)
    echo   - Consul (8500:8500)
    echo   - Traefik (8888:8080, 8080:80)
    echo   - Authors API (interno)
    echo   - Books API (interno)
    echo   - App Web React (3000:80)
    echo.
    echo Logs útiles:
    echo   docker-compose logs app-web-react
    echo   docker-compose logs proxy
    echo   docker-compose logs books
    echo.
    echo Ejecutar contenedor:
    echo   docker-compose exec app-web-react sh
    echo.
    goto end
)

echo Error: Comando desconocido "%1%"
exit /b 1

:end
echo.

