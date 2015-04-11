#!/bin/bash


function addSrvUsr() {
    sudo useradd -M $1
    sudo usermod -L $1
}

if [[ -n $1 ]]; then
    addSrvUsr $1
else
    echo "Service usr name should be specified as the first argument"
fi
