---
layout: default
title:  Signals metadata
parent: Developer Guide
grand_parent: eChempad
---

# Metadata in Signals
In this document we show the structure and format of the different JSONs obtained 
from scratching the API of the Signals notebook. 

## Journal (Container)

#### Signals container metadata example
```json
{
  "links": {
    "self": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/entities?includeTypes=container&include=children, owner&page[offset]=7&page[limit]=1",
    "first": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/entities?includeTypes=container&include=children, owner&page[offset]=0&page[limit]=1",
    "prev": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/entities?includeTypes=container&include=children, owner&page[offset]=6&page[limit]=1",
    "next": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/entities?includeTypes=container&include=children, owner&page[offset]=8&page[limit]=1"
  },
  "data": [
    {
      "type": "Entity",
      "id": "container:ddac1092-5f55-4952-a5f1-7f2c553fef46",
      "links": {
        "self": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/entities/container:ddac1092-5f55-4952-a5f1-7f2c553fef46"
      },
      "attributes": {
        "id": "container:ddac1092-5f55-4952-a5f1-7f2c553fef46",
        "eid": "container:ddac1092-5f55-4952-a5f1-7f2c553fef46",
        "name": "Linear Acenes",
        "description": "",
        "createdAt": "2020-05-27T19:52:54.871Z",
        "editedAt": "2020-05-27T19:52:54.871Z",
        "type": "container",
        "digest": "43254827",
        "fields": {
          "Confidential": {
            "value": "No"
          },
          "Department": {
            "value": "Echavarren"
          },
          "Description": {
            "value": ""
          },
          "Name": {
            "value": "Linear Acenes"
          }
        }
      },
      "relationships": {
        "createdBy": {
          "links": {
            "self": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/users/183"
          },
          "data": {
            "type": "user",
            "id": "183"
          }
        },
        "editedBy": {
          "links": {
            "self": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/users/183"
          },
          "data": {
            "type": "user",
            "id": "183"
          }
        },
        "owner": {
          "links": {
            "self": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/users/183"
          },
          "data": {
            "type": "user",
            "id": "183"
          }
        },
        "children": {
          "links": {
            "self": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/entities/container:ddac1092-5f55-4952-a5f1-7f2c553fef46/children"
          }
        }
      }
    }
  ],
  "included": [
    {
      "type": "user",
      "id": "183",
      "links": {
        "self": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/users/183"
      },
      "attributes": {
        "userId": "183",
        "userName": "ostoica@iciq.es",
        "alias": "ostoica",
        "email": "ostoica@iciq.es",
        "firstName": "Otilia",
        "lastName": "Stoica"
      },
      "relationships": {
        "systemGroups": {
          "links": {
            "self": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/users/183/systemGroups"
          }
        }
      }
    }
  ]
}
```


#### Signals container metadata action 

```json
{
  "links": {
    "self": "IGNORED",
    "first": "IGNORED",
    "prev": "IGNORED",
    "next": "IGNORED"
  },
  "data": [
    {
      "type": "PARSED FOR CHECKS, it will be always an entity",
      "id": "KEPT structural metadata, for reference to the corresponding container in Signals",
      "links": {
        "self": "IGNORED (can be deduced using the id value)"
      },
      "attributes": {
        "id": "IGNORED, already present in the field data[0].id",
        "eid": "IGNORED, already present in the field data[0].id",
        "name": "KEPT, descriptive metadata",
        "description": "KEPT, descriptive metadata",
        "createdAt": "KEPT, descriptive metadata",
        "editedAt": "KEPT, descriptive metadata, is an extra field for signals or is the same field as in echempad?",
        "type": "PARSED FOR CHECKS, it will be always an entity",
        "digest": "IGNORED, we do not know units, algorithm of digest nor actual structure of the digested file(s). If we want it we will implement our own.",
        "fields": {
          "Confidential": {
            "value": "IGNORED BY NOW, it can be parsed to enforce extra privatization of data"
          },
          "Department": {
            "value": "KEPT, descriptive metadata"
          },
          "Description": {
            "value": "IGNORED, already present in the field data[0].attributes.description"
          },
          "Name": {
            "value": "IGNORED, already present in the field data[0].attributes.description"
          }
        }
      },
      "relationships": {
        "createdBy": {
          "links": {
            "self": "IGNORED, we will only be keeping the owner"
          },
          "data": {
            "type": "IGNORED, we will only be keeping the owner",
            "id": "IGNORED, we will only be keeping the owner"
          }
        },
        "editedBy": {
          "links": {
            "self": "IGNORED, we will only be keeping the owner"
          },
          "data": {
            "type": "IGNORED, we will only be keeping the owner",
            "id": "IGNORED, we will only be keeping the owner"
          }
        },
        "owner": {
          "links": {
            "self": "IGNORED, data present in the included section of the JSON"
          },
          "data": {
            "type": "IGNORED, data present in the included section of the JSON",
            "id": "IGNORED, data present in the included section of the JSON"
          }
        },
        "children": {
          "links": {
            "self": "PARSED FOR CHECKS, recursively parsed from the base Journal inorder to scratch all data from the container. "
          }
        }
      }
    }
  ],
  "included": [
    {
      "type": "PARSED FOR CHECKS, it should be always equal to user",
      "id": "IGNORED BY NOW, we may keep it in the future to keep a back reference to the id of the user in Signals",
      "links": {
        "self": "IGNORED, deducible from the id of the included section"
      },
      "attributes": {
        "userId": "IGNORED, deducible from the id of the included section",
        "userName": "IGNORED, not needed",
        "alias": "IGNORED",
        "email": "PARSED FOR CHECKS, it should be equal to the email of the user logged in eChempad if desired, in order to filter the scratching of resources to the ones that are owned",
        "firstName": "Otilia",
        "lastName": "Stoica"
      },
      "relationships": {
        "systemGroups": {
          "links": {
            "self": "https://iciq.signalsnotebook.perkinelmercloud.eu/api/rest/v1.0/users/183/systemGroups"
          }
        }
      }
    }
  ]
}
```

