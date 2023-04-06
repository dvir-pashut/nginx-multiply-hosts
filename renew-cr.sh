#!/bin/bash

pushd <the script location>

docker compose run --rm  certbot certonly  --force-renewal --webroot --webroot-path /var/www/certbot/ -d domain1

docker compose run --rm  certbot certonly  --force-renewal --webroot --webroot-path /var/www/certbot/ -d domain2

docker compose run --rm  certbot certonly  --force-renewal --webroot --webroot-path /var/www/certbot/ -d domain3