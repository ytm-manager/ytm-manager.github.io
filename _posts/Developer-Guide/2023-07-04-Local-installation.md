---
layout: default
title: Local installation
permalink: /Developer-Guide/Local-installation/
parent: Developer Guide
nav_order: 1
---


local manual installation to run the software 

### Prerequisites
You will need to install some fundamental packages in your system to run the software such as `python3`. `git` is not 
entirely necessary since the repository can be downloaded as a `.zip` from GitHub, but it makes things easier. Also, We
can take advantage of having the repositories cloned for the Developer environment, used in next articles.

#### Resolving dependencies
The first thing that we got to do is clone the repository that contains the software
[`ytm-manager-backend`](https://github.com/ytm-manager/ytm-manager-backend) and
[`ytm-manager-frontend`](https://github.com/ytm-manager/ytm-manager-frontend)

We can clone the repository anywhere, for example in our HOME folder:
```bash
cd $HOME
git clone https://github.com/ytm-manager/ytm-manager-backend
git clone https://github.com/ytm-manager/ytm-manager-frontend
```

In each repository execute the next orders to create the virtual environments to execute the software and install its 
dependencies:
```shell
cd ytm-manager-backend
python3 -m venv venv
venv/bin/python3 -m pip install --upgrade pip
venv/bin/python3 -m pip install -r requirements.txt
cd ..
```

```shell
cd ytm-manager-frontend
python3 -m venv venv
venv/bin/python3 -m pip install --upgrade pip
venv/bin/python3 -m pip install -r requirements.txt
cd ..
```

### Run software
You need to run the main script of each project to have both the frontend and backend up and running. The easiest way is
to use two terminals. In the first terminal write:
```shell
cd ytm-manager-backend
venv/bin/python3 src/app/main.py   
```

In the second terminal write:

```shell
cd ytm-manager-backend
venv/bin/python3 src/app/main.py
```

You can use a single terminal (the goal is to have both projects running at the same time). But you will need to throw 
the first process in background (using the `&` in bash) to be able to keep using the terminal and execute another 
component.

### Use software

#### Using web interface
Access `http://localhost:5010/` to access the web page of the frontend. The frontend will automatically call the backend
to access the application logic. 

#### Using API
You can also send requests directly to the backend by attacking its API using Postman, `curl` or any other application 
or method to send HTTP requests to a server.
