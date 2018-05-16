#!/bin/bash

echo ">> Waiting for Postgresql to start......................................."
WAIT=0
while ! nc -z postgres_ecommerce_dev 5432; do
    sleep 1
    WAIT=$((WAIT + 1))
    if [ "$WAIT" -gt 15 ]; then
        echo "Error: Timeout waiting for Postgresql to start."
        exit 1
    fi
done
cd /var/www/e-commerce
pwd
ls -latr

# Lancement du .jar à la racine de l'application en environnement de DEV
java -jar target/e-commerce-0.0.1-SNAPSHOT.jar --spring.config.location="file:/var/www/e-commerce/src/main/resources/application-dev.properties"
