from django.shortcuts import render, redirect
from .forms import DocumentForm
from .models import Document, FoodItem
from django.http import HttpResponse
from django.conf import settings
from .ttparser import yield_food_items
from .serializers import ItemSerializer, ItemFilter
from rest_framework import generics, filters
from rest_framework.response import Response

# Create your views here.


def formuploadview(request):
    if request.method == 'POST':
        form = DocumentForm(request.POST, request.FILES)
        filename = str(request.FILES).split('.')
        if form.is_valid():
            doc = form.save()
            for food_items in yield_food_items(settings.MEDIA_ROOT+'/'+str(doc.document)):
                fooditem = FoodItem(item_date=food_items[1], item_name=food_items[0],
                                    item_food_plan=food_items[2])
                fooditem.save()
            return redirect('/form/')
    else:
        form = DocumentForm()
    return render(request, 'timetable/home.html', {
        'form': form
    })


class ItemReturnView(generics.ListAPIView):
    queryset = FoodItem.objects.all()
    serializer_class = ItemSerializer
    filter_class = ItemFilter
