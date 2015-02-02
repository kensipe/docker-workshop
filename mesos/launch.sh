#!/bin/bash

echo "** You need to replace the <master ip> with the IP address of the cluster master and delete this and the next line **"
exit 1;

if [ "$#" -ne 1 ]; then
    	echo "script takes json file as an argument"
	exit 1;
fi

curl -X POST -H "Content-Type: application/json" <master ip>:8080/v2/apps -d@"$@"
