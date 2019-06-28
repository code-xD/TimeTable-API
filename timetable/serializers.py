
import django_filters
from rest_framework import serializers
from .models import FoodItem


class ItemFilter(django_filters.FilterSet):
    class Meta:
        model = FoodItem
        fields = ['item_food_plan', 'item_name', 'item_date',
                  'item_foodcourt']


class ItemSerializer(serializers.ModelSerializer):
    item_foodcourt = serializers.StringRelatedField()

    class Meta:
        model = FoodItem
        fields = ['item_food_plan', 'item_name', 'item_id', 'item_date', 'item_foodcourt']
