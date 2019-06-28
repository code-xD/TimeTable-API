from django.db import models
from django.contrib.auth.models import User


class Document(models.Model):
    uploader = models.ForeignKey(User, on_delete=models.CASCADE)
    document = models.FileField(upload_to='documents/')
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return str(self.document)


class FoodCourt(models.Model):
    name = models.CharField(max_length=200)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    FID = models.CharField(max_length=200, unique=True, primary_key=True)

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        self.FID = self.name+'-'+str(self.user)
        super().save(*args, **kwargs)


class FoodItem(models.Model):
    item_date = models.DateField()
    item_name = models.CharField(max_length=500)
    item_food_plan = models.CharField(max_length=100)
    item_id = models.CharField(max_length=100, primary_key=True, unique=True)
    item_foodcourt = models.ForeignKey(FoodCourt, on_delete=models.CASCADE)

    def save(self, *args, **kwargs):
        self.item_id = self.item_name[:5]+self.item_food_plan[:5]+str(self.item_date.day) + \
            str(self.item_date.month)+str(self.item_date.year)+str(self.item_foodcourt)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.item_id
