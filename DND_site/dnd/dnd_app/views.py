from django.shortcuts import render, get_object_or_404, redirect
from .models import *
from .forms import *
from django.utils import timezone
from django.http import Http404

# Create your views here.
def index(request):
    return render(request, "dnd_app/main.html")

def character_list(request):
    characters = Character_Class.objects.all()
    character_classes = CharacterByClassAndSubclass.objects.all()
    context = {
        'Characters': characters,
        'CharacterClasses': character_classes,
    }
    return render(request, "dnd_app/character_list.html", context)


def classes(request):
    data = Classes.objects.all()
    context = {'Classes': data}
    return render(request, "dnd_app/classes.html", context)
def feat(request):
    level = request.GET.get('level')  
    feats = Feat.objects.all()

    if level:
        feats = feats.filter(lvlReq=level)  

    context = {
        'Feat': feats,
        'Levels': Feat.objects.values_list('lvlReq', flat=True).distinct(),  
    }
    return render(request, "dnd_app/feat.html", context)

def spell(request):
    level = request.GET.get('level')
    school = request.GET.get('school') 

    spells = Spell.objects.all()

    if level:
        spells = spells.filter(spellLvl=level)
    if school:
        spells = spells.filter(school=school) 

    context = {
        'Spell': spells,
        'Levels': Spell.objects.values_list('spellLvl', flat=True).distinct(),
        'Schools': Spell.objects.values_list('school', flat=True).distinct(), 
    }
    return render(request, "dnd_app/spell.html", context)

def race(request):
    races = Race.objects.all()

    abilities_by_race = {}
    for race in races:
        abilities = AbilityByRace.objects.filter(race=race)
        abilities_by_race[race.race_id] = abilities

    context = {
        'Race': races,
        'AbilitiesByRace': abilities_by_race
    }
    return render(request, "dnd_app/race.html", context)

def background(request):
    data = Background.objects.all()
    context = {'Background': data}
    return render(request, "dnd_app/background.html", context)
def add_character(request):
    if request.method == 'POST':
        form = CharacterForm(request.POST)
        if form.is_valid():
            character = form.save()
            selected_class = form.cleaned_data.get('character_class')
            selected_subclass = form.cleaned_data.get('subclass')

            if selected_class and selected_subclass:
                CharacterByClassAndSubclass.objects.create(
                    character=character,
                    character_class=selected_class,
                    subclass=selected_subclass,
                )

            return redirect('character_list')
    else:
        form = CharacterForm()
    
    return render(request, 'dnd_app/add_character.html', {'form': form})
def add_spell(request):
    if request.method == 'POST':
        form = SpellForm(request.POST)
        if form.is_valid():
            form.save()  #Save the form data to the database
            return redirect('spell')  #Redirect to a page showing all spells
    else:
        form = SpellForm()
    return render(request, 'dnd_app/add_spell.html', {'form': form})
 
def subclasses(request):
    selected_class = request.GET.get('class')  # Get the selected class from the query string

    subclasses = Subclass.objects.all()
    if selected_class:
        subclasses = subclasses.filter(className__className=selected_class)  # Filter by class name

    context = {
        'Subclasses': subclasses,
        'Classes': Classes.objects.values_list('className', flat=True).distinct(),  # Get unique class names
    }
    return render(request, "dnd_app/subclasses.html", context)

def create_subclass(request):
    if request.method == 'POST':
        form = SubclassForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('subclasses')
    else:
        form = SubclassForm()
    return render(request, 'dnd_app/create_subclass.html', {'form': form})

def create_party(request):
    if request.method == 'POST':
        party_name = request.POST.get('party_name')
        member_ids = request.POST.getlist('members')

        if party_name and member_ids:
            party = Party.objects.create(name=party_name)
            party.members.add(*member_ids)
            return redirect('party_list')
    return redirect('character_list')


def party_list(request):
    parties = Party.objects.all()
    return render(request, 'dnd_app/party_list.html', {'parties': parties})
