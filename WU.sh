apt-get update && apt-get upgrade --yes 
&&
if [$1 = '-r'] || [$1 = '--reboot']
    reboot now
else
    shutdown now
fi
