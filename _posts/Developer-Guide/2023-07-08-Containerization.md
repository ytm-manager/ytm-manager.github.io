---
layout: default
title:  Containerization
permalink: /Developer-Guide/Containerization/
parent: Developer Guide
---

To manually build, upload and start the image of the backend you can use these commands:
```shell
git clone github.com/ytm-manager/ytm-manager-backend
cd ytm-manager-backend
sudo docker build -t aleixmt/ytm-offline:latest . 
sudo docker push aleixmt/ytm-offline:latest 
sudo docker-compose down 
sudo docker-compose up -d
```

<!---

# Containerization
We can run eChempad using containers. This is more comfortable than setting up the working environment in your own 
machine.  
- Dependencies are already inside the container.
- Containers are multi-platform.
- Deploy is just a command: `sudo docker-compose up -d`. 

## Container structure
We will containerize the application using two docker images: 
* The image for the eChempad, that we will build from source.
* The image for postgreSQL, that we find on the Internet (Docker Hub).

The image for the eChempad container is created using a multi-stage build. This means that the compilation of the 
project occurs in a container and the execution of the application occurs in another container, separating the concerns
of each stage and reducing the size of the final container image. 

### Steps to create and run the eChempad container image from scratch
These are the steps needed to create the repository for the container image and run it, from scratch. 
* The first image can be built by being in the root of the eChempad repository and using the `Dockerfile` with `sudo 
docker build -t aleixmt/echempad:latest .` where `latest` is the tag that we are writing for this particular version of the 
image. A tag in Docker Hub can be understood as a branch in a git repository.
* Create docker repository for this image in DockerHub.
* Login to Docker Hub: `docker login -u YOUR-USER-NAME`
* (optional) After we have built it we may need to change the tag in order to contain our username and repository target
`docker tag echempad aleixmt/echempad`.
* Finally, upload the image to docker hub `docker push aleixmt/echempad:latest`.
* With these steps you already can use the `docker-compose.yml` file to raise the whole application without worrying 
  about dependencies. To use it open a terminal in the folder where the `docker-compose.yml` file is located and issue
  the command `docker-compose up -d`.

### Steps to update container image
These are the steps to update the container image in the repository:
* Build image locally: `sudo docker build -t aleixmt/echempad:latest .`.
* Upload image to repository (you have to be already logged in): `sudo docker push aleixmt/echempad:latest`.
* Stop old containers: `sudo docker-compose down`.
* Pull image from Docker Hub and rerun: `sudo docker-compose up -d`.

One liner:
```bash
sudo docker build -t aleixmt/echempad:latest . &&  sudo docker push aleixmt/echempad:latest && sudo docker-compose down && sudo docker-compose up -d
```

###### Building java application for deployment 
It is important to understand how compilation and run phase are interrelated but at the same time should be independent
of each other. Also, it is important to understand the existence of the spring boot profiles, which implies the loading
of different data from the `.properties` files present in the project. 

Specifically, the `container` profile is active when the environment variable `spring_profiles_active` is equal to the 
value `container`. This profile overwrites the property that sets the network location of the database. Specifically, 
configures the location of the database taking into account that the application is running in a container, and as such
the network location of the database is different.  

So, the profile for this matter is a runtime dependency. To compile the project you can use:
```
mvn clean package spring-boot:repackage
```

This will need to be refined in the future because the tests are also run with this command, but obviously are not 
needed, but right now it works (with no tests). The product of this command is a `.war` file, than can be run with 
`java` with:

```shell
java -jar eChempad.war
```

## Infraestructure

We have many web services on the digitalization server. To reach them where is a firewall and reverse proxy, so you will not be 
able to connect directly. To pass a connection through ssh for an arbitrary port you can use ssh **local forwarding**, because ssh connections
are allowed to the server. Basically you stablish an ssh connection from the client to the server end and another connection
that configures a forwarding tunnel. In the client end, ssh maps the 
ssh tunnel to an arbitrary port. This arbitrary port has to be free in the client machine, of course. We will connect to
localhost:client_arbitrary_port in the client machine to reach the hidden web service on the server. Then, the ssh connection 
from the tunnel reaches the server,
where the data coming from the ssh client, is forwarded to an arbitrary port. This port is expected to be the hidden web service
that you cannot access directly.

For example, we have an inaccessible web service serving on port 8081 on `server.iciq`. We have a ssh connection from the client
to this server (allowed unrelated incoming traffic on port 22). We want to access server.iciq:8081 but the firewall does not allow
traffic on port 8081.

Solution: Create a tunnel that redirects connections in port 1088 on the client machine to the port 8081 in the remote machine:
```shell
ssh -L 1088:localhost:8081 amarine@server.iciq
```
After this, open the browser and connect to localhost:1088 to access (in reality) server.iciq:8081

-->