#!/bin/sh

# Stats collection interval is $1. 
# If $1 is blank, by default stats would be gathered at 30 seconds interval. 
# Use stopMon.sh to stop stats gathering.



HSN=`hostname`
DATE=`date '+%Y%m%d%H%M%S'`
PWD=`pwd`


if [  "$1" == "" ]; 
then
int="30"
else
int="$1"
fi


`nohup vmstat -t "$int" > $PWD/vmstat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i vmstat | grep -v grep | awk {'print $2'}  >> $PWD/pid.txt`

`nohup mpstat -P ALL "$int" > $PWD/mpstat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i mpstat | grep -v grep | awk {'print $2'} >> $PWD/pid.txt`

`nohup iostat -x -t "$int" > $PWD/iostat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i iostat | grep -v grep | awk {'print $2'} >> $PWD/pid.txt`

`nohup netstat -i "$int" -c > $PWD/netstat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i netstat | grep -v grep | awk {'print $2'} >> $PWD/pid.txt`
