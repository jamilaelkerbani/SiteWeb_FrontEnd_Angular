# Étape 1 : Construire l'application Angular
FROM node:19.0.0 as build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Étape 2 : Exposer l'application sur un serveur web
FROM nginx:alpine
COPY --from=build /usr/src/app/dist/* /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]