docker pull nginx
docker run -p 80:80 --name nginx -d nginx

docker cp -a nginx:/etc/nginx/ /opt/nginx/conf

docker stop nginx
docker rm nginx

docker run -p 80:80 --restart always --name nginx -v /opt/nginx/www:/www -v /opt/nginx/conf/:/etc/nginx/ -v /opt/nginx/logs:/var/log/nginx -v /opt/nginx/wwwlogs:/wwwlogs -d nginx


docker run -p 80:80 --restart always --name nginx  -d nginx

docker run -p 80:80 --restart always --name nginx -v nginx_conf:/ect/nginx/ -v nginx_www:/home -d nginx
