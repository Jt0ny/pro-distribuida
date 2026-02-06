# Configuración Completada - App Web React + API Books

## 📋 Resumen de Cambios

### 1. **Dockerfile de app-web-react** (app-web-react/Dockerfile)
✅ Configurado para inyectar variables de entorno en **tiempo de ejecución**
- Stage 1: Construye la aplicación React con Node
- Stage 2: Sirve con Nginx Alpine
- CMD: Genera `config.js` dinámicamente con la URL de la API
- Soporta la variable `VITE_API_BASE_URL`

### 2. **Configuración de API en Runtime** (app-web-react/src/config/api-config.ts)
✅ Nuevo archivo que obtiene la URL de la API
- Lee desde `window.__APP_CONFIG__.API_BASE_URL` (inyectado en runtime)
- Fallback a `import.meta.env.VITE_API_BASE_URL` (buildtime)
- Fallback por defecto a `http://localhost:8888`

### 3. **index.html Actualizado**
✅ Carga `config.js` antes de que React se inicialice
- Permite configuración dinámica de la URL de API

### 4. **Páginas de React Actualizadas**
✅ BooksPage.tsx: Usa `getAPIBaseURL()` en lugar de `import.meta.env`
✅ BooksDetallePage.tsx: Usa `getAPIBaseURL()` en ambos métodos

### 5. **docker-compose.yml Configurado**
✅ Variable de entorno: `VITE_API_BASE_URL: http://books:8070/books`
✅ Flyway activado en ambos servicios (authors y books):
  - `QUARKUS_FLYWAY_ACTIVE: "true"`
  - `QUARKUS_FLYWAY_MIGRATE_AT_START: "true"`
✅ Traefik configurado para enrutamiento correcto
✅ Dependencias correctas entre servicios

---

## 🚀 Cómo Usar

### Opción 1: Ejecutar el script batch
```bash
cd deployment\book-store
start.bat
```

### Opción 2: Comandos manuales
```bash
cd deployment\book-store
docker-compose down
docker-compose up -d
```

### Opción 3: Con logs en vivo
```bash
cd deployment\book-store
docker-compose up
```

---

## 🌐 Acceso a la Aplicación

Una vez levantados los servicios, accede a:
- **Web**: http://localhost:3000
- **API (directo)**: http://localhost:8070/books
- **Traefik Dashboard**: http://localhost:8888
- **Consul**: http://localhost:8500

---

## 📊 Estructura de Servicios

```
┌─────────────────────────────────────────────────────┐
│         app-web-react (Port 3000)                   │
│         React + Nginx                               │
│   VITE_API_BASE_URL: http://books:8070/books       │
└────────────────────┬────────────────────────────────┘
                     │ HTTP Calls
                     ▼
┌─────────────────────────────────────────────────────┐
│         books Service (Port 8070)                   │
│         Quarkus Java + PostgreSQL                   │
│   - Endpoints: /books, /books/{isbn}               │
│   - Flyway migrations enabled                       │
└────────────────┬───────────────────┬────────────────┘
                 │                   │
                 │ Depends on        │ Depends on
                 ▼                   ▼
         ┌──────────────┐     ┌──────────────┐
         │  authors     │     │  PostgreSQL  │
         │  (Port 8070) │     │  (Port 5432) │
         └──────────────┘     └──────────────┘
```

---

## ✅ Checklist de Funcionalidad

- [x] Imagen Docker construida correctamente
- [x] Dockerfile con inyección de variables en runtime
- [x] Configuración dinámica de URL de API
- [x] Flyway activado para migraciones
- [x] Traefik configurado para enrutamiento
- [x] Consul para service discovery
- [x] PostgreSQL para persistencia
- [x] app-web-react se conecta a books API

---

## 🔧 Solución de Problemas

### Si los datos no cargan:
1. Verifica que los servicios estén levantados: `docker ps`
2. Revisa los logs: `docker logs book-store-books-1`
3. Verifica la conectividad: `docker exec book-store-books-1 curl -s http://books:8070/books`
4. Abre la consola del navegador (F12) para ver errores de red

### Si la BD no se conecta:
1. Verifica que PostgreSQL esté corriendo: `docker logs book-store-dbserver-1`
2. Verifica el volumen: `docker volume ls`
3. Limpia y reinicia: `docker-compose down -v && docker-compose up -d`

### Si el API no responde:
1. Verifica que books esté registrado en Consul
2. Revisa los logs de Traefik: `docker logs book-store-proxy-1`
3. Prueba directamente: `curl http://localhost:8070/books`

---

## 📝 Variables de Entorno

La URL de la API se configura a través de: `VITE_API_BASE_URL=http://books:8070/books`

Esta variable se inyecta en `config.js` que es leído por React en runtime.

---

Última actualización: 2026-02-05

