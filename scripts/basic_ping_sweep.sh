#!/bin/sh

if [ "$1" == "" ]
then
	echo "Usage: ./ping_sweep.sh [network]"
	echo "example: ./ping_sweep.sh 192.168.20"
else
	for x in `seq 1 254`; do
		ping -c 1 $1.$x | grep "64 bytes"
	done
fi


