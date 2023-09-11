---
layout: default
title: Docker installation
permalink: /Developer-Guide/Docker-installation/
parent: Developer Guide
nav_order: 2
---


local docker installation to run the software
<!--

### Prerequisites

The first thing that we got to do is clone the repository that contains the software
[`Linux-Auto-Customizer`](https://github.com/AleixMT/Linux-Auto-Customizer). This
software consists in a set of scripts to automatically install dependencies, libraries and programs to a Linux
Environment. It can be used in many distros, but in this guide we suppose that our environment is Ubuntu Linux. It
may be the same or similar instructions in related distros.

We can clone the repository anywhere, for example in our HOME folder:

```bash
cd $HOME
git clone https://github.com/AleixMT/Linux-Auto-Customizer
cd Linux-Auto-Customizer
bash src/core/install.sh -v -o customizer
```

The previous commands will install the software, so it can be accessed using the link `customizer-install` and
`customizer-uninstall` software if everything is okay.

#### Resolving dependencies

In the repository execute the next orders:
```bash
sudo customizer-install -v -o psql
bash cutomizer-install -v -o jdk pgadmin postman ideau  # ideac 
```

This will install:
* **JDK8:** Java development kit. Contains the interpreter for the Java programming language `java` and the tool to
  manipulate the certificates used in the java VM `keytool`
* **psql:** PostGreSQL, SQL DataBase engine
* **IntelliJ IDEA Community / IntelliJ IDEA Ultimate:** IDE with a high customization via plugins to work with Java.
  The  ultimate edition needs a license; The community version, which is commented out, has also all the required
  features to work with the project.
* **pgadmin:** Graphical viewer of the PostGreSQL DataBase using a web browser.
* **postman:** UI used to manage API calls and requests. Useful for testing and for keeping record of interesting API
  calls. Has cloud synchronization, environments variables, workflows, etc.

This will set up the software with some new soft links and aliases, which will be populated in your environment by
writing to the `.bashrc` of your HOME folder.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Installation

#### Setting up database connection
Log in as the `postgres` user:
```bash
sudo su - postgres
```

Then create the user that the installation will use:
```bash
createuser --interactive --pwprompt
```
Notice that there are other ways of doing this. You can also do it directly by submitting orders to the database from
this user, but in this case it is easier if you have this binary wrapper. It will ask for a password, consider this the
database password.

Then we need to create the database for our software:
```bash
createdb eChempad
```

##### Connect to the database manually using terminal
``` 
psql -d eChempad -h localhost -p 5432 -U amarine
```
-->