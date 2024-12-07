from django import forms
from .models import *


class CharacterForm(forms.ModelForm):
    class Meta:
        model = Character_Class
        fields = ['character_name', 'STR', 'DEX', 'CON', 'INTE', 'WIS', 'CHA', 'race', 'background']
    character_class = forms.ModelChoiceField(
    queryset=Classes.objects.all(),
    required=True,
    label="Class"
    )
    subclass = forms.ModelChoiceField(
        queryset=Subclass.objects.all(),
        required=True,
        label="Subclass"
    )

class SpellForm(forms.ModelForm):
    class Meta:
        model = Spell
        fields = ['SpellName', 'spellLvl', 'descript', 'school']
        widgets = {
            'description': forms.Textarea(attrs={'rows': 3, 'cols': 40}),
           
        }

class SubclassForm(forms.ModelForm):
    class Meta:
        model = Subclass
        fields = ['className','subclass_name','descript']
        widgets = {
            'description': forms.Textarea(attrs={'rows': 3, 'cols': 40}),
           
        }