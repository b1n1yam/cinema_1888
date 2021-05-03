# Cinema 1888

Cinema booking mobile app demo


This documentation shows the specification and detail of the application developed based on the requirement provided by the 1888 team. 

# pre requisite
* flutter sdk >=2.7.0 <3.0.0"
* gradle(android) > 3.5
* device min-sdk(android) > 15

# Introduction


* The application uses [https://api.themoviedb.org/3/](https://api.themoviedb.org/3/) to get movies list
* The application also uses a custom database to perform seat booking get booking data. The backend is hosted on [https://cinema1888.herokuapp.com/](https://cinema1888.herokuapp.com/) and the database on [https://cloud.mongodb.com/](atlas) server. You can access the backend and the API documentation by going to the following links

[cinema 1888 Backend instructions](https://github.com/exeligent/cinema1888_backend)

[cinema 1888 API documentation](https://documenter.getpostman.com/view/9164090/TVt184X7)


### folder structure
The folder structure of the project is as follows (considering the ``` lib``` folder as root)
```
    .
    ├── corre                      # Functionalities used throught the app
        ├── constants                # configuratin files
        ├── helpers                  # helper functions 
        ├── models                   #  REST API managment files
    ├── pages                      # UI source files
    ├── repositories               # abstract REST API service
    ├── services                   # REST API services
    ├── widgets                    # UI component files
    ├── main.dart                 # root file (App starter)

   ```  
 

# core features

1. ### Custom backend
Instead of using a dummy data to reserve seats, I have implemented a custom backend to achieve that functionality. That means, all seat booking actions are performed in realtime and persistantly. But the time and date data are still statc. Although the seat reservation is dynamic, it is applied on all movie lists. That means all movies use the same schedule program. Since the movies database is of a different source, it requires a complex database design which is time consuming

2. ### Booking for a specific time and date
 Booking seats is differentiated by each time and date. i.e All booking are unique for a specific time and date

3. ### Unique movie tickets
Movie tickets are generated dynamically and are unique among users. The ticket holds a unique qr code that is generated from a unique ticket id.

 
4. ### Code spiting
In order to achieve some goal, an app has to perform a series of actions. These actions can be sometimes coupled and tied together. The project structure of this project is well formatted for such conveniences. The project is dissected in to sub components to achieve a lesly coupled architecture and a readable code.  

5. ### User friendly Error handling
Developing a local application doesn't need a complex error handling mechanism. But in the case of applications that work with a network layer, error handling is a  major concern. Having this in mind, I have used advanced error handling mechanisms so that the user experience of the app is insured.

6. ### State management/ service locator
 The app uses the Get.It service locator package to manage states across the app 
 
7. ### Dynamic ui concept
 Beside using splitted code, the app also introduce the concept of dynamic ui, i.e, rendering ui components based on a certain configuration. For instance ```pages/buy-ticket.dart``` file contains the logic for reserving seats. This component can have any amount of seats based on the ```xMax``` and ```yMax``` values.  Thus, the section emphasizes a concept of dynamic UI forms by creating a mock server response.  This also makes it easy to fetch these elements from an API.

* The following code shows a snapshot of the vertical seat drawer function

```
 List<Widget> getCinemaSeats() {
    List<Widget> verticalList = new List<Widget>();
    for (int i = 0; i < yMax + 1; i++) {
      verticalList.add(getHorzontalList(i));
    }
    return verticalList;
  }

```

## instructions for running the app locally
 
* First you will need to clone this repository
* Then will need to point the root API url to your local machine. This can be done by going to the ```/lib/core/constants/constants.dart``` file and changing the ```APIRoot``` variable to your backend's ip address.

* Make sure the backend is running on your local machine
* Use the IP ```http://10.0.2.2:5000``` to access the backend from your emulator

# Help
The app has multiple error handling mechanisms. Unfortunately there are some errors that might not be caught by the app either by errors outside from the scope of the app or a development error. If this happens please report it as an issue on github*/
 




 
