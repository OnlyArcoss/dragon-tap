FROM nginx:alpine

WORKDIR /app

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./public /usr/share/nginx/html

EXPOSE 4182

CMD ["nginx", "-g", "daemon off;"]
