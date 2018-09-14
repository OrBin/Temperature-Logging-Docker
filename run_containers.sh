
docker run -d -p 8081:80 --name temperature_logging_back_end -v /code/python/Temperature-Logging-Back-End/config_docker.json:/app/config.json orbin/temperature-logging-back-end
docker run -d -p 8082:80 --name temperature_logging_front_end orbin/temperature-logging-front-end
docker run -d -p 80:80 --name temperature_logging_master -v /var/run/docker.sock:/var/run/docker.sock orbin/temperature-logging
