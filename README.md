## BOOKS

Sample project.

The project is built under XCode 10, Swift 4

Here is a simple app where user can interact with Google Books API.
  - https://developers.google.com/books
  - https://www.googleapis.com/books/v1/volumes


### Functionality:
- downloading books from API 
- displaying books in table view (list) with pagination
- search for the specific query in the list
- filter books in the list (according to the rating)
- books in the list can be marked/unmarked as read (this info is saved locally)
- detail view of the book


### Parts of the app:
1. **AppCoordinator**
  - general business logic inside the app
  - switching between different scenes (now it's only one)
  - processing app events from the AppDelegate
  - storing instances of global objects like DataSourse, NetworkManager, BackgroundServices, UserSession... (there's not so much of it so far =)).
2. **Presenter**
  - Handling MainWindow
  - Technical switching between the screens and scenes
3. **DataService**
  - The global realtime storage over the entire app
  - interacting with API when necessary
4. **DataStorage**
  - Persistence logic
5. **APIClient**
  - API interaction
6. **ViewControllerFactory**
  - Instantiating app scenes/viewControllers
7. **ServicesFactory**
  - Instantiating the services (replacing them with mocks for testing)
8. **Scenes (List view, Detail view):** ViewControllers + DataModels.
  - VCs are only responsible for the layout, catching user interactions, displaying data from the models.
all the business logic, data formatting and processing, interacting with the DataService is suppose to be located in the models, not VCs.


### Some used approaches:
  - Modularity. Each piece of functionality is incapsulated in a proper class (set of classes).
  - Clear objects' responsibilities (Not everywhere it's one responsibility, but not more than couple of them)
  - Dependency management suitable for clear understanding and testing. In most cases it's Dependency Injection or instantiating through factories.


### TODO:
- Additional functionality
  * OperationQueue for the NetworkRequests
  * additional book info in the detail view
  * more filters in the list view
  * persistency and offline mode
- Design
- UnitTests
