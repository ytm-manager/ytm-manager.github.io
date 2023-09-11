---
layout: default
title: Setting up development environment
permalink: /Developer-Guide/Setting-up-development-environment/
parent: Developer Guide
nav_order: 4
---


local manual installation to develop and debug the software
<!--
# Installing development environment for eChempad

Steps to obtain a functional environment to develop and test eChempad in a Linux system.

## First steps

The first thing that we got to do is clone the repository that contains the software "Linux-Auto-Customizer". This
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

## Resolving dependencies

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

## Setting up database connection
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

#### Connect to the database manually using terminal
``` 
psql -d eChempad -h localhost -p 5432 -U amarine
```

#### Connect to the database manually using pgAdmin
Use `pgadmin` program to connect to the database using a graphical interface. To do so, just launch pgadmin by calling
the binary. You can access the interface using a web browser pointing to `localhost:5050`.

## ACL SQL schema & JPA entities SQL schema
The application combines *two* different strategies to initialize the SQL schema for our database and manipulate its
records:

The first strategy is using a `schema.sql` file, which by activating some properties in
`application.properties` like `spring.sql.init.mode=always` it can be executed every time our application goes up. We
can add SQL conditionals to initialize the schema if and only if the schema is not present. The schema is mainly used to
initialize the SQL tables for the ACL initialization.

The other strategy is using the automatic schema initialization that comes with JPA data repositories / entities.
By modifying the corresponding property `eChempad.db.policy` in `application.properties` we can choose to initialize the
schema when our app goes up, validate it, or do nothing.

The problem and the reason why I am documenting this is that there is an ACL table that also has an associated JPA
repository, and as such, the table can be initialized in both ways, which is wrong, since we need to use the ACL SQL
schema for the schema and the JPA repository to modify the tables programmatically.

The last paragraph means that on an initialization stage, where the database is empty, we need to create the
tables using the schema and *not* using the automatic initialization with JPA repositories. Why? Because we need to
programmatically modify the `SecurityId` table to add records, so users can be registered in the ACL service and
actually use the JPA generic controllers. By using a schema to generate the table we do not have this capability. So,
why not use only the repository to initialize the schema and also modify the table programmatically? Because if we use
Hibernate to initialize the corresponding table with the repository class `SecurityIdRepository` the schema of that
table is not the schema that the default implementation of ACL needs, and the ACL service will fail.

Database initialization by schema or by JPA repository seem to be mutually exclusive under spring boot and also database
initialization by repository takes precedence over the schema initialization, so two executions of the application are
needed to obtain the needed state in the database, with the first initialization failing because repository tables do
not exist.

To change the fact that two runs are needed to obtain the needed database state, you have some options:
- Add the needed Hibernate annotations to the class `SecurityIdRepository` so the schema created by Hibernate when using
  repository initialization is the correct one, and you also have the possibility to modify the table programmatically.
- Apply `schema.sql` before repository initialization takes place manually.
- Do not use a JPA repository to manipulate the table. Instead, use a regular repository that contains the SQL queries
  to manipulate the needed tables. Initialize the database with the schema, which is the recommended way to obtain the ACL
  tables.


#### Steps to reproduce a clean initialization
1- To ensure the proper initialization of the schema first begin by dropping all tables. You can use the SQL script
under `./tools`
2- Deactivate the initialization of JPA schema by setting the DB policy to *none*.
3- Run application. The ACL SQL schema will be read from the `schema.sql` script and the app will fail because the
schema for the JPA entities will not be present. The app should file with an error like this:
```
(...) org.springframework.dao.InvalidDataAccessResourceUsageException: could not extract ResultSet; SQL [n/a]; nested 
exception is org.hibernate.exception.SQLGrammarException: could not extract ResultSet
```

If the error is like this:

```
org.springframework.dao.DataIntegrityViolationException: PreparedStatementCallback; SQL [insert into acl_sid (principal, sid) values (?, ?)]; ERROR: null value in column "id" violates not-null constraint
```

It means that the database has been initialized using the JPA repositories, which is not what we need to do to properly
initialize the database for the `SecurityId` table. If that is the case, you can also check which tables have been
created. After the first run, you need to have *ONLY* the four tables of the ACL schema, not all the tables of the
program (ACL schema + JPA tables)

The *acl_sid* table will be created using the schema provided via a JPA entity class.
4- Reactivate the JPA initializations by setting the DB policy to *update*.
5- Rerun the application, which now should be working (even though because of admin initialization it can have an error
of duplicated primary key, but if your rerun one more time everything should be working). The ACL tables from the schema,
and the JPA tables
(except the *acl_sid* table, which comes from IdSecurity Entity JPA initialization) from the Entities are now fully
initialized.
6- We can encounter one more error while initializing the app, it goes like:
`org.postgresql.util.PSQLException: ERROR: duplicate key value violates unique constraint "acl_sid_pkey"` This happens
because we manipulate the acl_sid table "from behind" (not programmatically, we attack the raw SQL tables). And as such,
the first petitions to create an ACL can cause a collision. Rerun app and it should be working. In the next run,
the ACL service will answer correctly.

## IDE integration
Open the project by calling the binary `ideau` with the same working directory as teh repository.

After that the IDE will open and a lot of indexing and downloading will start. There are some things that you may need
to do in order to work with the project:
- File -> project structure -> set SDK to Amazon Coretto 1.8 (any 1.8 java will be fine)
- File -> project structure -> set language level to 1.8 (lambdas annotations..)
- File -> Settings -> Plugins -> ZK framework
- File -> Settings -> Plugins -> JPA buddy

-->