#!/bin/bash
reboot=false
log=false
logfile="updatelog.txt"
help=false
if ! options=$(getopt -o rlhf: -l reboot,log,help,logfile: -- "$@")
then
    exit 1
fi

set -- $options

while [ $# -gt 0 ]
do
    case $1 in
    -r|--reboot) reboot=true ;;
    -l|--log) log=true ;;
    -h|--help) help=true ;;
    -f|--logfile) logfile=$2 ; shift;;
    (--) shift; break;;
    (-*) echo "$0: error - unrecognized option $1" 1>&2; exit 1;;
    (*) break;;
    esac
    shift
done
logfile=${logfile//\'/} # Strip extra quotes from filename
# echo "Reboot: $reboot"
# echo "Log: $log"
# echo "Help: $help"
# echo "Logfile: $logfile"
if [[ $help == true ]] then
  echo "Usage: WU.sh [-r or --reboot]: reboot instead of shutting down [-l or --log]: write log file from script output [-h or --help]: display this message [-f or --logfile:<path/to/file> Set log file path]"
else
  if [[ $log == true ]] then
    # echo "Update" | tee ${logfile} && 
     apt-get update | tee ${logfile} && 
    # echo "Force upgrade" | tee -a ${logfile} &&    
    apt-get upgrade --yes | tee -a ${logfile} &&  
    if [[ $reboot == true ]] then
       #echo "reboot" | tee -a ${logfile}
       reboot now | tee -a ${logfile}
    else
      #echo "shutdown" | tee -a ${logfile}
       shutdown now | tee -a ${logfile}
    fi
  else
    #echo "Update" &&
     apt-get update &&
    #echo "Force upgrade" && 
    apt-get upgrade --yes 
    if [[ $reboot == true ]] then
      # echo "reboot"
      reboot now 
    else
      #echo "shutdown"
       shutdown now
    fi
  fi
fi
