Sample project.

The project is made under XCode 9 (9A235)

Here is a simple app where user can interact with Google Books API.
https://developers.google.com/books
https://www.googleapis.com/books/v1/volumes

Functionality:
- download books from API with pagination
- detail view of the book
- search for the specific query
- filter books in the list (according to the rating)
- books in the list can be marked/unmarked as read (this info is saved locally)

Parts of the app:
1. MainInteractor.
- general business logic inside the app
- switching between different scenes (now it's only one)
- processing app events from the AppDelegate
- storing instances of global objects like DataSourse, NetworkManager, BackgroundServices, UserSession... (there's not so much of it so far =)).
2. DataService.
- The global realtime storage over the entire app
- interacting with API when necessary
3. DataStorage
- Persistence logic
4. APIClient
- API interaction
5. ViewControllerFactory.
- Instantiating app scenes/viewControllers
6. Scenes (List view, Detail view): ViewControllers + DataModels.
- VCs are only responsible for the layout, catching user interactions, displaying data from the models.
all the business logic, data formatting and processing, interacting with the DataService is suppose to be located in the models, not VCs.

Some used approaches:
- Modularity. Each piece of functionality is incapsulated in a proper class (set of classes).
- Clear objects' responsibilities (Not everywhere it's one responsibility, but not more than couple of them)
- Dependency Injection. Most of the objects are instantiated using DI and could be easily tested (with a help of moch-objects)

TODO:
- Additional functionality
* OperationQueue for the NetworkRequests
* additional book info in the detail view
* more filters in the list view
* persistency and offline mode
- Design
- UnitTests
