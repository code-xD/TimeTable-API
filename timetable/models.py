from django.db import models


class Document(models.Model):
    foodcourt = models.CharField(max_length=255, blank=True)
    document = models.FileField(upload_to='documents/')
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.description


class FoodItem(models.Model):
    item_date = models.DateField()
    item_name = models.CharField(max_length=500)
    item_food_plan = models.CharField(max_length=100)
    item_id = models.CharField(max_length=100, primary_key=True)
    item_foodcourt = models.CharField(default='Not Available', max_length=100)

    def save(self, *args, **kwargs):
        self.item_id = self.item_name[:5]+self.item_food_plan[:5]+str(self.item_date.day) + \
            str(self.item_date.month)+str(self.item_date.year)+self.item_foodcourt
        super().save(*args, **kwargs)

    def __str__(self):
        return self.item_id
