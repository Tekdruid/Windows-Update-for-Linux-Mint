#!/bin/bash
while getopts lrh OPTION 
do
  case $OPTION in
  r | reboot)
     reboot=1
     ;;
  l | log)
     log=1
     ;;
  h | help)
    help=1
    ;;
  esac
done
echo "Reboot: $reboot"
echo "Log: $log"
echo "Help: $help"
if [[ $help ]] then
  echo "Usage: WU.sh [-r or --reboot]: reboot instead of shutting down [-l or --log]: write log file from script output [-h or --help]: display this message"
else
  if [[ $log ]] then
     apt-get update | tee updatelog.txt && apt-get upgrade --yes | tee -a updatelog.txt &&
    if [[ $reboot || $1 == '--reboot' ]] then
      # echo "reboot" | tee -a updatelog.txt
       reboot now | tee -a updatelog.txt
    else
      #echo "shutdown" | tee -a updatelog.txt
       shutdown now | tee -a updatelog.txt
    fi
  else
     apt-get update && apt-get upgrade --yes 
    if [[ $reboot || $1 == '--reboot' ]] then
      #echo "reboot"
      reboot now 
    else
      #echo "shutdown"
       shutdown now
    fi
  fi
fi
