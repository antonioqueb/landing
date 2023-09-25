# Fase de construcción
FROM node:18.14.1 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

# Copia el resto de tus archivos
COPY . .

# Construye tu aplicación Astro
RUN npm run build

# Fase de producción
FROM nginx:alpine

# Copia los archivos estáticos construidos a la imagen de Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Puedes incluir una configuración personalizada para Nginx si lo deseas
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
