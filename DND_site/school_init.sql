DROP DATABASE IF EXISTS dnd;
CREATE DATABASE dnd;
GRANT ALL PRIVILEGES ON dnd.* TO 'django'@'localhost' WITH GRANT OPTION;
USE dnd;


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
    toolName VARCHAR(15)
);

CREATE TABLE Class (
    className VARCHAR(10) PRIMARY KEY,
    descript VARCHAR(1000),
    hitDice VARCHAR(4),
    -- Make a table for tools
    savingThrowOne VARCHAR(3),
    savingThrowTwo VARCHAR(3)
);

CREATE TABLE SkillsbyClass (
    skill_id INT,
    className VARCHAR(10),
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id),
    FOREIGN KEY (className) REFERENCES Class(className)
);

CREATE TABLE wpnTypebyClass (
    wpn_id INT,
    className VARCHAR(10),
    FOREIGN KEY (wpn_id) REFERENCES WpnType(wpn_id),
    FOREIGN KEY (className) REFERENCES Class(className)
);
CREATE TABLE ToolbyClass (
    tool_id INT,
    className VARCHAR(10),
    FOREIGN KEY (tool_id) REFERENCES Tools(tool_id),
    FOREIGN KEY (className) REFERENCES Class(className)
);
-- _______________________________________________________________
CREATE TABLE ClassByLvl(
    className VARCHAR(10),
    lvl INT,
    Ability VARCHAR(2000) DEFAULT "Feat",
    FOREIGN KEY (className) REFERENCES Class(className)
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
    FOREIGN KEY (className) REFERENCES Class(className)
);
-- _______________________________________________________________
Create TABLE Subclass(
    subclass_id INT PRIMARY KEY AUTO_INCREMENT,
    className VARCHAR(10),
    subclass_name VARCHAR(30),
    descript VARCHAR(1000),
    FOREIGN KEY (className) REFERENCES Class(className)
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
    FOREIGN KEY(className) REFERENCES Class(ClassName)
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
-- __________________________________________________________________
-- INSERTIONS
INSERT INTO Class (className, descript, hitDice, savingThrowOne, savingThrowTwo)
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
