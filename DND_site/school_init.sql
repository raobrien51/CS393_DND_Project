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
    wpnTypeName VARCHAR(15)
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
