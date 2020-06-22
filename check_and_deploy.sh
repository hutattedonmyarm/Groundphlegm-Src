#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

deploy_update () {
    printf "${BLUE}Deploying new posts${NC}\n"
    git pull
    ./deploy.sh
}

check_update () {
    printf "${GREEN}Checking Groundphlegm${NC}\n"
    cd $HOME/Groundphlegm-Src
    git fetch
    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse "$UPSTREAM")
    BASE=$(git merge-base @ "$UPSTREAM")

    if [ $LOCAL = $REMOTE ]; then
        printf "${BLUE}Groundphlegm already up to date${NC}\n"
    elif [ $LOCAL = $BASE ]; then
        deploy_update
    fi
    cd $HOME
}

check_update
