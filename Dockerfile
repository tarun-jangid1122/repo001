#build
FROM node:alpine as builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build
#server
FROM nginx:alpine
COPY Nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder  /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]