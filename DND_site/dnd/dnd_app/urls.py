from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name="index"),
    path('character/', views.character_list, name='character_list'),
    path('Classes/', views.classes, name='classes'),
    path('Feats/', views.feat, name='feat'),
    path('Spells/', views.spell, name='spell'),
    path('Race/', views.race, name='race'),
    path('Background/', views.background, name='background'),
    path('character/add/', views.add_character, name='add_character'),
    path('add_spell',views.add_spell,name = 'add_spell'),
]
