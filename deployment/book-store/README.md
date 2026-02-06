# Docker Compose - Book Store Architecture

## 🏗️ Arquitectura de Servicios

```
┌─────────────────────────────────────────────────────────────┐
│                     TRAEFIK (Proxy)                         │
│                    Port: 8080, 8888                         │
└─────────────────────────────────────────────────────────────┘
        ↑           ↑           ↑           ↑
        │           │           │           │
   ┌────┴────┐  ┌──┴──┐  ┌────┴─────┐  ┌──┴───────┐
   │ Authors │  │Books│  │ Consul   │  │App-React │
   │ 8070    │  │8070 │  │ 8500     │  │ 3000/80  │
   └─────────┘  └─────┘  └──────────┘  └──────────┘
        ↓           ↓
   ┌────────────────────────┐
   │  PostgreSQL (DB)       │
   │  Port: 54321:5432      │
   └────────────────────────┘
```

## 📝 Servicios Configurados

### 1. **dbserver** (PostgreSQL)
```yaml
- Imagen: postgres:17.7-alpine3.23
- Puerto: 54321:5432
- BD: books-db
- Usuario: postgres
- Contraseña: 1234
- Volumen: c:/db-distribuida
```

### 2. **consul** (Service Discovery)
```yaml
- Imagen: consul:1.15.4
- Puerto: 8500:8500
- Modo: dev (desarrollo)
- UI: http://localhost:8500
```

### 3. **proxy** (Traefik - Balanceador)
```yaml
- Imagen: traefik:3.6.6
- Puerto Dashboard: 8888:8080
- Puerto API: 8080:80
- Descubrimiento: Consul
```

### 4. **authors** (Microservicio)
```yaml
- Imagen: anthonyjoel/app-authors
- Puerto: 8070 (interno)
- BD: PostgreSQL
- Service Discovery: Consul
- Replicas: 1
```

### 5. **books** (Microservicio)
```yaml
- Imagen: anthonyjoel/app-books
- Puerto: 8070 (interno)
- BD: PostgreSQL
- Service Discovery: Consul
- Replicas: 1
```

### 6. **app-web-react** (Frontend)
```yaml
- Build: Dockerfile local
- Puerto: 3000:80
- Traefik: Habilitado
- API Base URL: http://localhost:8888
- Rutas: PathPrefix(/) -> Frontend
```

## 🚀 Cómo Ejecutar

### Opción 1: Build Local + Docker Compose
```bash
cd deployment/book-store

# Construir imagen de React
docker build -t app-web-react:latest ../../app-web-react

# Ejecutar todo
docker-compose up -d
```

### Opción 2: Solo Docker Compose (build automático)
```bash
cd deployment/book-store
docker-compose up -d
```

## 🌐 Acceso a Servicios

| Servicio | URL | Descripción |
|----------|-----|-------------|
| **Frontend** | http://localhost:3000 | App React |
| **Traefik Dashboard** | http://localhost:8888 | Dashboard de enrutamiento |
| **Consul UI** | http://localhost:8500 | Service Discovery |
| **PostgreSQL** | localhost:54321 | Base de datos |
| **API (Authors)** | http://localhost:8080/authors | Microservicio Autores |
| **API (Books)** | http://localhost:8080/books | Microservicio Libros |

## 🔌 Comunicación entre Servicios

### Desde React a la API
```typescript
// En el navegador (localhost)
const response = await fetch('http://localhost:8888/books');

// Dentro del contenedor (nombres de servicios)
const response = await fetch('http://proxy:8080/books');
```

### Variables de Entorno para React
```env
VITE_API_BASE_URL=http://localhost:8888
```

## 📋 Comandos Útiles

### Ver logs
```bash
# Todos los servicios
docker-compose logs -f

# Servicio específico
docker-compose logs -f app-web-react

# Últimas 50 líneas
docker-compose logs --tail=50 app-web-react
```

### Detener servicios
```bash
# Detener todo
docker-compose down

# Detener y eliminar volúmenes
docker-compose down -v
```

### Reconstruir servicios
```bash
# Reconstruir app-web-react
docker-compose up -d --build app-web-react

# Reconstruir todo
docker-compose up -d --build
```

### Ver estado
```bash
# Ver contenedores corriendo
docker-compose ps

# Ver configuración actual
docker-compose config
```

## 🔧 Configuración de Traefik

### Rutas Configuradas
```
/ -> app-web-react (Frontend)
```

### Service Discovery
- Traefik busca servicios en Consul
- Puerto de Consul: 8500
- Intervalo de refresh: 5s
- Solo servicios con label `traefik.enable=true`

## 🔐 Seguridad

**Nota**: Esto es una configuración de desarrollo. Para producción:

1. **Cambiar contraseña de PostgreSQL**
2. **Cambiar POSTGRES_USER**
3. **Habilitar Traefik insecure=false**
4. **Configurar HTTPS/TLS**
5. **Usar secrets en lugar de environment**
6. **Limitar acceso a puertos innecesarios**

Ejemplo de seguridad:
```yaml
environment:
  POSTGRES_PASSWORD_FILE: /run/secrets/db_password
secrets:
  db_password:
    file: ./secrets/db_password.txt
```

## 📊 Dependencias entre Servicios

```
proxy
  ├── consul
  └── app-web-react
       └── proxy

authors
  └── dbserver

books
  ├── dbserver
  └── authors
```

## 🐛 Troubleshooting

### Puerto ya está en uso
```bash
# Ver qué proceso usa el puerto 3000
netstat -ano | findstr :3000

# Cambiar puerto en docker-compose.yml
ports:
  - 3001:80  # Cambiar a 3001
```

### Base de datos no se conecta
```bash
# Verificar estado de dbserver
docker-compose logs dbserver

# Reiniciar servicio de BD
docker-compose restart dbserver
```

### Frontend no se comunica con API
```bash
# Verificar que Traefik esté corriendo
docker-compose logs proxy

# Verificar que la URL sea correcta
VITE_API_BASE_URL=http://localhost:8888

# Desde el contenedor usar nombre del servicio
VITE_API_BASE_URL=http://proxy:8080
```

### Limpiar todo y empezar de nuevo
```bash
# Detener y eliminar
docker-compose down -v

# Limpiar imágenes no usadas
docker image prune -a

# Volver a crear
docker-compose up -d
```

## 📈 Escalado (Opcional)

Para escalar servicios:
```yaml
authors:
  deploy:
    replicas: 3  # 3 instancias

books:
  deploy:
    replicas: 2  # 2 instancias
```

Traefik balanceará automáticamente entre replicas.

## 💾 Persistencia de Datos

Los datos de PostgreSQL se guardan en:
```
c:/db-distribuida
```

Para usar una ruta diferente, editar:
```yaml
volumes:
  - "c:/db-distribuida:/var/lib/postgresql/data"
  # Cambiar c:/db-distribuida a tu ruta
```

## ✅ Checklist de Verificación

- [ ] Docker está instalado y corriendo
- [ ] Puertos 3000, 8080, 8888, 8500, 54321 están disponibles
- [ ] Archivo docker-compose.yml está en deployment/book-store/
- [ ] Dockerfile de React está en app-web-react/
- [ ] Volumen c:/db-distribuida existe o Docker puede crearlo
- [ ] `docker-compose up -d` ejecuta sin errores
- [ ] Todos los servicios muestran "Up" en `docker-compose ps`
- [ ] http://localhost:3000 carga la aplicación React
- [ ] http://localhost:8888 muestra el dashboard de Traefik
- [ ] Las llamadas API desde React funcionan

---

**Última actualización**: 2026-02-05
**Versión**: 1.0

