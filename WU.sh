#!/bin/bash
apt-get update && apt-get upgrade --yes 
# echo  $1
if [[ $1 == '-r' ]]; then
    # echo "reboot"
    reboot now 
else
    # echo "shutdown"
    shutdown now
fi
