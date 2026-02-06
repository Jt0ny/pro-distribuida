#!/bin/bash
# Script de verificación - Prueba que todo esté configurado correctamente

echo "=========================================="
echo "Verificación de Configuración"
echo "=========================================="
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para verificar
check() {
    local name="$1"
    local command="$2"
    local expected="$3"

    echo -n "Verificando $name... "
    if eval "$command" > /dev/null 2>&1; then
        echo -e "${GREEN}✅${NC}"
        return 0
    else
        echo -e "${RED}❌${NC}"
        return 1
    fi
}

echo "1. Verificando Docker:"
check "Docker disponible" "docker --version"
echo ""

echo "2. Verificando Contenedores:"
check "Contenedor dbserver" "docker ps | grep -q dbserver"
check "Contenedor consul" "docker ps | grep -q consul"
check "Contenedor proxy (traefik)" "docker ps | grep -q proxy"
check "Contenedor authors" "docker ps | grep -q authors"
check "Contenedor books" "docker ps | grep -q books"
check "Contenedor app-web-react" "docker ps | grep -q app-web-react"
echo ""

echo "3. Verificando Conectividad:"
check "PostgreSQL accesible" "nc -z localhost 54321"
check "Consul accesible" "nc -z localhost 8500"
check "Traefik accesible" "nc -z localhost 8888"
check "API accesible" "nc -z localhost 8070"
check "Web React accesible" "nc -z localhost 3000"
echo ""

echo "4. Verificando Servicios REST:"
check "Books API disponible" "curl -s http://localhost:8070/books > /dev/null"
check "Web React disponible" "curl -s http://localhost:3000 > /dev/null"
echo ""

echo "5. Verificando Archivos de Configuración:"
check "api-config.ts existe" "test -f app-web-react/src/config/api-config.ts"
check "Dockerfile existe" "test -f app-web-react/Dockerfile"
check "docker-compose.yml existe" "test -f deployment/book-store/docker-compose.yml"
echo ""

echo "=========================================="
echo "Verificación completada"
echo "=========================================="