### Structure of a parsed container instance from JSONs
Here are the fields that a generic instance in the database that contains pulled data has. We also specify some restrictions 
```
UUID id <-- UUID.generate()  // generated mathematically with no expected collisions, not null
String name <-- data[0].attributes.name  // Field comes from generic superclass, not null
String description <-- data[0].attributes.description  // Field comes from generic superclass, nullable
String originId <-- data[0].attributes.id  // Difference between id and eid, nullable
Enum originPlatform <-- {Signals, eChempad}  // Hardcoded depending on the service used to import
Date creationDate <-- parseDate(data[0].attributes.createdAt)  // Format 2020-05-27T19:52:54.871Z, comes from generic superclass, not null
Date editionDate <-- parseDate(data[0].attributes.editedAt)  // Same format, comes from generic superclass, not null
String/Enum originType <-- data[0].attributes.type
long int digest <-- data[0].attributes.digest  // No idea how to compute this. I suspect is MD5 algorithm, but I do not know the input data. Maybe is the returned JSON? 
boolean confidential <-- data[0].attributes.confidential
Enum department <-- [Echavarren, Bo, Lopez...]
String ownerUsername <-- parseEmail(included[0].attributes.userName)  // included[0].attributes.userName.email seems to have the same data.
```
We deduce some questions from this:
- Digest algorithm. Guess or find out.
- username vs email have same values. Is this consistent?
- We need a date comparator

#### Recursion <<<<<<< Iteration
Recursion is natural for humans but bad for machines. They may produce Stack Overflow exceptions. 

On last version, pulling from Signals was done using recursion. The biggest scope of the algorithm was a `for loop` that iterated over all the containers (journals) available for a certain user (iteration).
But for each journal pulled, a recursion was being done to get data from the children of each journal recursively. Recursion stopped at the "third" level because Signals Notebooks only accept three levels of containerization; from root to leafs: journal, experiment, document. 

The problem was that if we wanted to show journals in eChempad that are available in Signals Notebooks, we need to also pull the experiments and documents that are dangling from the journal, making it a very slow operation.

Instead, we should implement an asynchronous iterative pulling of the children on demand:
- First, use iteration to get all journals of an user. Do not use recursion to get children. Children will be pulled on demand AKA every time the user click in the front-end to expand a journal to see the children, API requests will be made to retrieve all children and show them.
- This means that every journal instance needs to be mapped somehow to the original entity in the origin platform. I was thinking in saving the JSON response, but having only the ID is cleaner and I think it will work the same. So basically we will save the original ID. It is possible that we save the children if it is not enough with the original ID or for example if we need to repeat the same API call.
- When a user clicks to expand a journal which children have not been retrieved, n API requests will be issued to get data of the n children of the journal.
- Same will happen with an experiment, since conceptually is also a container.

#### Updating algorithm
So, pulling new data from Signals to eChempad is easy and it is already implemented. But how to pull data from Signals that has already been pulled and deciding if we need to update the corresponding data in eChempad or not? Using the last modification date (editedAt). 

Another thing to take into account is that pulling will be done in another part of the frontend. Entities that are not definetely saved in eChempad will be "lost". This means the importation is ephemeral and not in batch anymore. We want to get all the information in batch, but we do not need to pull it in batch too. The user will choose which journals is he going to keep in a fine-grained manner.

So the general algorithm will be:
- Open tab Import
- Config: Introduce Signals API key, choosing API endpoint if needed, checking only owned resources...
- Click on "show journals in Signals"
- This will iteratively get all journals in signals and display them in a tree-like panel. Only journals, not children. Journals that have been pulled but their children have not, are called shallow journals
- **If edition date is cascaded to the parent** (it is, last edited date updates when making a change to a document that is grandson of the journal) we can classify journals in three types depending on their presence in the eChempad DB
  - Not present: This is a new journal, we can create a new journal in our database. Case already solved.
  - Already present: This means that the id of the entity that we are reading is already present in an entity present in the database. Three cases may arise:
    - Already present with edited date equal. Ignore it, the content in Signals has not changed. We do not need to update.
    - Already present with edited date more recent in Signals. This means that Signals contains new data that we need to update into eChempad. Perform update algorithm over the journal against the journal already present in the DB
    - Already present with edited date more recent in eChempad. Show an error or mark the journal as already present in eChempad with changes in eChempad that will be lost if we update this journal.
   
   

This depends on if the edition date is cascaded to the parent. 




