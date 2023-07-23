---
layout: default
title: Running with docker
permalink: /eChempad/Developer-Guide/Running-with-docker/
parent: Developer Guide
grand_parent: eChempad
nav_order: 6
---

# Running with docker

The fastest way to get a copy up and running in your local machine is using *Docker* with `docker-compose`.

### Prerequisites
First install `docker-ce` and `docker-compose` with your preferred method. In Ubuntu / Debian systems you can use the 
following commands:
```shell
sudo apt install -y docker-ce docker-compose
```

### Installation
With the prerequisites fulfilled, you can simply download the `docker-compose.yml` file from the official repository 
with this command:
```shell
wget https://raw.githubusercontent.com/AleixMT/eChempad/master/docker-compose.yaml
```

Afterwards, execute this command to trigger the interpretation of the `docker-compose.yml` file that we have just 
downloaded:
```shell
sudo docker-compose up -d
```

This will pull the official containers of the
[eChempad docker image](https://hub.docker.com/r/aleixmt/echempad) and [postgreSQL](https://hub.docker.com/_/postgres) 
and run them in background, restarting them unless the containers are explicitly stopped.

### Test the platform
Now, you can open a browser and navigate to the URL [`http://localhost`](http://localhost) to start using eChempad.

### Adding tokens
If you want to connect eChempad to Signals Notepad or Dataverse, you have to add the corresponding tokens to your user.
You can do that in your eChempad profile.

But you can also add your tokens in the same folder where you downloaded the `docker-compose.yml` in order to load the 
tokens into the admin user profile.  

You have to create the folders `src/main/resources/secrets` with the files `dataverseKey.txt` and `signalsKey.txt` with
the corresponding tokens inside to make available the connection. 


