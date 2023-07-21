---
layout: default
title:  Spring Boot
permalink: /eChempad/Developer-Guide/Spring-Boot/
parent: Developer Guide
grand_parent: eChempad
---


## Spring Boot general concepts

#### Inversion of control
Spring-boot particularly is focused on using a pattern design called inversion of control, in which the programming is less
imperative and explicit, and becomes declarative and aspect-oriented.

Basically one of the most used features is the automatic dependency injection. When annotating a class with `@Component`
we are telling Spring-Boot that a class can be auto-injected in places where the `@Autowired` annotation is present.

This is useful because we do not need to initialize or instantiate the classes of our program.

### Annotations

#### `@Converter`
A converter is a class that defines two methods to interchange the format between two classes A and B. It is
particularly used transparently when in need to convert a memory object to a serializable type when introducing it into
the DB and vice-versa.

The `@Converter` annotation can receive a parameter `autoApply = bool` so it performs automatic translation between
types implicitly, there is no need to call directly the methods. Spring will call it for you when needed.

In the following example the converter is used to convert Paths to String (Serializable) and vice-versa:

```
@Converter(autoApply = true)  
public class PathConverter implements AttributeConverter<Path, String>, Serializable {

    @Override
    public String convertToDatabaseColumn(Path path) {
        return path == null ? null : path.toString();
    }

    @Override
    public Path convertToEntityAttribute(String s) {
        return s == null ? null : Paths.get(s);
    }
} 
```


#### `@Component` and its specialized `@Service`, `@Controller`, `@RestController`, `@Repository`
All classes marked with these annotations are converted automatically into components that Spring Boot is able to inject
in runtime. The specializations provide some useful effects if we are actually using a specialized component annotation:
- `@Repository`: Marks all method as transactional and handles the session automatically inside them. Repository is used in
  classes that are responsible for communicating with a DB.
- `@Service`: The class provides a service inside the application.
- `@Controller`: Handles the serialization and deserialization of data coming in and out of the methods of the class.
  Controller provides endpoints that our clients are connected to, and as such they are the first and last piece of code
  executed when handling a request.
- `@RestController`: The same as a controller, but provides support for the typical CRUD operations.

#### `@Autowired`
This annotation is used to annotate a property of a class, setter of a property or constructor. This tells Spring Boot
that a field needs to be automatically injected. Then, we do not need to initialize or call the constructor of that
class.

## Access Control List permissions
We use the default permission evaluator of Spring Security, which does not do bitwise operations to check the
permissions against something. So the default with this code is the following:
- 1 means "READ"
- 2 means "Write"
- 4 means "Create"
- 8 means "Delete"
- 16 means "Administer"