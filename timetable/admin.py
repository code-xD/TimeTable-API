from django.contrib import admin
from .models import Document, FoodItem, FoodCourt
# Register your models here.
admin.site.register(Document)
admin.site.register(FoodItem)
admin.site.register(FoodCourt)
