# Etapa 1: Build de Angular
FROM node:20.19.0 AS builder

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build -- --configuration production

# Etapa 2: Servidor Nginx para producción
FROM nginx:alpine

# Copia el build a la carpeta que Nginx sirve
COPY --from=builder /app/dist/medi-center-frontend/browser /usr/share/nginx/html

# Opcional: reemplazar configuración por defecto de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]