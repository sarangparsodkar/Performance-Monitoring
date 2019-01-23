#!/bin/sh

#### kill stats processes #####

PWD=`pwd`
PIDFile="$PWD/pid.txt"
CurPID=$(<"$PIDFile")
kill -9 $CurPID

#### Move stats file to Backup location #######
runid=$1
mkdir $PWD/stats/$runid
mv $PWD/*stat_*.txt $PWD/stats/$runid/

#### remove pid file ####
rm -rf $PWD/pid.txt
