DROP DATABASE IF EXISTS dnd;
CREATE DATABASE dnd;
GRANT ALL PRIVILEGES ON dnd.* TO 'django'@'localhost' WITH GRANT OPTION;
USE dnd;
-- INSERTIONS
CREATE TABLE Character_Class (
    character_id INT AUTO_INCREMENT PRIMARY KEY,
    character_name VARCHAR(255),
    STR INT(2),
    DEX INT(2),
    CON INT(2),
    INTE INT(2),
    WIS INT(2),
    CHA INT(2)
);
-- _______________________________________________________________
CREATE TABLE Skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skillName VARCHAR(15)
);
CREATE TABLE WpnType (
    wpn_id INT AUTO_INCREMENT PRIMARY KEY,
    wpnTypeName VARCHAR(20)
);
CREATE TABLE Tools (
    tool_id INT AUTO_INCREMENT PRIMARY KEY,
    toolName VARCHAR(50)
);

CREATE TABLE Classes (
    className VARCHAR(10) PRIMARY KEY,
    descript TEXT,
    hitDice VARCHAR(4),
    -- Make a table for tools
    savingThrowOne VARCHAR(3),
    savingThrowTwo VARCHAR(3)
);

CREATE TABLE SkillsbyClass (
    skill_id INT,
    className VARCHAR(10),
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id),
    FOREIGN KEY (className) REFERENCES Classes(className)
);

CREATE TABLE wpnTypebyClass (
    wpn_id INT,
    className VARCHAR(10),
    FOREIGN KEY (wpn_id) REFERENCES WpnType(wpn_id),
    FOREIGN KEY (className) REFERENCES Classes(className)
);
CREATE TABLE ToolbyClass (
    tool_id INT,
    className VARCHAR(10),
    FOREIGN KEY (tool_id) REFERENCES Tools(tool_id),
    FOREIGN KEY (className) REFERENCES Classes(className)
);
-- _______________________________________________________________
CREATE TABLE ClassByLvl(
    className VARCHAR(10),
    lvl INT,
    AbilityName VARCHAR(100),
    Ability VARCHAR(2000) DEFAULT "Feat",
    FOREIGN KEY (className) REFERENCES Classes(className)
);
CREATE TABLE CharacterByLevel (
    character_id INT,
    className VARCHAR(10),
    descript VARCHAR(1000),
    abilityName VARCHAR(50),
    lvl INT,
    lvl1stSpellSlot INT,
    lvl2ndSpellSlot INT,
    lvl3rdSpellSlot INT,
    lvl4thSpellSlot INT,
    lvl5thSpellSlot INT,
    lvl6thSpellSlot INT,
    lvl7thSpellSlot INT,
    lvl8thSpellSlot INT,
    lvl9thSpellSlot INT,
    FOREIGN KEY (character_id) REFERENCES Character_Class(character_id),
    FOREIGN KEY (className) REFERENCES Classes(className)
);
-- _______________________________________________________________
Create TABLE Subclass(
    subclass_id INT PRIMARY KEY AUTO_INCREMENT,
    className VARCHAR(10),
    subclass_name VARCHAR(30),
    descript VARCHAR(1000),
    FOREIGN KEY (className) REFERENCES Classes(className)
);

CREATE TABLE SubclassByLvl(
    subclass_id Int, 
    lvl INT,
    descript VARCHAR(1000),
    FOREIGN KEY (subclass_id) REFERENCES Subclass(subclass_id)
);
-- _______________________________________________________________
Create TABLE Spell(
    spell_id INT PRIMARY KEY AUTO_INCREMENT,
    SpellName VARCHAR(30),
    spellLvl INT,
    descript VARCHAR(1000)
);
Create TABLE whoCanCast(
    spell_id INT,
    className VARCHAR(10),
    FOREIGN KEY (spell_id) REFERENCES Spell(spell_id),
    FOREIGN KEY(className) REFERENCES Classes(ClassName)
);
Create Table CurrentSpellsForCharacter(
    character_id int,
    spell_id int,
    FOREIGN KEY (character_id) REFERENCES character_class(character_id),
    FOREIGN KEY(spell_id) REFERENCES Spell(spell_id)
);
-- _________________________________________________________________
Create TABLE Feat(
    feat_id INT PRIMARY KEY AUTO_INCREMENT,
    featName VARCHAR(50),
    descript VARCHAR(2000)
);
Create TABLE CharacterByFeat(
    feat_id INT,
    character_id INT,
    FOREIGN KEY (feat_id) REFERENCES Feat(feat_id),
    FOREIGN KEY (character_id) REFERENCES character_class(character_id)
);
-- _________________________________________________________________
Create TABLE Race(
    race_id INT PRIMARY KEY AUTO_INCREMENT,
    race_name VARCHAR(10),
    descript VARCHAR(1000),
    speed INT,
    size VARCHAR(12)
);
CREATE TABLE AbilityByRace(
    race_id INT,
    lvlGainedAt INT DEFAULT 1,
    ability VARCHAR(1000),
    FOREIGN KEY(race_id) REFERENCES Race(race_id)
);

ALTER TABLE Character_Class ADD COLUMN race_id INT;
ALTER TABLE Character_Class ADD CONSTRAINT race_id FOREIGN KEY (race_id) REFERENCES Race(race_id);
-- ________________________________________________________________
CREATE TABLE Background(
    background_id INT PRIMARY KEY AUTO_INCREMENT,
    abilitiesImprovedOne VARCHAR(3),
    abilitiesImprovedTwo VARCHAR(3),
    abilitiesImprovedThree VARCHAR(3),
    descript VARCHAR(1000),
    feat_id INT,
    FOREIGN KEY (feat_id) REFERENCES Feat(feat_id)
);
INSERT INTO Classes (className, descript, hitDice, savingThrowOne, savingThrowTwo)
VALUES 
    ('Artificer', 'A master of invention, using ingenuity and magic to unlock extraordinary abilities.', 'd8', 'INT', 'CON'),
    ('Barbarian', 'A fierce warrior of primitive background who can enter a battle rage.', 'd12', 'STR', 'CON'),
    ('Bard', 'A master of song, dance, and storytelling, Bards harness the magic of art to inspire their allies and manipulate the forces of magic. Through their performances, they channel their creativity into spells, bolster the courage of adventurers, and sway the hearts of enemies.', 'd8', 'DEX', 'CHA'),
    ('Cleric', 'A priestly champion who wields divine magic in service of a higher power.', 'd8', 'WIS', 'CHA'),
    ('Druid', 'A priest of the Old Faith, wielding the powers of nature and adopting animal forms.', 'd8', 'INT', 'WIS'),
    ('Fighter', 'A master of martial combat, skilled with a variety of weapons and armor.', 'd10', 'STR', 'CON'),
    ('Monk', 'A master of martial arts, harnessing the power of the body in pursuit of physical and spiritual perfection.', 'd8', 'STR', 'DEX'),
    ('Paladin', 'A holy warrior bound to a sacred oath, using divine magic to protect the weak and uphold justice.', 'd10', 'WIS', 'CHA'),
    ('Ranger', 'A warrior who uses martial prowess and nature magic to protect the natural order', 'd10', 'DEX', 'WIS'),
    ('Rogue', 'A scoundrel who uses stealth and trickery to overcome obstacles and enemies.', 'd8', 'DEX', 'INT'),
    ('Sorcerer', 'A spellcaster who draws on inherent magic from a gift or bloodline.', 'd6', 'CON', 'CHA'),
    ('Warlock', 'A wielder of magic that is derived from a bargain with an extraplanar entity.', 'd8', 'WIS', 'CHA'),
    ('Wizard', 'A scholarly magic-user capable of manipulating the structures of reality.', 'd6', 'INT', 'WIS');

INSERT INTO Skills (skillName) 
VALUES
    ('Acrobatics'),
    ('Animal Handling'),
    ('Arcana'),
    ('Athletics'),
    ('Deception'),
    ('History'),
    ('Insight'),
    ('Intimidation'),
    ('Medicine'),
    ('Nature'),
    ('Perception'),
    ('Performance'),
    ('Persuasion'),
    ('Religion'),
    ('Sleight of Hand'),
    ('Stealth'),
    ('Survival');


