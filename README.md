# nginx-multy-host with ssl



### "nginx-multy-hosts" is a repository that contains the necessary files to enable multiple hosts and redirects using nginx and docker-compose, while also obtaining SSL from Certbot (Let's Encrypt).


## Usage

Before proceeding, ensure that you modify the nginx.conf file located in the nginx folder to include your domains and backends. Additionally, confirm that your domains are pointing to this server. To do so, you can first comment out all the server blocks listening on port 443, except for the first one, which should remain uncommented.

then run the docker compose file 
```sh
docker compose up -d 

```
make sure the nginx container is up by using 

```sh
docker ps 
```

after that run the command

```sh
docker compose run --rm  certbot certonly  --force-renewal --webroot --webroot-path /var/www/certbot/ -d <your domain>
```

This will gain you a certificate from Let's Encrypt for the domain.

Run this command with the rest of your domains.

After that, uncomment the servers so none are commented out, and then run.

```sh
docker exec -it nginx nginx -s reload

```

and that should do it!!!!!

## Extra steps 

If you have noticed, the certificate is only valid for three months, and you may be telling yourself, "But Dvir... What should I do?"

Well, I am here for the rescue!

add a crontab job that will run the script called renew-cr.sh 

simply run
 
```sh
crontab -e 
```

and add this to the end of the file

```sh
0 0 1 * * /bin/bash /script/location/renew-cr.sh
```
this will renew the certifactes for you on a monthly bases 

## FAQ
### Static Files

what about static files you malaka??? (curse in australin... i dont know where you are from!!!)

whell first you need to add the static files to the nginx
by adding this line to the docker compose 
```sh
- "./<static files location>:/usr/share/nginx/html/<folder name to create with your files>"
```
and then modify the nginx.conf to use those by modifing the server block 
it should look like this 

```sh
 
location / {
        
        if ( $host != "your domain" ) {
        return 444 ;
        }
        root /usr/share/nginx/html/static;
        add_header From  "nginx";
        try_files $uri /$uri @backend;
        
    }

    location @backend {
        proxy_pass         http://<your backend app>;
        
        proxy_redirect     off;
        proxy_set_header   Host             $host;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
        add_header From  "backend";
    }
 
```

for more information refer to this [stack-overflow]

and also check out this [project] where a use static files from a gcp bucket  


## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

## License

no license!!!!!!!!!!!

free software

[//]: # 

[stack-overflow]: <https://stackoverflow.com/questions/12806893/use-nginx-to-serve-static-files-from-subdirectories-of-a-given-directory>
[project]: <https://github.com/dvir-pashut/Devops-portfolio>
