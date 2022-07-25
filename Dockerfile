FROM alpine

RUN apk add --no-cache bash rssh

RUN echo -e "easytoguess\easytoguess\n" | adduser -u 999 -h /home/data -s /usr/bin/rssh data

RUN echo -e "PasswordAuthentication no\n" >>/etc/ssh/sshd_config

ENV AUTHORIZED_KEYS_FILE /authorized_keys

RUN echo -e "allowscp\nallowsftp\n" >> /etc/rssh.conf

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /

CMD ["/entrypoint.sh"]
EXPOSE 22
VOLUME /home/data
VOLUME /var/local/etc/ssh
