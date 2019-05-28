#!/bin/bash

# Stats collection interval is $2. 
# If $2 is blank, by default stats would be gathered at 1 seconds interval. 
# Use stopMon.sh to stop stats gathering.



HSN=`hostname`
DATE=`date '+%Y%m%d%H%M%S'`
PWD=`pwd`

if [ $# -lt 1 ]
then
  echo -e "Usage : $0 <STATS_TO_BE_COLLECTED> <STATS_INTERVAL>"
  echo -e "Options for argument STATS_TO_BE_COLLECTED are - all, vmstat, mpstat, iostat, netstat"
  echo -e "Options for argument STATS_INTERVAL - Interval time for stats in seconds. This is optional.\nBy default, stats will be gathered at interval of 1 seconds if STATS_INTERVAL is not passed."
  echo -e "e.g. ./startMon.sh all 5"
  exit
fi

if [[ "$2" -eq 0 ]]; 
then
int="1"
else
int="$2"
fi

function vmstat() {
`nohup vmstat -t "$int" > $PWD/vmstat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i vmstat | grep -v grep | awk {'print $2'}  >> $PWD/pid.txt`
}

function mpstat() {
`nohup mpstat -P ALL "$int" > $PWD/mpstat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i mpstat | grep -v grep | awk {'print $2'} >> $PWD/pid.txt`
}

function iostat() {
`nohup iostat -x -t "$int" > $PWD/iostat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i iostat | grep -v grep | awk {'print $2'} >> $PWD/pid.txt`
}


function netstat() {
`nohup netstat -i "$int" -c > $PWD/netstat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i netstat | grep -v grep | awk {'print $2'} >> $PWD/pid.txt`
}

case $1 in
   "vmstat")
        vmstat;;
   "netstat")
        netstat;;
   "mpstat")
        mpstat;;
   "iostat")
        iostat;;
   "all")
        netstat
        mpstat
        vmstat
        iostat
        ;;
    *)
        echo "You must provide a valid value out of available options - all, vmstat, iostat, mpstat, netstat"
        exit -1;
esac
