from alpine:3.19

RUN apk update && apk add --no-cache \
    openssh-server \
    curl    \
    bash

RUN mkdir -p /var/run/sshd

RUN ssh-keygen -A

COPY sshd_config /etc/ssh/sshd_config

RUN adduser -D user && echo "user:password" | chpasswd

EXPOSE 4242

CMD ["/usr/sbin/sshd", "-D", "-e"]