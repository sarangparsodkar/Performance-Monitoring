#!/bin/sh

# Stats collection interval is $1. 
# If $1 is blank, by default stats would be gathered at 30 seconds interval. 
# Use stopMon.sh to stop stats gathering.



HSN=`hostname`
DATE=`date '+%Y%m%d%H%M%S'`


if [  "$1" == "" ]; 
then
int="30"
else
int="$1"
fi


`nohup vmstat -t "$int" > /u01/vmstat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i vmstat | grep -v grep | awk {'print $2'}  >> /u01/pid.txt`

`nohup mpstat -P ALL "$int" > /u01/mpstat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i mpstat | grep -v grep | awk {'print $2'} >> /u01/pid.txt`

`nohup iostat -x -t "$int" > /u01/iostat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i iostat | grep -v grep | awk {'print $2'} >> /u01/pid.txt`

`nohup netstat -i "$int" -c > /u01/netstat_"$HSN"_"$DATE".txt &`
`ps aux | grep -i netstat | grep -v grep | awk {'print $2'} >> /u01/pid.txt`
