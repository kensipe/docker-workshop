# Lab 2: Docker - Working with Tomcat

### Prerequisite
	Lab 1 completed successful

We will be working with 2 images for these labs.  `ubuntu` and `kensipe/tomcat`.  The first time they are reference it will take several minutes as these images are pulled for the public repository.  After that command-line references will run very quickly.  It may be best to pull these images prior to starting the lab.  To pull run: `docker pull ubuntu` and `docker pull kensipe/tomcat`.

In this lab you will be working with the `tomcat-build` directory.  There are 2 items in that directory:

* a subdirectory `Calendar` which contains the contents the Calendar.war file
	* re: [source](https://gwt-examples.googlecode.com/files/Calendar.war)).  
* Dockerfile



### Tomcat and work with mounted volumes

1. cd `tomcat-build`

2. lets mount the the WAR directory into the container with out a build.  This is accomplished with the `-v` switch for a `docker run`.


	```
	docker run -v `pwd`/Calendar/:/app/tomcat/webapps/Calendar/ -P --net=host -d kensipe/tomcat
	```

3. test by going to the `boot2docker` VM instances `boot2docker ssh`
4. test the curl command

	```
	curl localhost:8080/Calendar/Calendar.html
	```

### tomcat and build files


1. cd `tomcat-build`

2. inspect the Dockerfile

	```
	FROM kensipe/tomcat

	MAINTAINER Ken Sipe <ken@mesosphere.io>

	ADD Calendar/ /app/tomcat/webapps/Calendar/
	```
3. Since the root image is `kensipe/tomcat`, lets investigate it.

	```
	docker history kensipe/tomcat
	```
	```
	docker run -it kensipe/tomcat /bin/bash
	```
Structure of the image

* /app/tomcat/ - is the tomcat working dir
* /build - is a build pack work dir
* /start is the bootstrap
* `/start web` is the startup command

4. Lets build a new image

	```
	docker build .
	or
	docker build -t calendar-web .
	```
**NOTE:** The last SHA and the name calendar-web are the same image

5. Checkout the images

	```
	docker images
	```

6. Lets tag it

	```
	docker tag calendar-web kensipe/calendar-web:v1
	```

7. Lets push it

	```
	docker push kensipe/calendar-web:v1
	```
**NOTE:** You need to have push rights, the repository needs to exist and you will need to login (`docker login`)

### tomcat and ports

1. Lets start this web application

	```
	docker run -d -P --net=host calendar-web
	```

This starts the tomcat container with the new Calendar file as a daemon and exposes the services on the host node.  The is no docker NAT.  The container service binds to the local IP.  **NOTE:** when using boot2docker (Mac/Win) the IP is the IP of the boot2docker VM.  To test ssh into the boot2docker, `boot2docker ssh` and curl `curl localhost:8080`.   You will see the output of the tomcat instance.  Kill the docker container, curl again and you will see a connection refused.

When working with net mode == host, **only 1 tomcat instance** can be bond to the IP.  

2. Lets make sure our Calendar application is deployed.

	```
	curl localhost:8080/Calendar/Calendar.html
	```

3. Lets launch another instance, however this time lets work in `bridge` mode on a random (docker assigned) port.

	```
	docker run -d -P  calendar-web
	```
This is all it takes. It doesn't look much different, but a quick `docker ps` will display a difference.  Example of port output: `0.0.0.0:49162->8080/tcp`.

4. Lets inspect this docker container

	```
	docker inspect $(docker ps -lq)
	```
The configuration for this container is strongly different:

	```
	"NetworkSettings": {
        "Bridge": "docker0",
        "Gateway": "172.17.42.1",
        "IPAddress": "172.17.0.27",
        "IPPrefixLen": 16,
        "MacAddress": "02:42:ac:11:00:1b",
        "PortMapping": null,
        "Ports": {
            "8080/tcp": [
                {
                    "HostIp": "0.0.0.0",
                    "HostPort": "49162"
                }
            ]
        }
	```
This container has it's own IP address managed by docker (`172.17.0.27`).  The port mapping is different as well.  The application is still running on port 8080 and is bond on the `172.17.0.27` IP address.  However the host port is `49162`, which means docker is listen on the host at that port and forwarding traffic (NAT) to the container.  From our perspective the service is at `49162`.

5. Test the bridged service

	```
	 curl localhost:49162/Calendar/Calendar.html
	 ```

**NOTE:** If you want to see *your* service at scale in the next labs, you will need to push it.

### CMD / Entry of Build File

1. create a figlet build file (refer to the end of lab 1)

```
FROM ubuntu
RUN apt-get update
RUN apt-get install figlet
```

2. Build figlet

`docker build -t figlet .`

3. CMD update to build file

Add `CMD figlet -f script hello` to the build file.

4. Build and Run

```
docker build -t figlet .
docker run figlet

# now run
docker run figlet figlet test
```
** cmd can be replaced

5. Entry Point

replace the CMD with `ENTRYPOINT ["figlet", "-f", "script"]` in the build file

6. Build and Run

```
docker build -t figlet .

docker run figlet hello world
```

7. CMD + ENTRYPOINT

replace ENTRYPOINT with:

```
ENTRYPOINT ["figlet", "-f", "script"]
CMD ["hello world"]
```

8. Build and Run

```
docker build -t figlet .

docker run figlet

docker run figlet FTW
```

### Finished
