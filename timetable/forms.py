from django import forms
from .models import Document, FoodCourt, User


class DocumentForm(forms.ModelForm):
    class Meta:
        model = Document
        fields = ('document',)

    def save(self, user, commit=True):
        instance = super(DocumentForm, self).save(commit=False)
        instance.uploader = user
        if commit:
            instance.save()
        return instance


class FoodCourtForm(forms.Form):
    Foodcourt = forms.ModelChoiceField(queryset=FoodCourt.objects.all())

    def __init__(self, user, *args, **kwargs):
        super(FoodCourtForm, self).__init__(*args, **kwargs)
        self.fields['Foodcourt'].queryset = FoodCourt.objects.filter(user=user)
