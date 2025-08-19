# MEDI CENTER - Full Stack Project

Aplicacion para control medico gestionando doctores, pecientes y sus historias clinicas, reserva de citas, etc, desarrollado con una arquitectura por capas **Spring Boot**, **Angular**, **MySQL** y **Docker**.

## 📦 Estructura del Proyecto

```
fullstack-MediCenter/
├── medi-center-backend/         # Api para la gestion del sistema
├── medi-center-database/
│   └── sql/                     # Scripts y stored procedures
├── medi-center-docs/            # docuemntacion del proyecto
├── postman/
│   └── collection/              # Archivo para pruebas de api
├── medi-center-frontend/        # Interfaz de usuario (Angular)
├── docker-compose.yml
```

## 🚀 Tecnologías Usadas

- Spring Boot 3 (Java 21)
- Angular
- MySQL 8
- Docker + Docker Compose

## 🐳 Cómo levantar el proyecto

1. Clona el repositorio:

```bash
git clone https://github.com/jborbor/fullstack-MediCenterApp.git
cd fullstack-medicenter
```

2. Levanta los contenedores:

```bash
docker compose up --build
```

Esto levantará:

- La base de datos MySQL
- Ejecutara automaticamente los scripts de creacion de BD, stored procedures, etc:
- Los microservicios backend
- El frontend Angular (vía NGINX)

## 📦 Documentacion de laS api con OpenApi

http://localhost:8080/api/v1/swagger-ui/index.html

## 📬 Contacto

Proyecto desarrollado por [].
