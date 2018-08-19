# Wunder

A small scalable application designed with MVVM architecture.

The application fetches the list of cars from api in json format. Then the app lists the cars and their corresponding informations and the list can then be searched by address, car name or vin. The app also displays all the cars on the map and also the user's location.

Features:

-> Search functionality is added to the car listing which helps the user to search by address, car name or vin.

-> The list of cars also has the percentage (status) of fuel contained in the car. This is visually represented in the car listing.

-> All the cars are displayed on the map. On tapping on a car on the map the carname is displayed on top of the car and all the other annotations(cars) on map are removed. On tapping the selected car again the car name is removed and all the cars are displayed on the map again.

-> Current user location is fetched and the location is updated on the map. 

Architecture:

I have used MVVM for developing the application. In order to keep the business logic free from the view and the models I have created the “View Model” layer which encapsulates the business model used by the application. This helps to keep the view controller and the view files to have very less and ‘to the point’ code. This also completely isolates the model. Data Binding is also implemented using Generics to make the code cleaner and update the UI automatically whenever the datasource changes.

Unit test cases are executed for few business logic to ensure that the code is working as expected.
