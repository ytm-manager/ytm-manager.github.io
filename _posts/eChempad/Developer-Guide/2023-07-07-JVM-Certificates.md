---
layout: default
title: JVM certificates
permalink: /eChempad/Developer-Guide/JVM-certificates/
parent: Developer Guide
grand_parent: eChempad
nav_order: 5
---


## Certificates of the JVM
The certificates of java are stored in the `cacerts` file, which can be located in different places of the system. We
have our own cacerts file uploaded to the git repository, which is located in `./eChempad/src/mainComposer/resources/CA_certificates/cacerts`
and is the one that we are using.

To check the presence of certificates inside this cacerts file we can use the following command:

```
keytool -list -keystore ~/Desktop/eChempad/src/mainComposer/resources/CA_certificates/cacerts -storepass changeit
```

If you can not see any certificate you must download another cacerts file or update the JDK you are using, since from
time to time the certificates expire and will not work.

