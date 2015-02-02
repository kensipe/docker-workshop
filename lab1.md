# Lab 1: Intro to Docker

### Prerequisite
	Docker installed
	boot2docker installed (Mac/Win)
	Good internet connection

### docker in interactive mode

Running docker in interactive mode allows a developer to:

* understand the environment
* debug when things go wrong
* research

We will be working with 2 images for these labs.  `ubuntu` and `kensipe/tomcat`.  The first time they are reference it will take several minutes as these images are pulled for the public repository.  After that command-line references will run very quickly.  It may be best to pull these images prior to starting the lab.  To pull run: `docker pull ubuntu` and `docker pull kensipe/tomcat`.

1. enter interactive mode:
 
	```
	docker run -it ubuntu /bin/bash` or `docker run -it ubuntu
	```

2. add a text file named `owner.txt` with your name in it.
	
	```
	echo "ken sipe" > owner.txt
	```


3. exit the container type: `ctrl+p, ctrl+q`
4. list the running dockers

	```
	docker ps
	```
	
**NOTE:** Experiment with variations here.  `docker ps -a`, `docker ps -l`, `docker ps -q`, `docker ps -lq`

**NOTE:**  It is common to set an alias for dl (docker last): `alias dl='docker ps -lq'`

5. diff on the container ID (SHA)

	```
	docker diff $(docker ps -lq)
	or
	docker diff `dl`
	```
6. attach to the container

	```
	docker attach `dl`
	```
7. exit the container.  type: `exit` <enter>

8. commit your container

	```
	docker commit `dl` owner
	```
9. display owner information from your container in non-interactive mode

	```
	docker run owner cat owner.txt
	```

### FINISHED	


