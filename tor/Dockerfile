from alpine:3.19

RUN apk update && apk add --no-cache \
    openssl \
    curl    \
    tor     \
    bash

RUN mkdir -p /var/lib/tor/hidden_service && \
    chmod 700 /var/lib/tor/hidden_service


COPY torrc /etc/tor/torrc

CMD ["tor"]