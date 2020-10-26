#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

deploy_update () {
    printf "${BLUE}Deploying new posts${NC}\n"
    echo $(date +%s) > .last_deploy
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
        last_deploy="0"
        # Read from file if it exists
        test -f ".last_deploy" && last_deploy=$(cat .last_deploy)
        now=$(date +%s)
        sec_since_deploy=$(expr $now - $last_deploy)
        if [ $sec_since_deploy -gt 43200 ]; then
          hours_since_deploy=$(expr $sec_since_deploy / 3600)
          printf "${BLUE} It has been ${hours_since_deploy}h since the last deploy. Deploying anyways${NC}\n"
          deploy_update
        fi
    elif [ $LOCAL = $BASE ]; then
        deploy_update
    fi
    cd $HOME
}

check_update