-- SkillsByClass Insert Statements
INSERT INTO SkillsbyClass (skill_id, className) 
VALUES
    (1, 'Artificer'),  -- Acrobatics
    (3, 'Artificer'),  -- Arcana
    (6, 'Artificer'),  -- History
    (7, 'Artificer'),  -- Insight
    (10, 'Artificer'), -- Nature
    (11, 'Artificer'), -- Perception
    (1, 'Bard'),  -- Acrobatics
    (2, 'Bard'),  -- Animal Handling
    (3, 'Bard'),  -- Arcana
    (4, 'Bard'),  -- Athletics
    (5, 'Bard'),  -- Deception
    (6, 'Bard'),  -- History
    (7, 'Bard'),  -- Insight
    (8, 'Bard'),  -- Intimidation
    (9, 'Bard'),  -- Medicine
    (10, 'Bard'), -- Nature
    (11, 'Bard'), -- Perception
    (12, 'Bard'), -- Performance
    (13, 'Bard'), -- Persuasion
    (14, 'Bard'), -- Religion
    (15, 'Bard'), -- Sleight of Hand
    (16, 'Bard'), -- Stealth
    (17, 'Bard'), -- Survival
    (4, 'Barbarian'),  -- Athletics
    (7, 'Barbarian'),  -- Insight
    (11, 'Barbarian'), -- Perception
    (16, 'Barbarian'), -- Stealth
    (7, 'Cleric'),  -- Insight
    (9, 'Cleric'),  -- Medicine
    (14, 'Cleric'), -- Religion
    (10, 'Druid'),  -- Nature
    (11, 'Druid'),  -- Perception
    (12, 'Druid'),  -- Performance
    (14, 'Druid'),  -- Religion
    (1, 'Fighter'),  -- Acrobatics
    (4, 'Fighter'),  -- Athletics
    (7, 'Fighter'),  -- Insight
    (10, 'Fighter'), -- Nature
    (11, 'Fighter'), -- Perception
    (16, 'Fighter'), -- Stealth
    (1, 'Monk'),  -- Acrobatics
    (4, 'Monk'),  -- Athletics
    (7, 'Monk'),  -- Insight
    (11, 'Monk'), -- Perception
    (16, 'Monk'), -- Stealth
    (4, 'Paladin'),  -- Athletics
    (7, 'Paladin'),  -- Insight
    (14, 'Paladin'), -- Religion
    (10, 'Ranger'),  -- Nature
    (11, 'Ranger'),  -- Perception
    (16, 'Ranger'),  -- Stealth
    (1, 'Rogue'),  -- Acrobatics
    (6, 'Rogue'),  -- History
    (7, 'Rogue'),  -- Insight
    (10, 'Rogue'), -- Nature
    (12, 'Rogue'), -- Performance
    (13, 'Rogue'), -- Persuasion
    (15, 'Rogue'), -- Sleight of Hand
    (16, 'Rogue'), -- Stealth
    (3, 'Sorcerer'),  -- Arcana
    (6, 'Sorcerer'),  -- History
    (7, 'Sorcerer'),  -- Insight
    (14, 'Sorcerer'), -- Religion
    (3, 'Warlock'),  -- Arcana
    (7, 'Warlock'),  -- Insight
    (13, 'Warlock'), -- Persuasion
    (14, 'Warlock'), -- Religion
    (3, 'Wizard'),  -- Arcana
    (6, 'Wizard'),  -- History
    (7, 'Wizard'),  -- Insight
    (14, 'Wizard'); -- Religion

-- WPNProf Insert Statements
INSERT INTO WpnType (wpnTypeName) 
VALUES
    ('Martial'),
    ('Simple'),   
    ('Light Armor'),     
    ('Medium Armor'),    
    ('Heavy Armor'),     
    ('Shield');

-- Artificer Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(2, 'Artificer'), -- Simple Weapons
(1, 'Artificer'), -- Martial Weapons
(3, 'Artificer'), -- Light Armor
(6, 'Artificer'); -- Shield

-- Barbarian Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(1, 'Barbarian'), -- Martial Weapons
(2, 'Barbarian'), -- Simple Weapons
(3, 'Barbarian'), -- Light Armor
(4, 'Barbarian'), -- Medium Armor
(6, 'Barbarian'); -- Shield

-- Bard Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(2, 'Bard'), -- Simple Weapons
(1, 'Bard'), -- Martial Weapons
(3, 'Bard'), -- Light Armor
(6, 'Bard'); -- Shield

-- Cleric Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(2, 'Cleric'), -- Simple Weapons
(3, 'Cleric'), -- Light Armor
(4, 'Cleric'), -- Medium Armor
(6, 'Cleric'); -- Shield

-- Druid Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(2, 'Druid'), -- Simple Weapons
(3, 'Druid'), -- Light Armor
(4, 'Druid'), -- Medium Armor
(6, 'Druid'); -- Shield

-- Fighter Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(1, 'Fighter'), -- Martial Weapons
(2, 'Fighter'), -- Simple Weapons
(3, 'Fighter'), -- Light Armor
(4, 'Fighter'), -- Medium Armor
(5, 'Fighter'), -- Heavy Armor
(6, 'Fighter'); -- Shield

-- Monk Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(2, 'Monk'), -- Simple Weapons
(1, 'Monk'), -- Martial Weapons
(3, 'Monk'); -- Light Armor

-- Paladin Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(1, 'Paladin'), -- Martial Weapons
(2, 'Paladin'), -- Simple Weapons
(3, 'Paladin'), -- Light Armor
(4, 'Paladin'), -- Medium Armor
(5, 'Paladin'), -- Heavy Armor
(6, 'Paladin'); -- Shield

-- Ranger Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(1, 'Ranger'), -- Martial Weapons
(2, 'Ranger'), -- Simple Weapons
(3, 'Ranger'), -- Light Armor
(4, 'Ranger'), -- Medium Armor
(6, 'Ranger'); -- Shield

-- Rogue Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(2, 'Rogue'), -- Simple Weapons
(1, 'Rogue'), -- Martial Weapons
(3, 'Rogue'); -- Light Armor

-- Sorcerer Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(2, 'Sorcerer'), -- Simple Weapons
(3, 'Sorcerer'); -- Light Armor

-- Warlock Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(2, 'Warlock'), -- Simple Weapons
(3, 'Warlock'); -- Light Armor

-- Wizard Class Proficiencies
INSERT INTO wpnTypebyClass (wpn_id, className) VALUES
(2, 'Wizard'), -- Simple Weapons
(3, 'Warlock'); -- Light Armor
INSERT INTO Tools (toolName) 
VALUES
    ('Alchemist’s Supplies'),
    ('Brewer’s Supplies'),
    ('Calligrapher’s Supplies'),
    ('Carpenter’s Tools'),
    ('Cobbler’s Tools'),
    ('Cook’s Utensils'),
    ('Glassblower’s Tools'),
    ('Herbalism Kit'),
    ('Jeweler’s Tools'),
    ('Leatherworker’s Tools'),
    ('Mason’s Tools'),
    ('Painter’s Supplies'),
    ('Smith’s Tools'),
    ('Tinker’s Tools'),
    ('Weaver’s Tools'),
    ('Woodcarver’s Tools'),
    ('Musical Instrument');


INSERT INTO ToolbyClass (tool_id, className) 
VALUES
    -- Artificer
    (1, 'Artificer'), -- Alchemist’s Supplies
    (15, 'Artificer'), -- Tinker’s Tools
    (16, 'Artificer'), -- Woodcarver’s Tools
    -- Bard
    (1, 'Bard'), -- Alchemist’s Supplies
    (2, 'Bard'), -- Brewer’s Supplies
    (3, 'Bard'), -- Calligrapher’s Supplies
    (4, 'Bard'), -- Carpenter’s Tools
    (5, 'Bard'), -- Cobbler’s Tools
    (6, 'Bard'), -- Cook’s Utensils
    (7, 'Bard'), -- Glassblower’s Tools
    (8, 'Bard'), -- Herbalism Kit
    (9, 'Bard'), -- Jeweler’s Tools
    (10, 'Bard'), -- Leatherworker’s Tools
    (11, 'Bard'), -- Mason’s Tools
    (12, 'Bard'), -- Painter’s Supplies
    (13, 'Bard'), -- Smith’s Tools
    (14, 'Bard'), -- Tinker’s Tools
    (15, 'Bard'), -- Weaver’s Tools
    (16, 'Bard'), -- Woodcarver’s Tools
    (17, 'Bard'), -- Musical Instrument

    -- Barbarian
    (4, 'Barbarian'), -- Carpenter’s Tools
    (5, 'Barbarian'), -- Cobbler’s Tools
    (13, 'Barbarian'), -- Smith’s Tools

    -- Cleric
    (2, 'Cleric'), -- Brewer’s Supplies
    (3, 'Cleric'), -- Calligrapher’s Supplies
    (6, 'Cleric'), -- Cook’s Utensils
    (9, 'Cleric'), -- Jeweler’s Tools
    (10, 'Cleric'), -- Leatherworker’s Tools
    (17, 'Cleric'), -- Musical Instrument

    -- Druid
    (8, 'Druid'), -- Herbalism Kit
    (6, 'Druid'), -- Cook’s Utensils
    (17, 'Druid'), -- Musical Instrument

    -- Fighter
    (4, 'Fighter'), -- Carpenter’s Tools
    (5, 'Fighter'), -- Cobbler’s Tools
    (12, 'Fighter'), -- Painter’s Supplies
    (13, 'Fighter'), -- Smith’s Tools

    -- Monk
    (6, 'Monk'), -- Cook’s Utensils
    (17, 'Monk'), -- Musical Instrument

    -- Paladin
    (4, 'Paladin'), -- Carpenter’s Tools
    (5, 'Paladin'), -- Cobbler’s Tools
    (13, 'Paladin'), -- Smith’s Tools

    -- Ranger
    (8, 'Ranger'), -- Herbalism Kit
    (6, 'Ranger'), -- Cook’s Utensils

    -- Rogue
    (13, 'Rogue'), -- Smith’s Tools
    (17, 'Rogue'), -- Musical Instrument

    -- Sorcerer
    (2, 'Sorcerer'), -- Brewer’s Supplies
    (3, 'Sorcerer'), -- Calligrapher’s Supplies

    -- Warlock
    (2, 'Warlock'), -- Brewer’s Supplies
    (3, 'Warlock'); -- Calligrapher’s Supplies

