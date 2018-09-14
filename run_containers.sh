#!/bin/bash

print_usage_and_exit () {
    echo "Usage: ./run_containers.sh configuration_file [-p port]"
    exit $1
}

config_file=$1
port=$3

if [ $# = 1 ]
then
    port=80
elif [ $# = 3 ]
then
    if [ $2 = '-p' ]
    then
        if ! [[ $port =~ ^[0-9]+$ ]]
        then
            echo "Error: '$port' is not a number, a port number is required"
            print_usage_and_exit 2
        elif [ $port -lt 1 ] || [ $port -gt 65535 ]
        then
            echo "Error: invalid port number $port"
            print_usage_and_exit 2
        fi
    else
        print_usage_and_exit 1
    fi
else
    print_usage_and_exit 1
fi

echo "Running containers..."
echo "Configuration file: $config_file"
echo "Port: $port"

docker run -d -p 8081:80 --name temperature_logging_back_end -v $config_file:/app/config.json orbin/temperature-logging-back-end
docker run -d -p 8082:80 --name temperature_logging_front_end orbin/temperature-logging-front-end
docker run -d -p $port:80 --name temperature_logging_master -v /var/run/docker.sock:/var/run/docker.sock orbin/temperature-logging
