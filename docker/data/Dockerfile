FROM alpine

RUN mkdir -p /var/www
RUN mkdir /logs

RUN chmod -R 777 /var/www
RUN chmod -R 777 /logs

# on déclare les volumes
VOLUME /var/www
VOLUME /logs

#le répertoire par default c'est le répertoire qui contient les sources
WORKDIR /var/www

CMD ["sh", "-c", "while sleep 3600; do :; done"]
