# MyContacts

A simple iOS App written on Swift, that displays a lisf of contacts of a phone, containing name, surname and phone number. The contacts are retrieved using the system provided framework.


## Structure

- Overall I tried to make the structure as maintainable and scalable as possible, as well as dividing (and isolating) the responsibility accordingly. This might add a small layer of 
complexity, but in the end it was for trying to face it like a product in a real environment.

- Currently the app is using a simple **MVVM** structure, having one main ```ContactsViewModel``` that will serve the information to the ```ContactsViewController```.

- A manager layer of ```ContactFetcher``` has been created as well, to manage and process all the Contact Store operations.

- A model layer ```Contact``` to contain the necessary info from the retrieved ```CNContact```.

- The UI is really simple as well, being setup without storyboards or xibs, and consisting on a simple TableView, using the default ```UITableViewCells``` to contain the
title (name + surname) and subtitle (phone number).

## :books: Libraries 

- DSL to make Auto Layout easy on iOS: [SnapKit](https://github.com/SnapKit/SnapKit). 
