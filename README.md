### Docker Haste-Server

#### Exposition

You can expose the port 7777 on all interface like that :

```
docker run --name hastebin \
-p 7777:7777 \
anthodingo/docker-haste-server
```

-
Or you can bind the port 4000 only on loopback (127.0.0.1) like : (more secure)
```
docker run --name hastebin \
-p 127.0.0.1:7777:7777 \
anthodingo/docker-haste-server
```

#### Folder

You can store data and config externaly of container :
```
docker run --name hastebin \
-p 7777:7777 \
-v /srv/hastebin/data:/hastebin/data \
anthodingo/docker-haste-server
```

```
docker run --name hastebin \
-p 7777:7777 \
-v /srv/hastebin/config.js:/hastebin/config.js \
anthodingo/docker-haste-server
```

#### Nginx exemple

This exemple work in production :

```
upstream hasteserver {
   server 127.0.0.1:7777;
}

server {
    listen 80;
    server_name _;

    client_max_body_size 10M;

    location / {
        proxy_http_version 1.1;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header X-NginX-Proxy true;

        proxy_pass http://hasteserver/;
        proxy_redirect off;
        proxy_buffering off;
    }
}
```


#### Why my repo and not official ?

I only includ a keygen generator lib.

[Official repo](https://github.com/seejohnrun/haste-server)
[My repo](https://github.com/Janus-SGN/haste-server)