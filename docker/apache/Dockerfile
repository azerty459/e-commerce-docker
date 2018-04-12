
# Serveur Apache

FROM httpd:2.4.25

# Exposed ports
EXPOSE 1080
EXPOSE 1443

RUN mkdir /logs
RUN chmod -R 777 /logs

# Create 'www-data' group with gid 1000 and 'www-data' user in this group with uid 1000
RUN groupadd -f -g 1000 www-data

WORKDIR /var/www

ADD conf/httpd.conf /usr/local/apache2/conf/httpd.conf

# Allow apache to run with 'www-data' user
RUN chown -R www-data:www-data /usr/local/apache2/

# Start container as www-data
USER www-data
