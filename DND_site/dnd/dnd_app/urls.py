from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name="index"),
    path('character/', views.character_list, name='character_list'),
    path('Classes/', views.classes, name='classes'),
    path('Feats/', views.feat, name='feat'),
]
