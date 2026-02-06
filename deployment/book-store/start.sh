#!/bin/bash
echo ""
echo "  docker logs book-store-authors-1"
echo "  docker logs book-store-books-1"
echo "  docker logs book-store-app-web-react-1"
echo "Para ver los logs:"
echo ""
echo "- Consul:            http://localhost:8500"
echo "- Traefik Dashboard: http://localhost:8888"
echo "- API (directo):     http://localhost:8070/books"
echo "- Web:               http://localhost:3000"
echo "Acceso a los servicios:"
echo ""
echo "================================"
echo "✅ Servicios iniciados"
echo "================================"
echo ""

docker ps
echo "5. Estado de los contenedores:"
echo ""

sleep 5
echo "4. Esperando a que los servicios se inicien..."
echo ""

docker-compose up -d
echo "3. Levantando servicios..."
echo ""

# docker-compose down -v
echo "2. Limpiando volúmenes (opcional, descomenta si necesitas reiniciar BD)..."
echo ""

docker-compose down
echo "1. Deteniendo servicios anteriores..."

cd "$(dirname "$0")"
# Navegar al directorio correcto

echo ""
echo "================================"
echo "Iniciando servicios Docker"
echo "================================"

# Script para levantar los servicios en Linux/Mac

