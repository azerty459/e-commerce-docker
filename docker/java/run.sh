#!/bin/bash

echo ">>>>> Checking if PostgreSQL is ready before starting."
WAIT=0

until nc -zv postgres_ecommerce_dev 5432; do
    echo ">>>>> PostgreSQL is not ready yet, waiting 1s."
    sleep 1
    WAIT=$((WAIT + 1))
    # Wait 15s max
    if [ "$WAIT" -gt 15 ]; then
        echo ">>>>> Error: Timeout waiting for PostgreSQL, exiting."
        exit 1
    fi
done

echo ">>>>> PostgreSQL is ready, launching application"

# Lancement du .jar à la racine de l'application

# En LOCAL
#java -jar /e-commerce/target/e-commerce-0.0.1-SNAPSHOT.jar --spring.config.location="file:/e-commerce/src/main/resources/application-dev.properties"

# En DEV
java -jar /e-commerce/e-commerce.jar --spring.config.location="file:/e-commerce/src/main/resources/application-dev.properties"
