#!/bin/bash

pushd /home/ubuntu/

docker compose run --rm  certbot certonly  --force-renewal --webroot --webroot-path /var/www/certbot/ -d jenkins.justdvir.online

docker compose run --rm  certbot certonly  --force-renewal --webroot --webroot-path /var/www/certbot/ -d gitlab.justdvir.online

docker compose run --rm  certbot certonly  --force-renewal --webroot --webroot-path /var/www/certbot/ -d artifactory.justdvir.online