#!/bin/ash

user=
token=

while getopts u:t: opt; do
    case $opt in
    u)
        user=$OPTARG
        ;;
    t)
        token=$OPTARG
        ;;
    esac
done

wget -qO- "https://api.opennicproject.org/ip/update/?user=$user&auth=$token"
