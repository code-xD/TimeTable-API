# MyMenu Mobile App

## Backend : Django RestFramework API

Backend Developer: Shivansh Anand @ github.com/code-xD

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
- **GET /get_item/?item_food_plan=BREAKFAST&item_name=&item_date=2019-04-08** - </br> gets fooditems for specified meal and date.

For further details, feel free to search:
- REST APIs
- Filtering
- django-filter
- Django REST Framework Filtering
