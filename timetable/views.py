from django.shortcuts import render, redirect
from .forms import DocumentForm, FoodCourtForm
from .models import FoodItem, FoodCourt
from django.http import JsonResponse
from django.conf import settings
from .ttparser import yield_food_items
from .serializers import ItemSerializer, ItemFilter
from rest_framework import generics
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.forms.models import model_to_dict

# Create your views here.


@csrf_exempt
@login_required
def formuploadview(request):
    if request.method == 'POST':
        f_form = FoodCourtForm(request.user, request.POST)
        d_form = DocumentForm(request.POST, request.FILES)
        if f_form.is_valid() and d_form.is_valid():
            doc = d_form.save(request.user)
            fcname = f_form.cleaned_data['Foodcourt']
            for food_items in yield_food_items(settings.MEDIA_ROOT+'/'+str(doc.document)):
                fooditem = FoodItem(item_date=food_items[1], item_name=food_items[0],
                                    item_food_plan=food_items[2], item_foodcourt=fcname)
                fooditem.save()
            return redirect('/form/')
    else:
        d_form = DocumentForm()
        f_form = FoodCourtForm(request.user)
    return render(request, 'timetable/document.html', {
        'formd': d_form,
        'formf': f_form
    })


class ItemReturnView(generics.ListAPIView):
    queryset = FoodItem.objects.all()
    serializer_class = ItemSerializer
    filter_class = ItemFilter


def UserRegisterView(request):
    if request.method == 'POST':
        print(request.POST)
        req = request.POST
        if req['password1'] == req['password2']:
            user = User.objects.create_user(
                req['username'], req['email'], req['password1'])
            user.save()
            for fc in req.getlist('foodcourt'):
                fccreate = FoodCourt(name=fc, user=user)
                fccreate.save()
        return redirect('/login/')
    return render(request, 'timetable/form.html')


def AllFoodCourt(request):
    foodcourt = FoodCourt.objects.all()
    fc = []
    for fdc in foodcourt:
        fc.append(model_to_dict(fdc))
    return JsonResponse(fc, safe=False)
