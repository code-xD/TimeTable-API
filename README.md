# TimeTable-API
In order to setup the files for developement-\n
_1.Create Virtualenv\n
_2.pip install -r requirements.txt
_3.python manage.py makemigrations
_4.python manage.py migrate
_5.python manage.py createsuperuser
_6.python manage.py runserver
_7.Now go to https://localhost:8000/form/
If the site is visible then voila the django project has been setup.
Go to: https://localhost:8000/get_item/ to do a get request of all the food items uploaded to the database 
       with the days they are being served and the scheme.
       https://localhost:8000/get_item/?item_date=YYYY-MM-DD to get the food items on a particular day.
For more url options search for following terms:
                                      1.ReST API
                                      2.Filtering
                                      3.Django-filter
                                      4.Django Rest Framework Filtering
In order to know more querysets feel free to contact me ;)                                      
