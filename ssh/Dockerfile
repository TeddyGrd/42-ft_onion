FROM alpine:3.19

RUN apk update && apk add --no-cache \
    openssh-server \
    curl \
    bash

RUN mkdir -p /var/run/sshd

RUN ssh-keygen -A

RUN adduser -D user && passwd -u user

RUN mkdir -p /home/user/.ssh && \
    chown -R user:user /home/user/.ssh && \
    chmod 700 /home/user/.ssh

COPY sshd_config /etc/ssh/sshd_config

EXPOSE 4242

CMD ["/usr/sbin/sshd", "-D", "-e"]