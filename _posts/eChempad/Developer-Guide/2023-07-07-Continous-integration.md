---
layout: default
title: Continous integration
permalink: /eChempad/Developer-Guide/Continous-integration/
parent: Developer Guide
grand_parent: eChempad
nav_order: 4
---

## Continuous Integration
The project has continuous integration features:
#### Auto-generation of license
Using the Maven licenses plugin we can autogenerate the copyright headers for each file of the project and also collect
all the third party libraries used by listing the dependencies in pom.xml.

The next instruction will generate all licenses and attach it to the source files.
Warning: It appends more than one time if executed in sequence.
```
mvn -Dthird.party.licenses=true -Dattach.license.header=true generate-resources 
```

There is a small problem and is that in Java the headers for the copyright are added as a JavaDoc, which converts the
headers to a dangling JavaDoc. Is preferred a normal comment. Issuing this command from the same folder as the project
will change them to a normal comment:
```bash
IFS=$'\n'; for j in $(grep -r -I -l .); do sed '1 s|/\*\*|/\*|' -i "$j"; done
```