# Lab 3: Scaling Docker with Mesos

### Prerequisite
	Working DC/OS Cluster
		AWS
		Mini-Mesos

[Intro material](https://github.com/mesosphere/velocity-training/tree/master/velocity-training/mesos-marathon) gives a brief overview.

### Deploying to Mesos

In the `mesos` directory there are a number of files for deploying docker instances to a running cluster.  Details of setting up a cluster are either automated by the mesosphere cloud provisioner, or is in the readme.html of the USB drive.

1. cd mesos
2. Determine your Master IP and change the `launch.sh` to use that IP and remove the first `ECHO` and the first exit 1;

	```
	#!/bin/bash

	echo "** You need to replace the <master ip> with the IP address of the cluster master and delete this and the next line **"
	exit 1;

	if [ "$#" -ne 1 ]; then
    	echo "script takes json file as an argument"
	exit 1;
	fi

	curl -X POST -H "Content-Type: application/json" <master ip>:8080/v2/apps -d@"$@"
	```
3. launch the `tomcat-bridge.json`

	```
	./launch.sh tomcat-bridge.json
	```

4. review the marathon for deployment: `http://<master_ip>:8080/
5. scale the application to 3 in the web ui
6. view the haproxy configuration.  ssh into the master.

	```
	cat /var/log



### FINISHED
