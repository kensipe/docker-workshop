# Dockerfile guide


## Dockerfile


### MAINTAINER: 
Set an author field for the image using this instruction. The simple and obvious syntax is:

	MAINTAINER <author name>
	
### RUN: 
Execute a command in a shell or exec form. The RUN instruction adds a new layer on top of the newly created image. The committed results are then used for the next instruction in the DockerFile.

	Syntax: RUN <command>
	
### ADD:
Copy files from one location to another using the ADD instruction. It takes two arguments <source> and <destination>. The destination is a path in the container. The source can be either a URL or a file in the context of the launch config.

	Syntax: ADD <src> <destination>
	
### CMD:
Defaults for an executing container are provided using the CMD command. DockerFile allows usage of the CMD instruction only once. Multiple usage of CMD nullifies all previous CMD instructions. CMD comes in three flavours: (externally overrideable)

	Syntax:CMD ["executable","param1","param2"]
	CMD ["param1","param2"]
	CMD command param1 param2
	
### EXPOSE:
Specify the port on which the container will be listening at runtime by running the EXPOSE instruction.

	Syntax: EXPOSE <port>;
	
### ENTRYPOINT:
Configure a container to run as an executable, which means a specific application can be set as default and run every time a container is created using the image. This also means that the image will be used only to run and target the specific application each time it is called.

Similar to CMD, #Docker allows only one ENTRYPOINT and multiple ENTRYPOINT instructions nullifies all of them, executing the last ENTRYPOINT instruction. (externally NOT overrideable)

	Syntax: Comes in two flavours
	ENTRYPOINT [‘executable’, ‘param1’,’param2’]
	ENTRYPOINT command param1 param2
	
### WORKDIR:
Working directory for the RUN, CMD and ENTRYPOINT instructions can be set using the WORKDIR.

	Syntax: WORKDIR /path/to/workdir
	
### ENV:
Set environment variables using the ENV instruction. They come as key value pairs and increases the flexibility of running programs.

	Syntax: ENV <key> <value>
	
### USER:
Set a UID to be be used when the image is running.

	Syntax: USER <uid>
	
### VOLUME:
Enable access from a container to a directory on the host machine.

	Syntax:VOLUME [‘/data’]


## Best Practices

1. Keep common instructions at the top of the Dockerfile to utilize the cache.
2. Always pass -t to tag the resulting image.
3. Never map the public port in a Dockerfile.
	
	```
	# private and public mapping
	EXPOSE 80:8080

	# private only
	EXPOSE 80

	```
	
4. Always use the array syntax when using CMD and ENTRYPOINT.

	```	
	CMD /bin/echo
	# or
	CMD ["/bin/echo"]
	```
	
5. ENTRYPOINT and CMD are better together.

	```
	ENTRYPOINT ["/usr/bin/etcd"]

	CMD ["--help"]
	```
