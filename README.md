# MyMenu Mobile App

MyMenu is a mobile application made for the students of MAHE colleges in Manipal. The app is based on a Django RESTFUL API hosted on Heroku which is used by the Flutter Native App to get Menu data in the form of JSON objects, which is then displayed as a list.

Future challenges - 
- [ ] Sort foodcourts college-wise.
- [ ] To scale up this application to be used by all colleges around the country.

## Backend : Django RestFramework API

Backend Developer: [Shivansh Anand](https://github/code-xD/)

To setup files for Development: </br>
- Create virtualenv (optional)
```
$ pip install -r requirements.txt
$ python manage.py makemigrations
$ python manage.py migrate
$ python manage.py createsuperuser
$ python manage.py runserver
```
- Browse http://localhost:8000/form/ </br>

#### API Endpoints
- **GET /get_items/** - </br> gets all fooditems stored.
- **GET /get_item/?item_food_plan=BREAKFAST&item_name=&item_date=2019-04-08&item_foodcourt=FC1-admin** - </br> gets fooditems for specified meal, date and foodcourt.
- **GET /getfoodcourt/** - </br> gets all the foodcourts present in database.

For further details, feel free to search:
- REST APIs
- Filtering
- django-filter
- Django REST Framework Filtering

## Frontend : Flutter Native App

Frontend Developer: [Sayantan Karmakar](https://github.com/sayantank/)

### Built with

* Flutter
* Dart
