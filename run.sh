#!/usr/bin/env bash

script_dir=$(dirname $(realpath $0))
DOCKER_COMPOSE_COMMAND="docker-compose -f docker-compose.yml --env-file terraform.env run --rm"

# Jump into script dir
cd $script_dir

# Use docker-compose to run terraform commands
if [ $# -ge 1 ]; then
    if [[ "$1" == "fmt" ]]; then
        $DOCKER_COMPOSE_COMMAND terraform -chdir=./test fmt --recursive ${@:2} ../ 
    else
        $DOCKER_COMPOSE_COMMAND terraform -chdir=./test ${@:1}
    fi
else
    echo -e """
    Help: 
        $0 ftm [extra_terraform_parameters]
            Runs terraform format recursivelly in all module directory and its subdirectories
            [extra_terraform_parameters]: Any extra terraform parameters for fmt e.g: -list=false

        $0 terraform_command [extra_terraform_parameters]
            terraform_command: Any terraform command, e.g: init, validate...
            [extra_terraform_parameters]: Any extra terraform parameters, e.g: --reconfigure
    """
fi

# Go bach to original location
cd - 2>&1 > /dev/null