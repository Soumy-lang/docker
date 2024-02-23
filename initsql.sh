#!/bin/bash
sleep 10

# Exécutez la commande artisan
docker-compose run php1 php artisan migrate:fresh --seed
