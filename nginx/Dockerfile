from alpine:3.19

RUN apk update && apk add --no-cache \
    nginx   \
    openssl \
    curl    \
    bash

RUN mkdir -p /run/nginx && \
    mkdir -p /var/www/html && \
    chown -R nginx:nginx /var/www/html

COPY nginx.conf /etc/nginx/http.d/default.conf
COPY index.html /var/www/onion/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]