from django.contrib import admin
from django.urls import path, include
from .views import formuploadview, ItemReturnView
from rest_framework.urlpatterns import format_suffix_patterns


urlpatterns = [
    path('form/', formuploadview, name='form_upload_view'),
    path('get_item/', ItemReturnView.as_view(), name='API_item_view')
]
