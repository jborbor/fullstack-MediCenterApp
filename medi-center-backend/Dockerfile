# Etapa 1: construir el proyecto con Maven
# Etapa 1: build con Maven
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Etapa 2: imagen final
FROM eclipse-temurin:21
WORKDIR /app

# Copiamos el JAR y el script de espera
COPY --from=build /app/target/*.jar app.jar
COPY wait-for-it.sh wait-for-it.sh
RUN chmod +x wait-for-it.sh

# Esperar a que MySQL esté disponible en el puerto 3306 antes de arrancar
ENTRYPOINT ["./wait-for-it.sh", "mysql:3306", "--timeout=200", "--", "java", "-jar", "app.jar"]