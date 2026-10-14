
FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


.dockerignore
node_modules
dist
.git
.env


docker build -t crud-react .
docker run -d -p 8081:80 --name crud-container crud-react
