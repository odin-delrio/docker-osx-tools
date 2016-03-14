#!/usr/bin/env bash

function logSuccess() {
    printf "\e[32m$1\e[0m\n"
}

function logWarn() {
    printf "\e[33m$1\e[0m\n"
}

function deleteHostEntry() {
    hostName=$1

    sudo /bin/bash -c "sed -i '' "/${hostName}$/d" /etc/hosts"
}

function addHostEntry() {
    hostName=$1
    ip=$2

    sudo /bin/bash -c "echo \"${ip}	${hostName}\" >> /etc/hosts"
}

function updateMachineIp() {
    name=$1
    ip=$2

    if [ -z ${ip} ]; then
       logWarn "IP of machine '${name}' is empty, (is machine running?) skipping..."
       return
    fi

    hostName="${name}.dm"

    deleteHostEntry ${hostName}
    addHostEntry ${hostName} ${ip}
    logSuccess "Hostname '${hostName}' for IP '${ip}' created."
}

function checkRequirements() {
    type docker-machine >/dev/null 2>&1 || { echo >&2 "docker-machine it's not installed. Aborting."; exit 1; }
}

checkRequirements

docker-machine ls --format="{{.Name}}" | while read -r machineName; do
    machineIp="$(docker-machine ip ${machineName} 2>/dev/null)"
    updateMachineIp ${machineName} ${machineIp}
done
