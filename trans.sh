#!/bin/bash
#Program:
#       This program is to transmit a file to your remote server.




echo "The remote host is $remote_host"

if [ "$#" != "1" ];then
	echo "Please input $0 file_name"

elif [ ! -f "$1" ];then
	echo "File dosen't exist or it is not a file!"

else
	scp $1 $remote_host && echo "$1 ------> $remote_host Success!" || echo "Trans failed!"
fi

