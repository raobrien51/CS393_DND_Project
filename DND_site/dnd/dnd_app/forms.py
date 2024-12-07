from django import forms
from .models import *


class CharacterForm(forms.ModelForm):
    class Meta:
        model = Character_Class
        fields = ['character_name', 'STR', 'DEX', 'CON', 'INTE', 'WIS', 'CHA', 'race', 'background']

class SpellForm(forms.ModelForm):
    class Meta:
        model = Spell
        fields = ['SpellName', 'spellLvl', 'descript', 'school']
        widgets = {
            'description': forms.Textarea(attrs={'rows': 3, 'cols': 40}),
           
        }