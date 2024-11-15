from django.db import models

from django.db import models

class Character_Class(models.Model):
    character_name = models.CharField(max_length=255)
    STR = models.IntegerField()
    DEX = models.IntegerField()
    CON = models.IntegerField()
    INTE = models.IntegerField()
    WIS = models.IntegerField()
    CHA = models.IntegerField()
    race = models.ForeignKey('Race', on_delete=models.SET_NULL, null=True)
    background = models.ForeignKey('Background', on_delete=models.SET_NULL, null=True)

    def __str__(self):
        return f"{self.character_name}"

    class Meta:
        db_table = "Character_Class"

class Skill(models.Model):
    skillName = models.CharField(max_length=15)

    def __str__(self):
        return self.skillName

    class Meta:
        db_table = "Skills"

class WpnType(models.Model):
    wpnTypeName = models.CharField(max_length=20)

    def __str__(self):
        return self.wpnTypeName

    class Meta:
        db_table = "WpnType"

class Tool(models.Model):
    toolName = models.CharField(max_length=50)

    def __str__(self):
        return self.toolName

    class Meta:
        db_table = "Tools"

class Classes(models.Model):
    className = models.CharField(max_length=10, primary_key=True)
    descript = models.TextField()
    hitDice = models.CharField(max_length=4)
    savingThrowOne = models.CharField(max_length=3)
    savingThrowTwo = models.CharField(max_length=3)

    def __str__(self):
        return f"{self.className}"

    class Meta:
        db_table = "Classes"

class SkillsbyClass(models.Model):
    skill = models.ForeignKey(Skill, on_delete=models.CASCADE)
    className = models.ForeignKey(Classes, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.className} - {self.skill}"

    class Meta:
        db_table = "SkillsbyClass"

class WpnTypeByClass(models.Model):
    wpn = models.ForeignKey(WpnType, on_delete=models.CASCADE)
    className = models.ForeignKey(Classes, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.className} - {self.wpn}"

    class Meta:
        db_table = "wpnTypebyClass"

class ToolByClass(models.Model):
    tool = models.ForeignKey(Tool, on_delete=models.CASCADE)
    className = models.ForeignKey(Classes, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.className} - {self.tool}"

    class Meta:
        db_table = "ToolbyClass"

class ClassByLvl(models.Model):
    className = models.ForeignKey(Classes, on_delete=models.CASCADE)
    lvl = models.IntegerField()
    Ability = models.TextField(default="Feat")

    def __str__(self):
        return f"{self.className} - Level {self.lvl}"

    class Meta:
        db_table = "ClassByLvl"

class CharacterByLevel(models.Model):
    character = models.ForeignKey(Character_Class, on_delete=models.CASCADE)
    className = models.ForeignKey(Classes, on_delete=models.CASCADE)
    descript = models.TextField()
    abilityName = models.CharField(max_length=50)
    lvl = models.IntegerField()
    lvl1stSpellSlot = models.IntegerField(null=True, blank=True)
    lvl2ndSpellSlot = models.IntegerField(null=True, blank=True)
    lvl3rdSpellSlot = models.IntegerField(null=True, blank=True)
    lvl4thSpellSlot = models.IntegerField(null=True, blank=True)
    lvl5thSpellSlot = models.IntegerField(null=True, blank=True)
    lvl6thSpellSlot = models.IntegerField(null=True, blank=True)
    lvl7thSpellSlot = models.IntegerField(null=True, blank=True)
    lvl8thSpellSlot = models.IntegerField(null=True, blank=True)
    lvl9thSpellSlot = models.IntegerField(null=True, blank=True)

    def __str__(self):
        return f"{self.character} - {self.className} (Level {self.lvl})"

    class Meta:
        db_table = "CharacterByLevel"

class Subclass(models.Model):
    className = models.ForeignKey(Classes, on_delete=models.CASCADE)
    subclass_name = models.CharField(max_length=30)
    descript = models.TextField()

    def __str__(self):
        return self.subclass_name

    class Meta:
        db_table = "Subclass"

class SubclassByLvl(models.Model):
    subclass = models.ForeignKey(Subclass, on_delete=models.CASCADE)
    lvl = models.IntegerField()
    descript = models.TextField()

    def __str__(self):
        return f"{self.subclass} - Level {self.lvl}"

    class Meta:
        db_table = "SubclassByLvl"

class Spell(models.Model):
    SpellName = models.CharField(max_length=30)
    spellLvl = models.IntegerField()
    descript = models.TextField()

    def __str__(self):
        return self.SpellName

    class Meta:
        db_table = "Spell"

class WhoCanCast(models.Model):
    spell = models.ForeignKey(Spell, on_delete=models.CASCADE)
    className = models.ForeignKey(Classes, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.className} can cast {self.spell}"

    class Meta:
        db_table = "whoCanCast"

class CurrentSpellsForCharacter(models.Model):
    character = models.ForeignKey(Character_Class, on_delete=models.CASCADE)
    spell = models.ForeignKey(Spell, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.character} has {self.spell}"

    class Meta:
        db_table = "CurrentSpellsForCharacter"

class Feat(models.Model):
    featName = models.CharField(max_length=50)
    descript = models.TextField()
    lvlReq = models.IntegerField()

    def __str__(self):
        return self.featName

    class Meta:
        db_table = "Feat"

class CharacterByFeat(models.Model):
    feat = models.ForeignKey(Feat, on_delete=models.CASCADE)
    character = models.ForeignKey(Character_Class, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.character} has feat {self.feat}"

    class Meta:
        db_table = "CharacterByFeat"

class Race(models.Model):
    race_name = models.CharField(max_length=20)
    descript = models.TextField()
    speed = models.IntegerField()
    size = models.CharField(max_length=15)

    def __str__(self):
        return self.race_name

    class Meta:
        db_table = "Race"

class AbilityByRace(models.Model):
    race = models.ForeignKey(Race, on_delete=models.CASCADE)
    lvlGainedAt = models.IntegerField(default=1)
    ability = models.TextField()

    def __str__(self):
        return f"{self.race} - Ability at Level {self.lvlGainedAt}"

    class Meta:
        db_table = "AbilityByRace"

class Background(models.Model):
    backgroundName = models.CharField(max_length=25)
    abilitiesImprovedOne = models.CharField(max_length=3)
    abilitiesImprovedTwo = models.CharField(max_length=3)
    abilitiesImprovedThree = models.CharField(max_length=3)
    descript = models.TextField()
    feat = models.ForeignKey(Feat, on_delete=models.CASCADE)

    def __str__(self):
        return f"Background - {self.abilitiesImprovedOne}, {self.abilitiesImprovedTwo}, {self.abilitiesImprovedThree}"

    class Meta:
        db_table = "Background"
