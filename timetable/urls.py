from django.contrib import admin
from django.urls import path, include
from .views import formuploadview, ItemReturnView, UserRegisterView, AllFoodCourt
from rest_framework.urlpatterns import format_suffix_patterns
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('form/', formuploadview, name='form_upload_view'),
    path('get_item/', ItemReturnView.as_view(), name='API_item_view'),
    path('login/', auth_views.LoginView.as_view(template_name='timetable/login.html'), name='login'),
    path('register/', UserRegisterView, name='register'),
    path('getfoodcourt/', AllFoodCourt, name='get-all-foodcourt')
]
