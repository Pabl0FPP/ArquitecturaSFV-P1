# usar una imagen base de Node.js
FROM node:18

# establecer el directorio de trabajo
WORKDIR /app

# copiar los archivos package.json y package-lock.json
COPY package*.json ./

# instalar dependencias
RUN npm install

# copiar el resto de los archivos de la aplicación
COPY . .

# exponer el puerto 3000
EXPOSE 3000

# comando para iniciar la aplicación
CMD ["npm", "start"] 