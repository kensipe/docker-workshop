
## Docker common / useful commands

last docker
alias dl='docker ps -l -q'

get IP address
docker inspect `dl` | grep IPAddress | cut -d '"' -f 4

ENV
docker run --rm ubuntu env

image depends graph
docker images -viz | dot -Tpng -o docker.png

kill all the running
docker kill $(docker ps -q)

Copy files into a container
docker cp `dl`:/etc/passwd .

mount file into a container
docker run -v `pwd`:/root/test ubuntu 

NOTES:
docker run -it --rm dockerfile/java:oracle-java8 java -version
docker run -it --rm dockerfile/java java



