#!/bin/sh

#### kill stats processes #####

PIDFile="/u01/pid.txt"
CurPID=$(<"$PIDFile")
kill -9 $CurPID

#### Move stats file to Backup location #######
runid=$1
mkdir /u01/stats/$runid
mv /u01/*stat_*.txt /u01/stats/$runid/

#### remove pid file ####
rm -rf /u01/pid.txt