INSERT INTO ClassByLvl (className, lvl, AbilityName,Ability) 
VALUES
    ("Artificer",1,"MAGICAL TINKERING","At 1st level, you've learned how to invest a spark of magic into mundane objects. To use this ability, you must have thieves' tools or artisan's tools in hand. You then touch a Tiny non-magical object as an action and give it one of the following magical properties of your choice:
    - The object sheds bright light in a 5-foot radius and dim light for an additional 5 feet.
    - Whenever tapped by a creature, the object emits a recorded message that can be heard up to 10 feet away. You utter the message when you bestow this property on the object, and the recording can be no more than 6 seconds long.
    - The object continuously emits your choice of an odor or a nonverbal sound (wind, waves, chirping, or the like). The chosen phenomenon is perceivable up to 10 feet away.
    - A static visual effect appears on one of the object's surfaces. This effect can be a picture, up to 25 words of text, lines and shapes, or a mixture of these elements, as you like.
    The chosen property lasts indefinitely. As an action, you can touch the object and end the property early. You can bestow magic on multiple objects, touching one object each time you use this feature, though a single object can only bear one property at a time. The maximum number of objects you can affect with this feature at one time is equal to your Intelligence modifier (minimum of one object). If you try to exceed your maximum, the oldest property immediately ends, and then the new property applies."),
    
    ("Artificer",1,"SPELLCASTING","Artificers channel magic through objects, creating effects that appear mundane but are powered by magic. To cast spells, they need a spellcasting focus, typically tools like thieves' or artisan's tools, and must be proficient in using them. Artificers know two cantrips at 1st level and gain more as they advance. They prepare spells based on their Intelligence modifier and level, with spells changing after a long rest. They can cast spells with ritual tags if prepared. Intelligence is their spellcasting ability."),
    
    ("Artificer",2, "INFUSE ITEM", "You've gained the ability to imbue mundane items with certain magical infusions, turning those objects into magic items. When you gain this feature, pick four Artificer Infusions to learn. You learn additional infusions of your choice when you reach certain levels in this class, as shown in the Infusions Known column of the Artificer table. Whenever you gain a level in this class, you can replace one of the artificer infusions you learned with a new one.
    Whenever you finish a long rest, you can touch a non-magical object and imbue it with one of your artificer infusions, turning it into a magic item. An infusion works on only certain kinds of objects, as specified in the infusion's description. If the item requires attunement, you can attune yourself to it the instant you infuse the item. If you decide to attune to the item later, you must do so using the normal process for attunement (see the attunement rules in the Dungeon Master's Guide).
    Your infusion remains in an item indefinitely, but when you die, the infusion vanishes after a number of days equal to your Intelligence modifier (minimum of 1 day). The infusion also vanishes if you replace your knowledge of the infusion. You can infuse more than one non-magical object at the end of a long rest; the maximum number of objects appears in the Infused Items column of the Artificer table. You must touch each of the objects, and each of your infusions can be in only one object at a time. Moreover, no object can bear more than one of your infusions at a time. If you try to exceed your maximum number of infusions, the oldest infusion ends, and then the new infusion applies. If an infusion ends on an item that contains other things, like a bag of holding, its contents harmlessly appear in and around its space."),

    ('Artificer', 3, 'ARTIFICER SUBCLASS', 'You gain an Artificer subclass. Your choice grants you features at 5th level and again at 9th and 15th level: Alchemist, Armourer, Artillerist, Battle Smith. Subclasses are detailed after this class’s description. A subclass grants you features at certain Artificer levels. For the rest of your career, you gain each of your subclass’s features that are of your Artificer level and lower.'),

    ('Artificer', 3, 'THE RIGHT TOOL FOR THE JOB', 'You''ve learned how to produce exactly the tool you need: with thieves'' tools or artisan''s tools in hand, you can magically create one set of artisan''s tools in an unoccupied space within 5 feet of you. This creation requires 1 hour of uninterrupted work, which can coincide with a short or long rest. Though the product of magic, the tools are non-magical, and they vanish when you use this feature again.'),

    ('Artificer', 4, 'ABILITY SCORE IMPROVEMENT', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),

    ('Artificer', 5, 'SUBCLASS FEATURE', 'Subclass Feature'),
    ('Artificer', 6, 'TOOL EXPERTISE', 'Your proficiency bonus is now doubled for any ability check you make that uses your proficiency with a tool.'),

    ('Artificer', 7, 'FLASH OF GENIUS', 'You''ve gained the ability to come up with solutions under pressure. When you or another creature you can see within 30 feet of you makes an ability check or a saving throw, you can use your reaction to add your Intelligence modifier to the roll. You can use this feature a number of times equal to your Intelligence modifier (minimum of once). You regain all expended uses when you finish a long rest.'),

    ('Artificer', 8, 'ABILITY SCORE IMPROVEMENT', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),

    ('Artificer', 9, 'SUBCLASS FEATURE', 'Subclass Feature'),
    ('Artificer', 10, 'MAGIC ITEM ADEPT', 'You achieve a profound understanding of how to use and make magic items, giving you the following benefits: You can attune to up to four magic items at once. If you craft a magic item with a rarity of common or uncommon, it takes you a quarter of the normal time, and it costs you half as much of the usual gold.'),

    ('Artificer', 11, 'SPELL-STORING ITEM', 'You can now store a spell in an object. Whenever you finish a long rest, you can touch one simple or martial weapon or one item that you can use as a spellcasting focus, and you store a spell in it, choosing a 1st- or 2nd-level spell from the artificer spell list that requires 1 action to cast (you needn''t have it prepared). While holding the object, a creature can take an action to produce the spell''s effect from it, using your spellcasting ability modifier. If the spell requires concentration, the creature must concentrate. The spell stays in the object until it''s been used a number of times equal to twice your Intelligence modifier (minimum of twice) or until you use this feature again to store a spell in an object.'),

    ('Artificer', 12, 'ABILITY SCORE IMPROVEMENT', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),

    ('Artificer', 14, 'MAGIC ITEM SAVANT', 'At 14th level, your skill with magic items deepens more, giving you the following benefits: You can attune to up to five magic items at once. You ignore all class, race, spell and level requirements on attuning to or using a magic item.'),

    ('Artificer', 15, 'SUBCLASS FEATURE', 'Subclass Feature'),
    ('Artificer', 16, 'ABILITY SCORE IMPROVEMENT', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),

    ('Artificer', 18, 'MAGIC ITEM MASTER', 'You can attune up to six magic items at once.'),

    ('Artificer', 19, 'ABILITY SCORE IMPROVEMENT', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),

    ('Artificer', 20, 'SOUL OF ARTIFICE', 'You develop a mystical connection to your magic items, which you can draw on for protection, giving you the following benefits: You gain a +1 bonus to all saving throws per magic item you are currently attuned to. If you''re reduced to 0 hit points but not killed outright, you can use your reaction to end one of your artificer infusions, causing you to drop to 1 hit point instead of 0.');
    -- ______________________________________________________________
    -- BARBARIAN
INSERT INTO ClassByLvl (className, lvl, AbilityName,Ability) 
VALUES
    ('Barbarian', 1, 'Rage', 'Imbue with primal power; grants damage resistance, rage damage, and other benefits. Ends early if heavy armor is worn or incapacitated.'),
    ('Barbarian', 1, 'Unarmored Defense', 'Without armor, AC equals 10 + Dexterity and Constitution modifiers.'),
    ('Barbarian', 1, 'Weapon Mastery', 'Gain the Mastery property of two chosen melee weapons; can change one after each long rest.'),
    ('Barbarian', 2, 'Danger Sense', 'Advantage on Dexterity saving throws when not incapacitated.'),
    ('Barbarian', 2, 'Reckless Attack', 'Can attack with Advantage on Strength attacks, but attacks against you also gain Advantage until your next turn.'),
    ('Barbarian', 3, 'Subclass Feature', 'Gain features from chosen Barbarian subclass.'),
    ('Barbarian', 3, 'Primal Knowledge', 'Gain skill proficiency, and make certain skill checks as Strength checks during Rage.'),
    ('Barbarian', 4, 'Ability Score Improvement', 'Choose to increase one ability score by 2, or two scores by 1. Available again at levels 8, 12, 16, and 19.'),
    ('Barbarian', 5, 'Extra Attack', 'Attack twice when you take the Attack action on your turn.'),
    ('Barbarian', 5, 'Fast Movement', 'Speed increases by 10 feet when not in Heavy Armor.'),
    ('Barbarian', 6, 'Subclass Feature', 'Gain additional feature from your chosen subclass.'),
    ('Barbarian', 7, 'Feral Instinct', 'Advantage on Initiative rolls.'),
    ('Barbarian', 7, 'Instinctive Pounce', 'Move up to half speed as part of the Bonus Action to enter Rage.'),
    ('Barbarian', 8, 'Ability Score Improvement', 'Choose to increase one ability score by 2, or two scores by 1.'),
    ('Barbarian', 9, 'Brutal Strike', 'Forgo Advantage on a Reckless Attack for additional damage and apply effects like Forceful or Hamstring Blow.'),
    ('Barbarian', 10, 'Subclass Feature', 'Gain additional feature from your chosen subclass.'),
    ('Barbarian', 11, 'Relentless Rage', 'At 0 HP, make a Constitution save to regain HP equal to twice Barbarian level instead.'),
    ('Barbarian', 12, 'Ability Score Improvement', 'Choose to increase one ability score by 2, or two scores by 1. Available again at levels 16, 19.'),
    ('Barbarian', 13, 'Improved Brutal Strike', 'Gain new Brutal Strike effects: Staggering or Sundering Blow.'),
    ('Barbarian', 14, 'Subclass Feature', 'Gain additional feature from your chosen subclass.'),
    ('Barbarian', 15, 'Persistent Rage', 'Rage lasts for 10 minutes without requiring maintenance actions.'),
    ('Barbarian', 16, 'Ability Score Improvement', 'Choose to increase one ability score by 2, or two scores by 1.'),
    ('Barbarian', 17, 'Brutal Strike Improvement', 'Brutal Strike deals 2d10 extra damage and allows applying two different effects.'),
    ('Barbarian', 18, 'Indomitable Might', 'Use Strength score if total Strength check or save is lower.'),
    ('Barbarian', 19, 'Epic Boon', 'Gain an Epic Boon feat, such as Boon of Irresistible Offense.'),
    ('Barbarian', 20, 'Primal Champion', 'Increase Strength and Constitution scores by 4; new max is 25.');
    -- ______________________________________________________________
    -- BARD
INSERT INTO ClassByLvl (className, lvl, AbilityName,Ability) 
VALUES
    ('Bard', 1, 'Bardic Inspiration', 'Use a d6 Bardic Inspiration die to inspire a creature, granting a bonus to a d20 test. The die increases in size as you level up.'),
    ('Bard', 1, 'Spellcasting', 'You learn to cast spells. You know two cantrips and prepare spells from the Bard spell list. Charisma is your Spellcasting Ability.'),
    ('Bard', 2, 'Expertise', 'Gain Expertise in two skills of your choice.'),
    ('Bard', 2, 'Jack of All Trades', 'Add half your Proficiency Bonus to ability checks for skills you lack proficiency in.'),
    ('Bard', 3, 'Bard Subclass', 'Choose a Bard subclass which grants unique abilities.'),
    ('Bard', 4, 'Ability Score Improvement', 'Increase one ability score by 2 or two scores by 1.'),
    ('Bard', 5, 'Font of Inspiration', 'Regain all Bardic Inspiration uses on a Short Rest. Expend a spell slot to regain one use of Bardic Inspiration.'),
    ('Bard', 6, 'Subclass Feature', 'Subclass feature for your chosen Bard subclass.'),
    ('Bard', 7, 'Countercharm', 'Use musical notes or words to disrupt mind-influencing effects, granting Advantage on saving throws against Charmed or Frightened.'),
    ('Bard', 8, 'Ability Score Improvement', 'Increase one ability score by 2 or two scores by 1.'),
    ('Bard', 9, 'Subclass Feature', 'Subclass feature for your chosen Bard subclass.'),
    ('Bard', 10, 'Magical Secrets', 'Learn spells from Bard, Cleric, Druid, and Wizard spell lists, and treat them as Bard spells.'),
    ('Bard', 11, '-', '-'),
    ('Bard', 12, 'Ability Score Improvement', 'Increase one ability score by 2 or two scores by 1.'),
    ('Bard', 13, '-', '-'),
    ('Bard', 14, 'Subclass Feature', 'Subclass feature for your chosen Bard subclass.'),
    ('Bard', 15, '-', '-'),
    ('Bard', 16, 'Ability Score Improvement', 'Increase one ability score by 2 or two scores by 1.'),
    ('Bard', 17, '-', '-'),
    ('Bard', 18, 'Superior Inspiration', 'Regain expended uses of Bardic Inspiration when you roll Initiative, up to two uses.'),
    ('Bard', 19, 'Epic Boon', 'Gain an Epic Boon feat, such as Boon of Spell Recall.'),
    ('Bard', 20, 'Words of Creation', 'Always have Power Word Heal and Power Word Kill prepared. You can target an additional creature with each spell.');
-- CLERIC
INSERT INTO ClassByLvl (className, lvl, abilityName, ability) 
VALUES
    ('Cleric', 1, 'Divine Order', 'You have dedicated yourself to one of the following sacred roles of your choice: Protector. Trained for battle, you gain proficiency with Martial Weapons and training with Heavy Armor. Thaumaturge. You know one extra cantrip from the Cleric spell list. In addition, your mystical connection to the divine gives you a bonus to your Intelligence (Arcana or Religion) checks. The bonus equals your Wisdom modifier (minimum of +1).'),
    ('Cleric', 1, 'Spellcasting', 'You have learned to cast spells through prayer and meditation. You know three cantrips of your choice from the Cleric spell list. Whenever you gain a Cleric level, you can replace one of your cantrips with another cantrip of your choice from the Cleric spell list. When you reach Cleric levels 4 and 10, you learn another cantrip of your choice from the Cleric spell list.'),
    ('Cleric', 2, 'Channel Divinity', 'You can channel divine energy directly from the Outer Planes to fuel magical effects. You start with two such effects: Divine Spark and Turn Undead. You can use this class’s Channel Divinity twice. You regain one of its expended uses when you finish a Short Rest, and you regain all expended uses when you finish a Long Rest.'),
    ('Cleric', 3, 'Cleric Subclass', 'You gain a Cleric subclass of your choice: Life Domain, Light Domain, Trickery Domain, War Domain, Forge Domain, Order Domain, Peace Domain, Twilight Domain.'),
    ('Cleric', 4, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Cleric', 5, 'Sear Undead', 'Whenever you use Turn Undead, you can roll a number of d8s equal to your Wisdom modifier (minimum of 1d8) and add the rolls together. Each Undead that fails its saving throw against that use of Turn Undead takes Radiant damage equal to the roll’s total. This damage doesn’t end the turn effect.'),
    ('Cleric', 6, 'Subclass Feature', 'You gain an additional feature from your chosen Cleric subclass.'),
    ('Cleric', 7, 'Blessed Strikes', 'Divine power infuses you in battle. You gain one of the following options of your choice: Divine Strike. Once on each of your turns when you hit a creature with an attack roll using a weapon, you can cause the target to take an extra 1d8 Necrotic or Radiant damage (your choice). Potent Spellcasting. You add your Wisdom modifier to the damage you deal with any Cleric cantrip.'),
    ('Cleric', 8, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Cleric', 9, '-', '-'),
    ('Cleric', 10, 'Divine Intervention', 'You can call on your deity or pantheon to intervene on your behalf. As a Magic Action, choose any Cleric spell of 5th level or lower that doesn’t require a Reaction to cast. As part of the same action, you cast that spell without expending a spell slot or needing Material components. You then can’t use this feature again until you finish a Long Rest.'),
    ('Cleric', 11, '-', '-'),
    ('Cleric', 12, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Cleric', 13, '-', '-'),
    ('Cleric', 14, 'Improved Blessed Strikes', 'The option you chose for Blessed Strikes grows more powerful: Divine Strike. The extra damage of your Divine Strike increases to 2d8. Potent Spellcasting. When you cast a Cleric cantrip and deal damage to a creature with it, you can give vitality to yourself or another creature within 60 feet of yourself, granting a number of Temporary Hit Points equal to twice your Wisdom modifier.'),
    ('Cleric', 15, '-', '-'),
    ('Cleric', 16, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Cleric', 17, 'Subclass Feature', 'You gain an additional feature from your chosen Cleric subclass.'),
    ('Cleric', 18, '-', '-'),
    ('Cleric', 19, 'Epic Boon', 'You gain an Epic Boon feat or another feat of your choice for which you qualify.'),
    ('Cleric', 20, 'Greater Divine Intervention', 'You can call on even more powerful divine intervention. When you use your Divine Intervention feature, you can choose Wish when you select a spell. If you do so, you can’t use Divine Intervention again until you finish 2d4 Long Rests.');
-- DRUID
INSERT INTO ClassByLvl (className, lvl, abilityName, ability) 
VALUES

    ('Druid', 1, 'Druidic', 'You know Druidic, the secret language of Druids. While learning this ancient tongue, you also unlocked the magic of communicating to animals; you always have the Speak with Animals spell prepared. You can use Druidic to leave hidden messages. You and others who know Druidic automatically spot such a message. Others spot the message’s presence with a successful DC 15 Intelligence (Investigation) check but can’t decipher it without magic.'),
    ('Druid', 1, 'Primal Order', 'You have dedicated yourself to one of the following sacred roles of your choice: Magician. You know one extra cantrip from the Druid spell list. In addition, your mystical connection to nature gives you a bonus to your Intelligence (Arcana or Nature) checks. The bonus equals your Wisdom modifier (minimum bonus of +1). Warden. Trained for battle, you gain proficiency with Martial weapons and training with Medium Armor.'),
    ('Druid', 1, 'Spellcasting', 'As a Druid, you learn to cast spells using natures mystical forces. You start with two cantrips and can replace one with another at each level. At levels 4 and 10, you gain an additional cantrip. You prepare spells from the Druid list, increasing your options as you level up. You regain spell slots after a Long Rest and can change your prepared spells after resting. Wisdom is your spellcasting ability, and you can use a Druidic Focus to cast your spells.'),
    ('Druid', 2, 'Wild Companion', 'You can summon a nature spirit that assumes an animal form to aid you. As a Magic action, you can expend a spell slot or a use of Wild Shape to cast the Find Familiar spell without Material components. When you cast the spell in this way, the familiar is a Fey and disappears when you finish a Long Rest.'),
    ('Druid', 2, 'Wild Shape', 'The power of nature allows you to assume the form of an animal. As a Bonus Action, you shape-shift into a Beast form that you have learned for this feature (see “Known Forms” below). You stay in that form for a number of hours equal to half your Druid level or until you use Wild Shape again, have the Incapacitated condition, or die. You can also leave the form early as a Bonus Action. Number of Uses. You can use Wild Shape twice. You regain one expended use when you finish a Short Rest, and you regain all expended uses when you finish a Long Rest. You gain additional uses when you reach certain Druid levels, as shown in the Wild Shape column of the Druid table. Known Forms. You know four Beast forms for this feature, chosen from among Beast stat blocks that have a maximum Challenge Rating of 1/4 and that lack a Fly Speed. Rat, Riding Horse, Spider, and Wolf are recommended. Whenever you finish a Long Rest, you can replace one of your known forms with another eligible form. When you gain certain Druid levels, the number of known forms and the maximum Challenge Rating for those forms increases, as shown in the Beast Shapes table. In addition, starting at level 8, you can adopt a form that has a Fly Speed. When choosing a new form, you may look in the Monster Manual or elsewhere for eligible Beasts if the DM permits you to do so.'),
    ('Druid', 3, 'Druid Subclass', 'You gain a Druid subclass of your choice: Circle of the Land, Circle of the Moon, Circle of the Sea, Circle of Stars, Circle of Dreams (Non-Playtest), Circle of the Shepard (Non-Playtest), Circle of Spores (Non-Playtest), Circle of Wildfire (Non-Playtest).'),
    ('Druid', 4, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Druid', 5, 'Wild Resurgence', 'Once on each of your turns, if you have no uses of Wild Shape left, you can give yourself one use by expending a spell slot (no action required). In addition, you can expend one use of Wild Shape (no action required) to give yourself a 1st-level spell slot, and you can’t do so again until you finish a Long Rest.'),
    ('Druid', 6, 'Subclass Feature', '-'),
    ('Druid', 7, 'Elemental Fury', 'The might of the elements flows through you. You gain one of the following options of your choice: Potent Spellcasting. Add your Wisdom modifier to the damage you deal with any Druid cantrip. Primal Strike. Once on each of your turns when you hit a creature with an attack roll using a weapon or a Beast form’s attack in Wild Shape, you can cause the target to take an extra 1d8 Cold, Fire, Lightning, or Thunder damage (choose when you hit).'),
    ('Druid', 8, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Druid', 9, 'Commune with Nature', 'You are an expression of nature itself and can commune with the natural world all around you; you always have the Commune with Nature spell prepared.'),
    ('Druid', 10, 'Subclass Feature', '-'),
    ('Druid', 11, '-', '-'),
    ('Druid', 12, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Druid', 13, '-', '-'),
    ('Druid', 14, 'Subclass Feature', '-'),
    ('Druid', 15, 'Improved Elemental Fury', 'The option you chose for Elemental Fury grows more powerful: Potent Spellcasting. When you cast a Druid cantrip with a range of 10 feet or greater, the spell’s range increases by 300 feet. Primal Strike. The extra damage of your Primal Strike increases to 2d8.'),
    ('Druid', 16, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Druid', 17, '-', '-'),
    ('Druid', 18, 'Beast Spells', 'While using Wild Shape, you can cast spells in Beast form, except for any spell that has a Material component with a cost specified or that consumes its Material component.'),
    ('Druid', 19, 'Epic Boon', 'You gain an Epic Boon feat or another feat of your choice for which you qualify. Boon of Dimensional Travel is recommended.'),
    ('Druid', 20, 'Archdruid', 'The vitality of nature constantly blooms within you, granting you the following benefits: Evergreen Wild Shape. Whenever you roll Initiative and have no uses of Wild Shape left, you regain one expended use of it. Nature Magician. You can convert uses of Wild Shape into a spell slot (no action required). Choose a number of your unexpended uses of Wild Shape and convert them into a single spell slot, with each use contributing 2 spell levels. For example, if you convert two uses of Wild Shape, you produce a 4th-level spell slot. Once you use this benefit, you cant do so again until you finish a Long Rest.');
-- Fighter
INSERT INTO ClassByLvl (className, lvl, abilityName, ability) 
VALUES
    ('Fighter', 1, 'Fighting Style', 'You have honed your martial prowess and gain a Fighting Style feat of your choice. Whenever you gain a Fighter level, you can replace the feat you chose with a different Fighting Style feat.'),
    ('Fighter', 1, 'Second Wind', 'You have a limited well of physical and mental stamina that you can draw on. As a Bonus Action, you can use it to regain Hit Points equal to 1d10 + your Fighter level. You can use this feature twice. You regain one expended use when you finish a Short Rest, and you regain all expended uses when you finish a Long Rest.'),
    ('Fighter', 1, 'Weapon Mastery', 'Your training with weapons allows you to use the Mastery property of three kinds of Simple or Martial weapons of your choice. Whenever you finish a Long Rest, you can practice weapon drills and change one of those weapon choices.'),
    ('Fighter', 2, 'Action Surge', 'You can push yourself beyond your normal limits for a moment. On your turn, you can take one additional action, except the Magic action. Once you use this feature, you can’t do so again until you finish a Short Rest or Long Rest.'),
    ('Fighter', 2, 'Tactical Mind', 'You have a mind for tactics on and off the battlefield. When you fail an ability check, you can expend a use of your Second Wind to push yourself toward success.'),
    ('Fighter', 3, 'Fighter Subclass', 'You gain a Fighter subclass of your choice. A subclass is a specialization that grants you special features at certain Fighter levels.'),
    ('Fighter', 4, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Fighter', 6, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Fighter', 8, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Fighter', 12, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Fighter', 14, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Fighter', 16, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Fighter', 5, 'Extra Attack', 'You can attack twice instead of once, whenever you take the Attack action on your turn.'),
    ('Fighter', 5, 'Tactical Shift', 'Whenever you activate your Second Wind with a Bonus Action, you can move up to half your Speed without provoking Opportunity Attacks.'),
    ('Fighter', 9, 'Indomitable', 'If you fail a saving throw, you can reroll it with a bonus equal to your Fighter level. You must use the new roll.'),
    ('Fighter', 9, 'Tactical Master', 'When you attack with a weapon whose Mastery property you can use, you can replace that property with the Push, Sap, or Slow property for that attack.'),
    ('Fighter', 11, 'Two Extra Attacks', 'You can attack three times instead of once, whenever you take the Attack action on your turn.'),
    ('Fighter', 13, 'Studied Attacks', 'If you make an attack roll against a creature and miss, you have Advantage on your next attack roll against that creature before the end of your next turn.'),
    ('Fighter', 19, 'Epic Boon', 'You gain an Epic Boon feat or another feat of your choice for which you qualify.'),
    ('Fighter', 20, 'Three Extra Attacks', 'You can attack four times instead of once, whenever you take the Attack action on your turn.'),
    ('Fighter', 7, 'Subclass Feature', 'Your subclass grants you a special feature.'),
    ('Fighter', 10, 'Subclass Feature', 'Your subclass grants you a special feature.'),
    ('Fighter', 15, 'Subclass Feature', 'Your subclass grants you a special feature.'),
    ('Fighter', 18, 'Subclass Feature', 'Your subclass grants you a special feature.');
-- Monk
INSERT INTO ClassByLvl (className, lvl, abilityName, ability) 
VALUES
    ('Monk', 1, 'Martial Arts', 'Your practice of martial arts gives you mastery of combat styles that use your Unarmed Strike and Monk Weapons, which are Simple Melee weapons, Martial Melee weapons with the Light property.'),
    ('Monk', 1, 'Unarmored Defense', 'While you aren’t wearing any armor or wielding a Shield, your base Armor Class equals 10 + your Dexterity modifier + your Wisdom modifier.'),
    ('Monk', 2, 'Monk Discipline', 'Your focus and martial training allow you to harness a well of extraordinary energy within yourself. This energy is represented by Focus Points.'),
    ('Monk', 2, 'Unarmored Movement', 'Your speed increases by 10 feet while you aren’t wearing armor or wielding a Shield.'),
    ('Monk', 2, 'Uncanny Metabolism', 'When you roll Initiative, you can regain all expended Focus Points. When you do so, roll your Martial Arts die, and regain a number of Hit Points equal to your Monk level + the number rolled.'),
    ('Monk', 3, 'Deflect Attacks', 'When an attack roll hits you and its damage includes Bludgeoning, Piercing, or Slashing damage, you can take a Reaction to reduce the attack\'s total damage against you.'),
    ('Monk', 3, 'Monk Subclass', 'You gain a Monk subclass of your choice. Subclasses are detailed after this class’s description.'),
    ('Monk', 4, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Monk', 8, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Monk', 12, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Monk', 16, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Monk', 4, 'Slow Fall', 'You can use your Reaction when you fall to reduce any damage you take from the fall by an amount equal to five times your Monk level.'),
    ('Monk', 5, 'Extra Attack', 'You can attack twice, instead of once, whenever you take the Attack action on your turn.'),
    ('Monk', 5, 'Stunning Strike', 'Once per turn when you hit a creature with a Monk Weapon or an Unarmed Strike, you can spend 1 Focus Point to attempt a stunning strike.'),
    ('Monk', 6, 'Monk Subclass Feature', 'Subclass feature at level 6.'),
    ('Monk', 6, 'Empowered Strikes', 'Whenever you deal damage with your Unarmed Strike, it deals your choice of Force damage or its normal damage type.'),
    ('Monk', 7, 'Evasion', 'When you are subjected to an effect that allows you to make a Dexterity saving throw to take only half damage, you instead take no damage if you succeed on the saving throw, and only half damage if you fail.'),
    ('Monk', 9, 'Acrobatic Movement', 'While you aren’t wearing armor or wielding a Shield, you gain the ability to move along vertical surfaces and across liquids on your turn without falling during the movement.'),
    ('Monk', 10, 'Heightened Focus', 'Your training has pushed your body and mind to new levels. Your Flurry of Blows, Patient Defense, and Step of the Wind gain the following benefits: Flurry of Blows.'),
    ('Monk', 10, 'Self-Restoration', 'Through sheer force of will, you can remove one of the following conditions from yourself at the end of each of your turns: Charmed, Frightened, or Poisoned.'),
    ('Monk', 13, 'Deflect Energy', 'You can now use your Deflect Attacks feature against attacks that deal any damage type, not just Bludgeoning, Piercing, or Slashing.'),
    ('Monk', 14, 'Disciplined Survivor', 'Your physical and mental discipline grant you proficiency in all saving throws. Additionally, whenever you make a saving throw and fail, you can spend 1 Focus Point to reroll it, you must use the new roll.'),
    ('Monk', 15, 'Perfect Focus', 'When you roll Initiative and don\'t use Uncanny Metabolism, you regain expended Focus Points until you have 4 if you have 3 or fewer.'),
    ('Monk', 17, 'Monk Subclass Feature', 'Subclass feature at level 17.'),
    ('Monk', 18, 'Superior Defense', 'At the start of your turn, you can spend 3 Focus Points to bolster yourself against harm for 1 minute or until you have the Incapacitated condition.'),
    ('Monk', 19, 'Epic Boon', 'You gain an Epic Boon feat or another feat of your choice for which you qualify. Boon of Irresistible Offense is recommended.'),
    ('Monk', 20, 'Body and Mind', 'You have developed your body and mind to new heights. Your Dexterity and Wisdom scores increase by 4, to a maximum of 25.');
-- Palidin:
INSERT INTO ClassByLvl (ClassName, lvl, AbilityName, Ability)
VALUES
('Paladin', 1, 'Lay on Hands', 'Your blessed touch can heal wounds. You have a pool of healing power that replenishes when you finish a Long Rest.'),
('Paladin', 1, 'Spellcasting', 'You have learned to cast spells through prayer, meditation, and devotion.'),
('Paladin', 1, 'Weapon Mastery', 'Your training with weapons allows you to use the Mastery property of two weapons of your choice.'),
('Paladin', 2, 'Fighting Style', 'You gain one Fighting Style feat of your choice or Blessed Warrior to learn Cleric cantrips.'),
('Paladin', 2, 'Paladin’s Smite', 'You always have the Divine Smite spell prepared and can cast it once without expending a spell slot.'),
('Paladin', 3, 'Channel Divinity', 'You can channel divine energy from the Outer Planes to fuel magical effects, starting with Divine Sense.'),
('Paladin', 3, 'Paladin Subclass', 'You gain a Paladin subclass of your choice (Devotion, Glory, etc.) and subclass features at this level.'),
('Paladin', 4, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
('Paladin', 5, 'Extra Attack', 'You can attack twice, instead of once, whenever you take the Attack action on your turn.'),
('Paladin', 5, 'Faithful Steed', 'You can call on an otherworldly steed with the Find Steed spell, which you can cast once per Long Rest without expending a spell slot.'),
('Paladin', 6, 'Aura of Protection', 'You radiate an aura in a 10-foot radius, granting a bonus to saving throws equal to your Charisma modifier.'),
('Paladin', 7, 'Paladin Subclass Feature', 'Subclass feature at level 7.'),
('Paladin', 9, 'Abjure Foes', 'You can use your Channel Divinity to target creatures within 60 feet and cause them to become Frightened.'),
('Paladin', 10, 'Aura of Courage', 'You and your allies are immune to the Frightened condition while in your Aura of Protection.'),
('Paladin', 11, 'Radiant Strikes', 'Your strikes deal extra 1d8 Radiant damage on a hit.'),
('Paladin', 12, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
('Paladin', 14, 'Restoring Touch', 'When using Lay on Hands, you can remove certain conditions like Blinded,Charmed, Deafened, Stunned, Frightened or Paralyzed for 5 Hit Points each.'),
('Paladin', 15, 'Paladin Subclass Feature', 'Subclass feature at level 15.'),
('Paladin', 16, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
('Paladin', 18, 'Aura Expansion', 'Your Aura of Protection now extends to a 30-foot radius.'),
('Paladin', 19, 'Epic Boon', 'You gain an Epic Boon feat or another feat of your choice.'),
('Paladin', 20, 'Paladin Subclass Feature', 'Subclass feature at level 20.');

-- Ranger 
INSERT INTO ClassByLvl (ClassName, lvl, AbilityName, Ability)
VALUES
    ('Ranger', 1, 'Spellcasting', 'You have learned to channel the magical essence of nature to cast spells. See the Player’s Handbook for the rules on spellcasting. The information below details how you use those rules with Ranger spells. Spell Slots. The Ranger table shows how many spell slots you have to cast your level 1+ spells. You regain all expended spell slots when you finish a Long Rest. Prepared Spells of Level 1+. You prepare the list of level 1+ spells that are available for you to cast with this feature. To start, choose two level 1 spells from the Ranger spell list. Cure Wounds and Ensnaring Strike are recommended. The number of spells on your list increases as you gain Ranger levels, as shown in the Prepared Spells column of the Ranger table. Whenever that number increases, choose additional spells from the Ranger spell list until the number of spells on your list matches the number on the table. The chosen spells must be of a level for which you have spell slots. For example, if you’re a level 5 Ranger, your list of prepared spells can include six Ranger spells of 1st or 2nd level, in any combination. If another Ranger feature gives spells that you always have prepared, those spells don’t count against the number of spells on the list you prepare with this feature, but those spells otherwise count as Ranger spells for you. Changing Your Prepared Spells. Whenever you finish a Long Rest, you can replace one spell on your list with another Ranger spell for which you have spell slots. Spellcasting Ability. Wisdom is your Spellcasting Ability for your Ranger spells. Spellcasting Focus. You can use a Druidic Focus as a Spellcasting Focus for the spells you prepare for this class.'),

    ('Ranger', 1, 'Deft Explorer', 'Thanks to your travels, you gain the following benefits: Expertise. Choose one of your proficiencies with which you lack Expertise. You gain Expertise in that skill. Languages. You know two languages of your choice from the language tables.'),

    ('Ranger', 1, 'Weapon Mastery', 'Your training with weapons allows you to use the Mastery property of two kinds of weapons of your choice with which you have proficiency, such as Longbows and Longswords. Whenever you finish a Long Rest, you can change the kinds of weapons you chose. For example, you could switch to using the Mastery properties of Scimitars and Shortswords.'),

    ('Ranger', 1, 'Favored Enemy', 'You always have the Hunter’s Mark spell prepared. You can cast it a number of times equal to your Proficiency Bonus without expending a spell slot, and you regain all expended uses of this ability when you finish a Long Rest.'),

    ('Ranger', 2, 'Fighting Style', 'You gain a Fighting Style feat of your choice. Instead of choosing one of those feats, you can choose the option below: Druidic Warrior. You learn two Druid cantrips of your choice. Guidance and Starry Wisp are recommended. The chosen cantrips count as Ranger spells for you, and Wisdom is your spellcasting ability for them. Whenever you gain a Ranger level, you can replace one of these cantrips with another Druid cantrip.'),

    ('Ranger', 3, 'Ranger Subclass', 'You gain a Ranger subclass of your choice: Beast Master, Fey Wanderer, Gloom Stalker, Hunter, Horizon Walker (Non-Playtest), Monster Slayer (Non-Playtest), Swarmkeeper (Non-Playtest), Drakewarden (Non-Playtest). Subclasses are detailed after this class’s description. A subclass is a specialization that grants you special abilities at certain Ranger levels. For the rest of your career, you gain each of your subclass’s features that are of your Ranger level and lower. There are non-playtest subclasses that can be used, please check with your DM before using one.'),

    ('Ranger', 4, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify. As shown on the Ranger table, you gain this feature again at levels 8, 12, 16.'),
    ('Ranger', 8, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify. As shown on the Ranger table, you gain this feature again at levels 8, 12, 16.'),
    ('Ranger', 12, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify. As shown on the Ranger table, you gain this feature again at levels 8, 12, 16.'),
    ('Ranger', 16, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify. As shown on the Ranger table, you gain this feature again at levels 8, 12, 16.'),
    ('Ranger', 5, 'Extra Attack', 'You can attack twice, instead of once, whenever you take the Attack action on your turn.'),

    ('Ranger', 6, 'Roving', 'Your Speed increases by 10 feet while you aren’t wearing Heavy Armor. You also have a Climb Speed and a Swim Speed equal to your Speed.'),

    ('Ranger', 9, 'Expertise', 'Choose two of your skill proficiencies with which you lack Expertise. You gain Expertise in those skills.'),

    ('Ranger', 10, 'Tireless', 'Primal forces now help fuel you on your journeys, granting you the following benefits: Temporary Hit Points. As a Magic action, you can give yourself a number of Temporary Hit Points equal to 1d8 + your Wisdom modifier (minimum of 1). You can use this action a number of times equal to your Wisdom modifier (minimum of once), and you regain all expended uses when you finish a Long Rest. Decrease Exhaustion. Whenever you finish a Short Rest, your Exhaustion level, if any, decreases by 1.'),

    ('Ranger', 13, 'Relentless Hunter', 'Taking damage can\'t break your Concentration on Hunter\'s Mark.'),

    ('Ranger', 14, 'Nature’s Veil', 'You invoke spirits of nature to magically hide yourself. As a Bonus Action, you can give yourself the Invisible condition until the end of your next turn. You can use this feature a number of times equal to your Wisdom modifier (minimum of once), and you regain all expended uses when you finish a Long Rest.'),

    ('Ranger', 17, 'Precise Hunter', 'You have Advantage on attack rolls against the creature currently marked by your Hunter\'s Mark.'),

    ('Ranger', 18, 'Feral Senses', 'Your connection to the forces of nature grants you Blindsight with a range of 30 feet.'),

    ('Ranger', 19, 'Epic Boon', 'You gain an Epic Boon feat or another feat of your choice for which you qualify. Boon of Dimensional Travel is recommended.'),

    ('Ranger', 20, 'Foe Slayer', 'The damage die of your Hunter\'s Mark is a d10 rather than a d6.'),
    ('Ranger', 7, 'Subclass Feature', 'At 7th level, your subclass grants a new feature specific to your chosen subclass.'),

    ('Ranger', 11, 'Subclass Feature', 'At 11th level, your subclass grants a new feature specific to your chosen subclass.'),

    ('Ranger', 15, 'Subclass Feature', 'At 15th level, your subclass grants a new feature specific to your chosen subclass.');
-- Rogue
INSERT INTO ClassByLvl (ClassName, lvl, AbilityName, Ability)
VALUES
    ('Rogue', 1, 'Expertise', 'You gain Expertise in two of your skill proficiencies of your choice.'),
    ('Rogue', 1, 'Sneak Attack', 'Once per turn, you can deal an extra 1d6 damage to one creature you hit with an attack roll if you have Advantage on the roll and the attack uses a Finesse or Ranged weapon. The extra damage increases as you gain Rogue levels.'),
    ('Rogue', 1, 'Thieves Cant', 'You know Thieves Cant and one other language of your choice from the language tables.'),
    ('Rogue', 1, 'Weapon Mastery', 'You can use the Mastery property of two kinds of weapons of your choice with which you have proficiency.'),
    ('Rogue', 2, 'Cunning Action', 'On your turn, you can take one of the following actions as a Bonus Action: Dash, Disengage or Hide.'),
    ('Rogue', 3, 'Rogue Subclass', 'At 3rd level, you gain a Rogue subclass of your choice (e.g., Arcane Trickster, Assassin). Subclasses grant unique features that enhance your Rogue abilities.'),
    ('Rogue', 3, 'Steady Aim', 'As a Bonus Action, you give yourself Advantage on your next attack roll on the current turn. You can use this feature only if you haven’t moved during this turn, and after you use it, your Speed is 0 until the end of the current turn.'),
    ('Rogue', 4, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Rogue', 5, 'Cunning Strike', 'You can add Cunning Strike effects to your Sneak Attack, including Poison, Trip, or Withdraw, with associated die costs.'),
    ('Rogue', 5, 'Uncanny Dodge', 'You can use your Reaction to halve the damage from an attack that you can see.'),
    ('Rogue', 6, 'Expertise', 'You gain Expertise in two of your skill proficiencies of your choice.'),
    ('Rogue', 7, 'Evasion', 'When subjected to an effect that allows a Dexterity saving throw for half damage, you take no damage if you succeed and half damage if you fail.'),
    ('Rogue', 7, 'Reliable Talent', 'You can treat any d20 roll of 9 or lower as a 10 when making ability checks with skill or tool proficiencies.'),
    ('Rogue', 8, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Rogue', 9, 'Improved Cunning Strike', 'You can use up to two Cunning Strike effects when you deal Sneak Attack damage, each with their own die cost.'),
    ('Rogue', 10, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Rogue', 11, 'Improved Cunning Strike', 'You can add Cunning Strike effects to your Sneak Attack, including Poison, Trip, or Withdraw, with associated die costs.'),
    ('Rogue', 12, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Rogue', 13, 'Subclass Feature', 'At 13th level, your subclass grants an additional feature, enhancing your skills and abilities.'),
    ('Rogue', 13, 'Slippery Mind', 'You gain proficiency in Wisdom and Charisma saving throws.'),
    ('Rogue', 14, 'Devious Strikes', 'New Cunning Strike effects like Daze, Knock Out, and Obscure become available, each with higher die costs and saving throws.'),
    ('Rogue', 15, 'Slippery Mind', 'Your cunning mind is exceptionally difficult to control. You gain proficiency in Wisdom and Charisma saving throws.'),
    ('Rogue', 16, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Rogue', 17, 'Subclass Feature', 'At 17th level, your subclass grants an additional feature, significantly enhancing your Rogue capabilities.'),
    ('Rogue', 17, 'Elusive', 'No attack roll can have Advantage against you unless you have the Incapacitated condition.'),
    ('Rogue', 18, 'Elusive', 'No attack roll can have Advantage against you unless you have the Incapacitated condition.'),
    ('Rogue', 19, 'Epic Boon', 'You gain an Epic Boon feat or another feat of your choice for which you qualify. Boon of Combat Prowess is recommended.'),
    ('Rogue', 20, 'Stroke of Luck', 'You can turn a failed D20 roll into a 20 once per Short or Long Rest.');
    -- Sorcerer
INSERT INTO ClassByLvl (ClassName, lvl, AbilityName, Ability)
VALUES
    ('Sorcerer', 1, 'Expertise', 'An event in your past left an indelible mark on you, infusing you with a simmering magic. As a Bonus Action, you can unleash that magic for 1 minute, during which you gain the following benefits:
    The spell save DC of your Sorcerer spells increases by 1.
    You have Advantage on the attack rolls of Sorcerer spells you cast.
    You can use this feature twice, and you regain all expended uses of it when you finish a Long Rest.'),
    ('Sorcerer', 1, 'SPELLCASTING', 'As a Sorcerer, you can cast spells using Charisma as your spellcasting ability. You start with four cantrips and two 1st-level spells, which you can change when you level up. You gain additional cantrips at levels 4 and 10. You prepare spells from your available spell slots, and the number of spells you can prepare increases as you level. You can also change one spell each time you gain a Sorcerer level. You can use an Arcane Focus as your spellcasting focus.'),
    ('Sorcerer', 2, 'FONT OF MAGIC', 'You can tap into the wellspring of magic within yourself. This wellspring is represented by Sorcery Points, which allow you to create a variety of magical effects. You have 2 Sorcery Points, and you gain more as you reach higher levels, as shown in the Sorcery Points column of the Sorcerer table. You can never have more Sorcery Points than the number shown on the table for your level. You regain all spent Sorcery Points when you finish a Long Rest. You can use your Sorcery Points to fuel the options below, along with other features, such as Metamagic, that use those points.
    Converting Spell Slots to Sorcery Points. You can expend a spell slot to gain a number of Sorcery Points equal to the slots level (no action required).
    Creating Spell Slots. As a Bonus Action, you can transform unexpended Sorcery Points into one spell slot. The Creating Spell Slots table shows the cost of creating a spell slot of a given level, and it lists the minimum Sorcerer level you must be to create a slot. You can create a spell slot no higher in level than 5. Any spell slot you create with this feature vanishes when you finish a Long Rest.'),
    ('Sorcerer', 2, 'METAMAGIC', 'You gain two Metamagic options of your choice from the Metamagic Options. You use the chosen options to temporarily modify spells you cast. To use an option, you must spend the number of Sorcery Points that it costs. You can use only one Metamagic option on a spell when you cast it, unless otherwise noted in one of those options. Whenever you gain a Sorcerer level, you can replace one of your Metamagic options with one you don’t know. You gain two more options at Sorcerer level 10 and two more at Sorcerer level 17.'),
    ('Sorcerer', 3, '', 'You gain a Sorcerer subclass of your choice:
    Aberrant Sorcery
    Clockwork Sorcery
    Draconic Sorcery
    Wild Magic Sorcery
    A subclass is a specialization that grants you special features at certain Sorcerer levels. For the rest of your career, you gain each of your subclass features that are of your Sorcerer level and lower.'),
    ('Sorcerer', 4, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Sorcerer', 8, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Sorcerer', 12, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Sorcerer', 16, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Sorcerer', 5, 'Sorcerous Restoration', 'When you finish a Short Rest, you can regain expended Sorcery Points, but no more than a number equal to half your Sorcerer level (round down). Once you use this feature, you can\'t do so again until you finish a Long Rest.'),
    ('Sorcerer', 7, 'Sorcery Incarnate', 'If you have no uses of Innate Sorcery left, you can use it if you spend 2 Sorcery Points when you take the Bonus Action to activate it. In addition, while your Innate Sorcery feature is active, you can use up to two of your Metamagic Options on each spell you cast.'),
    ('Sorcerer', 19, 'Epic Boon', 'You gain an Epic Boon feat or another feat of your choice for which you qualify. Boon of Fate is recommended.'),
    ('Sorcerer', 20, 'Arcane Apotheosis', 'While your Innate Sorcery feature is active, you can use one Metamagic Option on each of your turns without expending Sorcery Points on it.'),
    ('Sorcerer', 6, 'Subclass Feature', 'Description of your subclass feature at level 6.'),
    ('Sorcerer', 14, 'Subclass Feature', 'Description of your subclass feature at level 14.'),
    ('Sorcerer', 18, 'Subclass Feature', 'Description of your subclass feature at level 18.'),
    ('Sorcerer', 10, 'Metamagic', 'You gain two additional Metamagic options of your choice. You can replace one of your existing Metamagic options with another choice whenever you gain a Sorcerer level.'),
    ('Sorcerer', 17, 'Metamagic', 'You gain two additional Metamagic options of your choice. You can replace one of your existing Metamagic options with another choice whenever you gain a Sorcerer level.'),
    ('Sorcerer', 9, '-', '-'),
    ('Sorcerer', 11, '-', '-'),
    ('Sorcerer', 13, '-', '-'),
    ('Sorcerer', 15, '-', '-'),
    -- Warlock
    ('Warlock', 1, 'ELDRITCH INVOCATIONS', 'You have unearthed Eldritch Invocations, pieces of forbidden knowledge that imbue you with an abiding magical ability or other lessons. You gain one invocation of your choice. If an invocation has a prerequisite, you must meet it to learn that invocation. Whenever you gain a Warlock level, you can replace one of your invocations with another one for which you qualify. You cant replace an invocation if its a prerequisite for another invocation that you have.'),
    ('Warlock', 1, 'PACT MAGIC', 'Through occult ceremony, you have formed a pact with a mysterious entity to gain magical powers. The entity is a voice in the shadows—its identity unclear—but its boon to you is concrete: the ability to cast spells. You know two Warlock cantrips of your choice, such as Eldritch Blast and Prestidigitation. You gain additional cantrips and spells as you gain levels. You regain all expended Pact Magic spell slots when you finish a Short Rest or Long Rest.'),
    ('Warlock', 2, 'MAGICAL CUNNING', 'You can perform an esoteric rite for 1 minute. At the end of it, you regain expended Pact Magic spell slots but no more than a number equal to half your maximum (round up). Once you use this feature, you cant do so again until you finish a Long Rest.'),
    ('Warlock', 3, 'WARLOCK SUBCLASS', 'You gain a Warlock subclass of your choice: Archfey Patron, Celestial Patron, Fiend Patron, Great Old One Patron, Fathomless (Non-Playtest), Genie (Non-Playtest), Hexblade (Non-Playtest), or The Undead (Non-Playtest).'),
    ('Warlock', 4, 'ABILITY SCORE IMPROVEMENT', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify. You gain this feature again at levels 8, 12, 16, and 19.'),
    ('Warlock', 5, '-', '-'),
    ('Warlock', 7, '-', '-'),
    ('Warlock', 6, 'SubClass Feature', 'Description for level 6 subclass feature goes here.'),
    ('Warlock', 8, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Warlock', 9, 'CONTACT PATRON', 'You can communicate directly with your patron; you always have the Contact Other Plane spell prepared. You can cast the spell without expending a spell slot, and you automatically succeed on the spell’s saving throw. Once you cast the spell, you can’t do so again until you finish a Long Rest.'),
    ('Warlock', 10, 'SubClass Feature', 'Description for level 10 subclass feature goes here.'),
    ('Warlock', 11, 'MYSTIC ARCANUM', 'Your patron grants you a magical secret called an arcanum. Choose one level 6 spell from the Warlock spell list. You can cast this spell once without expending a spell slot, and you regain the ability to do so after a Long Rest. You gain more arcanum spells at levels 13, 15, and 17.'),
    ('Warlock', 12, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Warlock', 13, 'Mystic Arcanum', 'Your patron grants you a magical secret called an arcanum. Choose one level 7 spell from the Warlock spell list as this arcanum. You can cast your arcanum spell once without expending a spell slot, and you must finish a Long Rest before you can do so again.'),
    ('Warlock', 14, 'SubClass Feature', 'Description for level 14 subclass feature goes here.'),
    ('Warlock', 15, 'Mystic Arcanum', 'Your patron grants you a magical secret called an arcanum. Choose one level 8 spell from the Warlock spell list as this arcanum. You can cast your arcanum spell once without expending a spell slot, and you must finish a Long Rest before you can do so again.'),
    ('Warlock', 16, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Warlock', 17, 'Mystic Arcanum', 'Your patron grants you a magical secret called an arcanum. Choose one level 9 spell from the Warlock spell list as this arcanum. You can cast your arcanum spell once without expending a spell slot, and you must finish a Long Rest before you can do so again.'),
    ('Warlock', 18, '-', '-'),
    ('Warlock', 19, 'EPIC BOON', 'You gain an Epic Boon feat or another feat of your choice for which you qualify. Boon of Fate is recommended.'),
    ('Warlock', 20, 'ELDRITCH MASTER', 'When you use your Magical Cunning feature, you regain all your expended Pact Magic spell slots.'),
    -- Wizard
    ('Wizard', 1, 'SPELLCASTING (CANTRIPS)', 'You know three cantrips of your choice from the Wizard spell list. Light, Mage Hand, and Ray of Frost are recommended. You can replace one cantrip with another after finishing a Long Rest. At levels 4 and 10, you gain an additional cantrip of your choice.'),
    ('Wizard', 1, 'SPELLCASTING (SPELLBOOK)', 'You possess a spellbook containing six 1st-level spells. You can add two more spells to your spellbook each time you level up, and can prepare a set number of spells each day. Your spellbook can be updated with new spells by finding them during your adventures.'),
    ('Wizard', 1, 'RITUAL ADEPT', 'You can cast any spell with the Ritual tag that is in your spellbook as a Ritual without needing it prepared, but you must read from the book to cast it.'),
    ('Wizard', 1, 'ARCANE RECOVERY', 'When you finish a Short Rest, you can recover expended spell slots of a combined level equal to or less than half your Wizard level.'),
    ('Wizard', 2, 'SCHOLAR', 'Choose one skill in which you have proficiency: Arcana, History, Investigation, Medicine, Nature, or Religion. You gain Expertise in that skill.'),
    ('Wizard', 3, 'WIZARD SUBCLASS', 'You gain a Wizard subclass of your choice, such as Abjurer, Diviner, Evoker, Illusionist, Bladesinger (Non-Playtest), Order of Scribes (Non-Playtest), or War Magic (Non-Playtest).'),
    ('Wizard', 4, 'ABILITY SCORE IMPROVEMENT', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Wizard', 5, 'MEMORIZE SPELL', 'Whenever you finish a Short Rest, you can replace one of the level 1+ spells you have prepared with another spell from your spellbook.'),
    ('Wizard', 18, 'SPELL MASTERY', 'Choose one level 1 spell and one level 2 spell from your spellbook that have a casting time of an action. You can cast them at will without expending a spell slot. You can replace one of them when you finish a Long Rest.'),
    ('Wizard', 19, 'EPIC BOON', 'You gain an Epic Boon feat or another feat of your choice for which you qualify. Boon of Fate is recommended.'),
    ('Wizard', 20, 'SIGNATURE SPELLS', 'Choose two level 3 spells from your spellbook as your signature spells. You can cast each of them once at level 3 without expending a spell slot, and you regain this ability after a Short Rest or Long Rest.'),
    ('Wizard', 6, 'Subclass Feature', 'Description of level 6 subclass feature goes here.'),
    ('Wizard', 10, 'Subclass Feature', 'Description of level 10 subclass feature goes here.'),
    ('Wizard', 14, 'Subclass Feature', 'Description of level 14 subclass feature goes here.'),
    ('Wizard', 8, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Wizard', 12, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Wizard', 16, 'Ability Score Improvement', 'You gain the Ability Score Improvement feat or another feat of your choice for which you qualify.'),
    ('Wizard', 7, '-', '-'),
    ('Wizard', 9, '-', '-'),
    ('Wizard', 11, '-', '-'),
    ('Wizard', 13, '-', '-'),
    ('Wizard', 15, '-', '-'),
    ('Wizard', 17, '-', '-');





