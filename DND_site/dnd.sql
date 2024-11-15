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
    subclass_name VARCHAR(40),
    descript TEXT,
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
    School VARCHAR(1000)
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
    lvlReq INT,
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
    race_name VARCHAR(20),
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
    backgroundName VARCHAR(25),
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


INSERT INTO Spell(spell_id ,SpellName,spellLvl, School)
VALUES 
(1, "Abi-Dalzim's Horrid Wilting", 8, 'Necromancy')
(2, 'Absorb Elements', 1, 'Abjuration')
(3, 'Acid Splash', 'Cantrip', 'Conjuration')
(4, "Aganazzar's Scorcher", 2, 'Evocation')
(5, 'Aid', 2, 'Abjuration')
(6, 'Air Bubble', 2, 'Conjuration')
(7, 'Alarm', 1, 'Abjuration')
(8, 'Alter Self', 2, 'Transmutation')
(9, 'Animal Friendship', 1, 'Enchantment')
(10, 'Animal Messenger', 2, 'Enchantment')
(11, 'Animal Shapes', 8, 'Transmutation')
(12, 'Animate Dead', 3, 'Necromancy')
(13, 'Animate Objects', 5, 'Transmutation')
(14, 'Antagonize', 3, 'Enchantment')
(15, 'Antilife Shell', 5, 'Abjuration')
(16, 'Antimagic Field', 8, 'Abjuration')
(17, 'Antipathy/Sympathy', 8, 'Enchantment')
(18, 'Arcane Eye', 4, 'Divination')
(19, 'Arcane Gate', 6, 'Conjuration')
(20, 'Arcane Lock', 2, 'Abjuration')
(21, 'Armor of Agathys', 1, 'Abjuration')
(22, 'Arms of Hadar', 1, 'Conjuration')
(23, "Ashardalon's Stride", 3, 'Transmutation')
(24, 'Astral Projection', 9, 'Necromancy')
(25, 'Augury', 2, 'Divination')
(26, 'Aura of Life', 4, 'Abjuration')
(27, 'Aura of Purity', 4, 'Abjuration')
(28, 'Aura of Vitality', 3, 'Evocation')
(29, 'Awaken', 5, 'Transmutation')
(30, 'Bane', 1, 'Enchantment')
(31, 'Banishing Smite', 5, 'Abjuration')
(32, 'Banishment', 4, 'Abjuration')
(33, 'Barkskin', 2, 'Transmutation')
(34, 'Beacon of Hope', 3, 'Abjuration')
(35, 'Beast Bond', 1, 'Divination')
(36, 'Beast Sense', 2, 'Divination')
(37, 'Bestow Curse', 3, 'Necromancy')
(38, "Bigby's Hand", 5, 'Evocation')
(39, 'Blade Barrier', 6, 'Evocation')
(40, 'Blade of Disaster', 9, 'Conjuration')
(41, 'Blade Ward', 'Cantrip', 'Abjuration')
(42, 'Bless', 1, 'Enchantment')
(43, 'Blight', 4, 'Necromancy')
(44, 'Blinding Smite', 3, 'Evocation')
(45, 'Blindness/Deafness', 2, 'Necromancy')
(46, 'Blink', 3, 'Transmutation')
(47, 'Blur', 2, 'Illusion')
(48, 'Bones of the Earth', 6, 'Transmutation')
(49, 'Booming Blade', 'Cantrip', 'Evocation')
(50, 'Borrowed Knowledge', 2, 'Divination')
(51, 'Branding Smite', 2, 'Evocation')
(52, 'Burning Hands', 1, 'Evocation')
(53, 'Call Lightning', 3, 'Conjuration')
(54, 'Calm Emotions', 2, 'Enchantment')
(55, 'Catapult', 1, 'Transmutation')
(56, 'Catnap', 3, 'Enchantment')
(57, 'Cause Fear', 1, 'Necromancy')
(58, 'Ceremony', 1, 'Abjuration')
(59, 'Chain Lightning', 6, 'Evocation')
(60, 'Chaos Bolt', 1, 'Evocation')
(61, 'Charm Monster', 4, 'Enchantment')
(62, 'Charm Person', 1, 'Enchantment')
(63, 'Chill Touch', 'Cantrip', 'Necromancy')
(64, 'Chromatic Orb', 1, 'Evocation')
(65, 'Circle of Death', 6, 'Necromancy')
(66, 'Circle of Power', 5, 'Abjuration')
(67, 'Clairvoyance', 3, 'Divination')
(68, 'Clone', 8, 'Necromancy')
(69, 'Cloud of Daggers', 2, 'Conjuration')
(70, 'Cloudkill', 5, 'Conjuration')
(71, 'Color Spray', 1, 'Illusion')
(72, 'Command', 1, 'Enchantment')
(73, 'Commune', 5, 'Divination')
(74, 'Commune with Nature', 5, 'Divination')
(75, 'Compelled Duel', 1, 'Enchantment')
(76, 'Comprehend Languages', 1, 'Divination')
(77, 'Compulsion', 4, 'Enchantment')
(78, 'Cone of Cold', 5, 'Evocation')
(79, 'Confusion', 4, 'Enchantment')
(80, 'Conjure Animals', 3, 'Conjuration')
(81, 'Conjure Barrage', 3, 'Conjuration')
(82, 'Conjure Celestial', 7, 'Conjuration')
(83, 'Conjure Elemental', 5, 'Conjuration')
(84, 'Conjure Fey', 6, 'Conjuration')
(85, 'Conjure Minor Elementals', 4, 'Conjuration')
(86, 'Conjure Volley', 5, 'Conjuration')
(87, 'Conjure Woodland Beings', 4, 'Conjuration')
(88, 'Contact Other Plane', 5, 'Divination')
(89, 'Contagion', 5, 'Necromancy')
(90, 'Contingency', 6, 'Evocation')
(91, 'Continual Flame', 2, 'Evocation')
(92, 'Control Flames', 'Cantrip', 'Transmutation')
(93, 'Control Water', 4, 'Transmutation')
(94, 'Control Weather', 8, 'Transmutation')
(95, 'Control Winds', 5, 'Transmutation')
(96, 'Cordon of Arrows', 2, 'Transmutation')
(97, 'Counterspell', 3, 'Abjuration')
(98, 'Create Bonfire', 'Cantrip', 'Conjuration')
(99, 'Create Food and Water', 3, 'Conjuration')
(100, 'Create Homunculus', 6, 'Transmutation')
(101, 'Create Magen', 7, 'Transmutation')
(102, 'Create or Destroy Water', 1, 'Transmutation')
(103, 'Create Spelljamming Helm', 5, 'Transmutation')
(104, 'Create Undead', 6, 'Necromancy')
(105, 'Creation', 5, 'Illusion')
(106, 'Crown of Madness', 2, 'Enchantment')
(107, 'Crown of Stars', 7, 'Evocation')
(108, "Crusader's Mantle", 3, 'Evocation')
(109, 'Cure Wounds', 1, 'Evocation')
(110, 'Dancing Lights', 'Cantrip', 'Evocation')
(111, 'Danse Macabre', 5, 'Necromancy')
(112, 'Darkness', 2, 'Evocation')
(113, 'Dark Star', 8, 'Evocation')
(114, 'Darkvision', 2, 'Transmutation')
(115, 'Dawn', 5, 'Evocation')
(116, 'Daylight', 3, 'Evocation')
(117, 'Death Ward', 4, 'Abjuration')
(118, 'Delayed Blast Fireball', 7, 'Evocation')
(119, 'Demiplane', 8, 'Conjuration')
(120, 'Destructive Wave', 5, 'Evocation')
(121, 'Detect Evil and Good', 1, 'Divination')
(122, 'Detect Magic', 1, 'Divination')
(123, 'Detect Poison and Disease', 1, 'Divination')
(124, 'Detect Thoughts', 2, 'Divination')
(125, 'Dimension Door', 4, 'Conjuration')
(126, 'Disguise Self', 1, 'Illusion')
(127, 'Disintegrate', 6, 'Transmutation')
(128, 'Dispel Evil and Good', 5, 'Abjuration')
(129, 'Dispel Magic', 3, 'Abjuration')
(130, 'Dissonant Whispers', 1, 'Enchantment')
(131, 'Distort Value', 1, 'Illusion')
(132, 'Divination', 4, 'Divination')
(133, 'Divine Favor', 1, 'Evocation')
(134, 'Divine Word', 7, 'Evocation')
(135, 'Dominate Beast', 4, 'Enchantment')
(136, 'Dominate Monster', 8, 'Enchantment')
(137, 'Dominate Person', 5, 'Enchantment')
(138, 'Draconic Transformation', 7, 'Transmutation')
(139, "Dragon's Breath", 2, 'Transmutation')
(140, "Drawmij's Instant Summons", 6, 'Conjuration')
(141, 'Dream', 5, 'Illusion')
(142, 'Dream of the Blue Veil', 7, 'Conjuration')
(143, 'Druid Grove', 6, 'Abjuration')
(144, 'Druidcraft', 'Cantrip', 'Transmutation')
(145, 'Dust Devil', 2, 'Conjuration')
(146, 'Earthbind', 2, 'Transmutation')
(147, 'Earth Tremor', 1, 'Evocation')
(148, 'Earthquake', 8, 'Evocation')
(149, 'Eldritch Blast', 'Cantrip', 'Evocation')
(150, 'Elemental Bane', 4, 'Transmutation')
(151, 'Elemental Weapon', 3, 'Transmutation')
(152, 'Encode Thoughts', 'Cantrip', 'Enchantment')
(153, 'Enemies Abound', 3, 'Enchantment')
(154, 'Enervation', 5, 'Necromancy')
(155, 'Enhance Ability', 2, 'Transmutation')
(156, 'Enlarge/Reduce', 2, 'Transmutation')
(157, 'Ensnaring Strike', 1, 'Conjuration')
(158, 'Entangle', 1, 'Conjuration')
(159, 'Enthrall', 2, 'Enchantment')
(160, 'Erupting Earth', 3, 'Transmutation')
(161, 'Etherealness', 7, 'Transmutation')
(162, "Evard's Black Tentacles", 4, 'Conjuration')
(163, 'Expeditious Retreat', 1, 'Transmutation')
(164, 'Eyebite', 6, 'Necromancy')
(165, 'Fabricate', 4, 'Transmutation')
(166, 'Faerie Fire', 1, 'Evocation')
(167, 'False Life', 1, 'Necromancy')
(168, 'Far Step', 5, 'Conjuration')
(169, 'Fast Friends', 3, 'Enchantment')
(170, 'Fear', 3, 'Illusion')
(171, 'Feather Fall', 1, 'Transmutation')
(172, 'Feeblemind', 8, 'Enchantment')
(173, 'Feign Death', 3, 'Necromancy')
(174, 'Find Familiar', 1, 'Conjuration')
(175, 'Find Greater Steed', 4, 'Conjuration')
(176, 'Find Steed', 2, 'Conjuration')
(177, 'Find the Path', 6, 'Divination')
(178, 'Find Traps', 2, 'Divination')
(179, 'Finger of Death', 7, 'Necromancy')
(180, 'Fireball', 3, 'Evocation')
(181, 'Fire Bolt', 'Cantrip', 'Evocation')
(182, 'Fire Shield', 4, 'Evocation')
(183, 'Fire Storm', 7, 'Evocation')
(184, "Fizban's Platinum Shield", 6, 'Abjuration')
(185, 'Flame Arrows', 3, 'Transmutation')
(186, 'Flame Blade', 2, 'Evocation')
(187, 'Flame Strike', 5, 'Evocation')
(188, 'Flaming Sphere', 2, 'Conjuration')
(189, 'Flesh to Stone', 6, 'Transmutation')
(190, 'Flock of Familiars', 2, 'Conjuration')
(191, 'Fly', 3, 'Transmutation')
(192, 'Fog Cloud', 1, 'Conjuration')
(193, 'Forbiddance', 6, 'Abjuration')
(194, 'Forcecage', 7, 'Evocation')
(195, 'Foresight', 9, 'Divination')
(196, "Fortune's Favor", 2, 'Divination')
(197, 'Freedom of Movement', 4, 'Abjuration')
(198, 'Freedom of the Waves', 3, 'Conjuration')
(199, 'Freedom of the Winds', 5, 'Abjuration')
(200, 'Friends', 'Cantrip', 'Enchantment')
(201, 'Frostbite', 'Cantrip', 'Evocation')
(202, 'Frost Fingers', 1, 'Evocation')
(203, "Galder's Speedy Courier", 4, 'Conjuration')
(204, "Galder's Tower", 3, 'Conjuration')
(205, 'Gaseous Form', 3, 'Transmutation')
(206, 'Gate', 9, 'Conjuration')
(207, 'Geas', 5, 'Enchantment')
(208, 'Gentle Repose', 2, 'Necromancy')
(209, 'Giant Insect', 4, 'Transmutation')
(210, 'Gift of Alacrity', 1, 'Divination')
(211, 'Gift of Gab', 2, 'Enchantment')
(212, 'Glibness', 8, 'Transmutation')
(213, 'Globe of Invulnerability', 6, 'Abjuration')
(214, 'Glyph of Warding', 3, 'Abjuration')
(215, 'Goodberry', 1, 'Conjuration')
(216, 'Grasping Vine', 4, 'Conjuration')
(217, 'Gravity Fissure', 6, 'Evocation')
(218, 'Gravity Sinkhole', 4, 'Evocation')
(219, 'Grease', 1, 'Conjuration')
(220, 'Greater Invisibility', 4, 'Illusion')
(221, 'Greater Restoration', 5, 'Abjuration')
(222, 'Green-Flame Blade', 'Cantrip', 'Evocation')
(223, 'Guardian of Faith', 4, 'Conjuration')
(224, 'Guardian of Nature', 4, 'Transmutation')
(225, 'Guards and Wards', 6, 'Abjuration')
(226, 'Guidance', 'Cantrip', 'Divination')
(227, 'Guiding Bolt', 1, 'Evocation')
(228, 'Gust', 'Cantrip', 'Transmutation')
(229, 'Gust of Wind', 2, 'Evocation')
(230, 'Hail of Thorns', 1, 'Conjuration')
(231, 'Hallow', 5, 'Evocation')
(232, 'Hallucinatory Terrain', 4, 'Illusion')
(233, 'Harm', 6, 'Necromancy')
(234, 'Haste', 3, 'Transmutation')
(235, 'Heal', 6, 'Evocation')
(236, 'Healing Spirit', 2, 'Conjuration')
(237, 'Healing Word', 1, 'Evocation')
(238, 'Heat Metal', 2, 'Transmutation')
(239, 'Hellish Rebuke', 1, 'Evocation')
(240, "Heroes' Feast", 6, 'Conjuration')
(241, 'Heroism', 1, 'Enchantment')
(242, 'Hex', 1, 'Enchantment')
(243, 'Hold Monster', 5, 'Enchantment')
(244, 'Hold Person', 2, 'Enchantment')
(245, 'Holy Aura', 8, 'Abjuration')
(246, 'Holy Weapon', 5, 'Evocation')
(247, 'Hunger of Hadar', 3, 'Conjuration')
(248, "Hunter's Mark", 1, 'Divination')
(249, 'Hypnotic Pattern', 3, 'Illusion')
(250, 'Ice Knife', 1, 'Conjuration')
(251, 'Ice Storm', 4, 'Evocation')
(252, 'Identify', 1, 'Divination')
(253, 'Illusory Dragon', 8, 'Illusion')
(254, 'Illusory Script', 1, 'Illusion')
(255, 'Immolation', 5, 'Evocation')
(256, 'Immovable Object', 2, 'Transmutation')
(257, 'Imprisonment', 9, 'Abjuration')
(258, 'Incendiary Cloud', 8, 'Conjuration')
(259, 'Incite Greed', 3, 'Enchantment')
(260, 'Infernal Calling', 5, 'Conjuration')
(261, 'Infestation', 'Cantrip', 'Conjuration')
(262, 'Inflict Wounds', 1, 'Necromancy')
(263, 'Insect Plague', 5, 'Conjuration')
(264, 'Intellect Fortress', 3, 'Abjuration')
(265, 'Investiture of Flame', 6, 'Transmutation')
(266, 'Investiture of Ice', 6, 'Transmutation')
(267, 'Investiture of Stone', 6, 'Transmutation')
(268, 'Investiture of Wind', 6, 'Transmutation')
(269, 'Invisibility', 2, 'Illusion')
(270, 'Invulnerability', 9, 'Abjuration')
(271, "Jim's Glowing Coin", 2, 'Enchantment')
(272, "Jim's Magic Missile", 1, 'Evocation')
(273, 'Jump', 1, 'Transmutation')
(274, 'Kinetic Jaunt', 2, 'Transmutation')
(275, 'Knock', 2, 'Transmutation')
(276, 'Legend Lore', 5, 'Divination')
(277, "Leomund's Secret Chest", 4, 'Conjuration')
(278, "Leomund's Tiny Hut", 3, 'Evocation')
(279, 'Lesser Restoration', 2, 'Abjuration')
(280, 'Levitate', 2, 'Transmutation')
(281, 'Life Transference', 3, 'Necromancy')
(282, 'Light', 'Cantrip', 'Evocation')
(283, 'Lightning Arrow', 3, 'Transmutation')
(284, 'Lightning Bolt', 3, 'Evocation')
(285, 'Lightning Lure', 'Cantrip', 'Evocation')
(286, 'Locate Animals or Plants', 2, 'Divination')
(287, 'Locate Creature', 4, 'Divination')
(288, 'Locate Object', 2, 'Divination')
(289, 'Longstrider', 1, 'Transmutation')
(290, 'Maddening Darkness', 8, 'Evocation')
(291, 'Maelstrom', 5, 'Evocation')
(292, 'Mage Armor', 1, 'Abjuration')
(293, 'Mage Hand', 'Cantrip', 'Conjuration')
(294, 'Magic Circle', 3, 'Abjuration')
(295, 'Magic Jar', 6, 'Necromancy')
(296, 'Magic Missile', 1, 'Evocation')
(297, 'Magic Mouth', 2, 'Illusion')
(298, 'Magic Stone', 'Cantrip', 'Transmutation')
(299, 'Magic Weapon', 2, 'Transmutation')
(300, 'Magnify Gravity', 1, 'Transmutation')
(301, 'Major Image', 3, 'Illusion')
(302, 'Mass Cure Wounds', 5, 'Evocation')
(303, 'Mass Heal', 9, 'Evocation')
(304, 'Mass Healing Word', 3, 'Evocation')
(305, 'Mass Polymorph', 9, 'Transmutation')
(306, 'Mass Suggestion', 6, 'Enchantment')
(307, "Maximilian's Earthen Grasp", 2, 'Transmutation')
(308, 'Maze', 8, 'Conjuration')
(309, 'Meld into Stone', 3, 'Transmutation')
(310, "Melf's Acid Arrow", 2, 'Evocation')
(311, "Melf's Minute Meteors", 3, 'Evocation')
(312, 'Mending', 'Cantrip', 'Transmutation')
(313, 'Mental Prison', 6, 'Illusion')
(314, 'Message', 'Cantrip', 'Transmutation')
(315, 'Meteor Swarm', 9, 'Evocation')
(316, 'Mighty Fortress', 8, 'Conjuration')
(317, 'Mind Blank', 8, 'Abjuration')
(318, 'Mind Sliver', 'Cantrip', 'Enchantment')
(319, 'Mind Spike', 2, 'Divination')
(320, 'Minor Illusion', 'Cantrip', 'Illusion')
(321, 'Mirage Arcane', 7, 'Illusion')
(322, 'Mirror Image', 2, 'Illusion')
(323, 'Mislead', 5, 'Illusion')
(324, 'Misty Step', 2, 'Conjuration')
(325, 'Modify Memory', 5, 'Enchantment')
(326, 'Mold Earth', 'Cantrip', 'Transmutation')
(327, 'Moonbeam', 2, 'Evocation')
(328, "Mordenkainen's Faithful Hound", 4, 'Conjuration')
(329, "Mordenkainen's Magnificent Mansion", 7, 'Conjuration')
(330, "Mordenkainen's Private Sanctum", 4, 'Abjuration')
(331, "Mordenkainen's Sword", 7, 'Evocation')
(332, 'Motivational Speach', 3, 'Enchantment')
(333, 'Move Earth', 6, 'Transmutation')
(334, "Nathair's Mischief", 2, 'Illusion')
(335, 'Negative Energy Flood', 5, 'Necromancy')
(336, 'Nondetection', 3, 'Abjuration')
(337, "Nystul's Magic Aura", 2, 'Illusion')
(338, "Otiluke's Freezing Sphere", 6, 'Evocation')
(339, "Otiluke's Resilient Sphere", 4, 'Evocation')
(340, "Otto's Irresistible Dance", 6, 'Enchantment')
(341, 'Pass Without Trace', 2, 'Abjuration')
(342, 'Passwall', 5, 'Transmutation')
(343, 'Phantasmal Force', 2, 'Illusion')
(344, 'Phantasmal Killer', 4, 'Illusion')
(345, 'Phantom Steed', 3, 'Illusion')
(346, 'Planar Ally', 6, 'Conjuration')
(347, 'Planar Binding', 5, 'Abjuration')
(348, 'Plane Shift', 7, 'Conjuration')
(349, 'Plant Growth', 3, 'Transmutation')
(350, 'Poison Spray', 'Cantrip', 'Conjuration')
(351, 'Polymorph', 4, 'Transmutation')
(352, 'Power Word Heal', 9, 'Evocation')
(353, 'Power Word Kill', 9, 'Enchantment')
(354, 'Power Word Pain', 7, 'Enchantment')
(355, 'Power Word Stun', 8, 'Enchantment')
(356, 'Prayer of Healing', 2, 'Evocation')
(357, 'Prestidigitation', 'Cantrip', 'Transmutation')
(358, 'Primal Savagery', 'Cantrip', 'Transmutation')
(359, 'Primordial Ward', 6, 'Abjuration')
(360, 'Prismatic Spray', 7, 'Evocation')
(361, 'Prismatic Wall', 9, 'Abjuration')
(362, 'Produce Flame', 'Cantrip', 'Conjuration')
(363, 'Programmed Illusion', 6, 'Illusion')
(364, 'Project Image', 7, 'Illusion')
(365, 'Protection from Energy', 3, 'Abjuration')
(366, 'Protection from Evil and Good', 1, 'Abjuration')
(367, 'Protection from Poison', 2, 'Abjuration')
(368, 'Psychic Scream', 9, 'Enchantment')
(369, 'Pulse Wave', 3, 'Evocation')
(370, 'Purify Food and Drink', 1, 'Abjuration')
(371, 'Pyrotechnics', 2, 'Transmutation')
(372, 'Raise Dead', 5, 'Necromancy')
(373, "Rary's Telepathic Bond", 5, 'Divination')
(374, "Raulothim's Psychic Lance", 4, 'Enchantment')
(375, 'Ravenous Void', 9, 'Evocation')
(376, 'Ray of Enfeeblement', 2, 'Necromancy')
(377, 'Ray of Frost', 'Cantrip', 'Evocation')
(378, 'Ray of Sickness', 1, 'Necromancy')
(379, 'Reality Break', 8, 'Conjuration')
(380, 'Regenerate', 7, 'Transmutation')
(381, 'Reincarnate', 5, 'Transmutation')
(382, 'Remove Curse', 3, 'Abjuration')
(383, 'Resistance', 'Cantrip', 'Abjuration')
(384, 'Resurrection', 7, 'Necromancy')
(385, 'Reverse Gravity', 7, 'Transmutation')
(386, 'Revivify', 3, 'Necromancy')
(387, "Rime's Binding Ice", 2, 'Evocation')
(388, 'Rope Trick', 2, 'Transmutation')
(389, 'Sacred Flame', 'Cantrip', 'Evocation')
(390, 'Sanctuary', 1, 'Abjuration')
(391, 'Sapping Sting', 'Cantrip', 'Necromancy')
(392, 'Scatter', 6, 'Conjuration')
(393, 'Scorching Ray', 2, 'Evocation')
(394, 'Scrying', 5, 'Divination')
(395, 'Searing Smite', 1, 'Evocation')
(396, 'See Invisibility', 2, 'Divination')
(397, 'Seeming', 5, 'Illusion')
(398, 'Sending', 3, 'Evocation')
(399, 'Sequester', 7, 'Transmutation')
(400, 'Shadow Blade', 2, 'Illusion')
(401, 'Shadow of Moil', 4, 'Necromancy')
(402, 'Shape Water', 'Cantrip', 'Transmutation')
(403, 'Shapechange', 9, 'Transmutation')
(404, 'Shatter', 2, 'Evocation')
(405, 'Shield', 1, 'Abjuration')
(406, 'Shield of Faith', 1, 'Abjuration')
(407, 'Shillelagh', 'Cantrip', 'Transmutation')
(408, 'Shocking Grasp', 'Cantrip', 'Evocation')
(409, 'Sickening Radiance', 4, 'Evocation')
(410, 'Silence', 2, 'Illusion')
(411, 'Silent Image', 1, 'Illusion')
(412, 'Silvery Barbs', 1, 'Enchantment')
(413, 'Simulacrum', 7, 'Illusion')
(414, 'Skill Empowerment', 5, 'Transmutation')
(415, 'Skywrite', 2, 'Transmutation')
(416, 'Sleep', 1, 'Enchantment')
(417, 'Sleet Storm', 3, 'Conjuration')
(418, 'Slow', 3, 'Transmutation')
(419, 'Snare', 1, 'Abjuration')
(420, "Snilloc's Snowball Swarm", 2, 'Evocation')
(421, 'Soul Cage', 6, 'Necromancy')
(422, 'Spare the Dying', 'Cantrip', 'Necromancy')
(423, 'Speak with Animals', 1, 'Divination')
(424, 'Speak with Dead', 3, 'Necromancy')
(425, 'Speak with Plants', 3, 'Transmutation')
(426, 'Spider Climb', 2, 'Transmutation')
(427, 'Spike Growth', 2, 'Transmutation')
(428, 'Spirit Guardians', 3, 'Conjuration')
(429, 'Spirit of Death', 4, 'Necromancy')
(430, 'Spirit Shroud', 3, 'Necromancy')
(431, 'Spiritual Weapon', 2, 'Evocation')
(432, 'Spray of Cards', 2, 'Conjuration')
(433, 'Staggering Smite', 4, 'Evocation')
(434, 'Steel Wind Strike', 5, 'Conjuration')
(435, 'Stinking Cloud', 3, 'Conjuration')
(436, 'Stone Shape', 4, 'Transmutation')
(437, 'Stoneskin', 4, 'Abjuration')
(438, 'Storm of Vengeance', 9, 'Conjuration')
(439, 'Storm Sphere', 4, 'Evocation')
(440, 'Suggestion', 2, 'Enchantment')
(441, 'Summon Aberration', 4, 'Conjuration')
(442, 'Summon Beast', 2, 'Conjuration')
(443, 'Summon Celestial', 5, 'Conjuration')
(444, 'Summon Construct', 4, 'Conjuration')
(445, 'Summon Draconic Spirit', 5, 'Conjuration')
(446, 'Summon Elemental', 4, 'Conjuration')
(447, 'Summon Fey', 3, 'Conjuration')
(448, 'Summon Fiend', 6, 'Conjuration')
(449, 'Summon Greater Demon', 4, 'Conjuration')
(450, 'Summon Lesser Demons', 3, 'Conjuration')
(451, 'Summon Shadowspawn', 3, 'Conjuration')
(452, 'Summon Undead', 3, 'Necromancy')
(453, 'Sunbeam', 6, 'Evocation')
(454, 'Sunburst', 8, 'Evocation')
(455, 'Swift Quiver', 5, 'Transmutation')
(456, 'Sword Burst', 'Cantrip', 'Conjuration')
(457, 'Symbol', 7, 'Abjuration')
(458, 'Synaptic Static', 5, 'Enchantment')
(459, "Tasha's Caustic Brew", 1, 'Evocation')
(460, "Tasha's Hideous Laughter", 1, 'Enchantment')
(461, "Tasha's Mind Whip", 2, 'Enchantment')
(462, "Tasha's Otherworldly Guise", 6, 'Transmutation')
(463, 'Telekinesis', 5, 'Transmutation')
(464, 'Telepathy', 8, 'Evocation')
(465, 'Teleport', 7, 'Conjuration')
(466, 'Teleportation Circle', 5, 'Conjuration')
(467, 'Temple of the Gods', 7, 'Conjuration')
(468, 'Temporal Shunt', 5, 'Transmutation')
(469, "Tenser's Floating Disk", 1, 'Conjuration')
(470, "Tenser's Transformation", 6, 'Transmutation')
(471, 'Tether Essence', 7, 'Necromancy')
(472, 'Thaumaturgy', 'Cantrip', 'Transmutation')
(473, 'Thorn Whip', 'Cantrip', 'Transmutation')
(474, 'Thunderclap', 'Cantrip', 'Evocation')
(475, 'Thunder Step', 3, 'Conjuration')
(476, 'Thunderous Smite', 1, 'Evocation')
(477, 'Thunderwave', 1, 'Evocation')
(478, 'Tidal Wave', 3, 'Conjuration')
(479, 'Time Ravage', 9, 'Necromancy')
(480, 'Time Stop', 9, 'Transmutation')
(481, 'Tiny Servant', 3, 'Conjuration')
(482, 'Toll the Dead', 'Cantrip', 'Necromancy')
(483, 'Tongues', 3, 'Divination')
(484, 'Transmute Rock', 5, 'Transmutation')
(485, 'Transport via Plants', 6, 'Conjuration')
(486, 'Tree Stride', 5, 'Conjuration')
(487, 'True Polymorph', 9, 'Transmutation')
(488, 'True Resurrection', 9, 'Necromancy')
(489, 'True Seeing', 6, 'Divination')
(490, 'True Strike', 'Cantrip', 'Divination')
(491, 'Tsunami', 8, 'Conjuration')
(492, 'Unseen Servant', 1, 'Conjuration')
(493, 'Vampiric Touch', 3, 'Necromancy')
(494, 'Vicious Mockery', 'Cantrip', 'Enchantment')
(495, 'Vitriolic Sphere', 4, 'Evocation')
(496, 'Vortex Warp', 2, 'Conjuration')
(497, 'Wall of Fire', 4, 'Evocation')
(498, 'Wall of Force', 5, 'Evocation')
(499, 'Wall of Ice', 6, 'Evocation')
(500, 'Wall of Light', 5, 'Evocation')
(501, 'Wall of Sand', 3, 'Evocation')
(502, 'Wall of Stone', 5, 'Evocation')
(503, 'Wall of Thorns', 6, 'Conjuration')
(504, 'Wall of Water', 3, 'Evocation')
(505, 'Warding Bond', 2, 'Abjuration')
(506, 'Warding Wind', 2, 'Evocation')
(507, 'Water Breathing', 3, 'Transmutation')
(508, 'Water Walk', 3, 'Transmutation')
(509, 'Watery Sphere', 4, 'Conjuration')
(510, 'Web', 2, 'Conjuration')
(511, 'Weird', 9, 'Illusion')
(512, 'Whirlwind', 7, 'Evocation')
(513, 'Wind Walk', 6, 'Transmutation')
(514, 'Wind Wall', 3, 'Evocation')
(515, 'Wish', 9, 'Conjuration')
(516, 'Witch Bolt', 1, 'Evocation')
(517, 'Wither and Bloom', 2, 'Necromancy')
(518, 'Word of Radiance', 'Cantrip', 'Evocation')
(519, 'Word of Recall', 6, 'Conjuration')
(520, 'Wrath of Nature', 5, 'Evocation')
(521, 'Wrathful Smite', 1, 'Evocation')
(522, 'Wristpocket', 2, 'Conjuration')
(523, 'Zephyr Strike', 1, 'Transmutation')
(524, 'Zone of Truth', 2, 'Enchantment')



    
INSERT INTO Skills (skillName) 
VALUES
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
    ('Cleric', 3, 'Cleric Subclass', 'You gain a Cleric subclass of your choice: Life Domain, Light Domain, Trickery Domain'),
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
    ('Druid', 3, 'Druid Subclass', 'You gain a Druid subclass of your choice: Circle of the Land, Circle of the Moon, Circle of the Sea, Circle of Stars'),
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
('Paladin', 3, 'Paladin Subclass', 'You gain a Paladin subclass of your choice and subclass features at this level.'),
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

    ('Ranger', 3, 'Ranger Subclass', 'You gain a Ranger subclass of your choice: Beast Master, Fey Wanderer, Gloom Stalker, Hunter'),

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
    ('Rogue', 3, 'Rogue Subclass', 'At 3rd level, you gain a Rogue subclass of your choice. Subclasses grant unique features that enhance your Rogue abilities.'),
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
    ('Warlock', 3, 'WARLOCK SUBCLASS', 'You gain a Warlock subclass of your choice: Archfey Patron, Celestial Patron, Fiend Patron, Great Old One Patron.'),
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
    ('Wizard', 3, 'WIZARD SUBCLASS', 'You gain a Wizard subclass of your choice, such as Abjurer, Diviner, Evoker, Illusionist.'),
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

INSERT INTO Subclass (className, subclass_name, descript) 
VALUES
    ('Artificer', 'Artillerist', 'The Artillerist specializes in explosive magic and crafting powerful artillery devices.'),
    ('Artificer', 'Alchemist', 'The Alchemist crafts potions and elixirs, using magic to manipulate the essence of life and death.'),
    ('Artificer', 'Armorer', 'The Armorer combines magic and engineering to create powerful suits of armor that grant supernatural abilities.'),
    
    ('Barbarian', 'Path of the Berserker', 'The Berserker gains strength and fury in battle, focusing on reckless attacks and unyielding rage.'),
    ('Barbarian', 'Path of the Wild Heart', 'The Wild Heart channels the untamed spirit of nature, gaining primal abilities and a connection to animals.'),
    ('Barbarian', 'Path of the World Tree', 'The World Tree grants connection to the spiritual realms, embodying the wisdom of the natural world.'),
    ('Barbarian', 'Path of the Zealot', 'The Zealot’s fury is driven by divine inspiration, allowing for destructive power fueled by divine rage.'),
    
    ('Bard', 'College of Dance', 'The College of Dance uses the art of movement to inspire, confuse, and dazzle allies and foes alike.'),
    ('Bard', 'College of Glamour', 'The College of Glamour specializes in enchanting others with mesmerizing performances and charisma.'),
    ('Bard', 'College of Lore', 'The College of Lore is focused on learning and knowledge, giving the Bard magical abilities and a broad repertoire of spells.'),
    ('Bard', 'College of Valor', 'The College of Valor focuses on battle prowess and inspiring others to perform heroic feats in combat.'),
    
    ('Cleric', 'Life Domain', 'The Life Domain is dedicated to healing and protecting others, channeling divine energy to sustain life.'),
    ('Cleric', 'Light Domain', 'The Light Domain focuses on radiant power to dispel darkness and protect others through holy fire.'),
    ('Cleric', 'Trickery Domain', 'The Trickery Domain embraces deception and misdirection, manipulating illusions and the minds of others.'),
    ('Cleric', 'War Domain', 'The War Domain is focused on combat, channeling divine power to aid in battle and protect others.'),
    
    ('Druid', 'Circle of the Land', 'The Circle of the Land offers an intimate connection with nature, enhancing elemental magic.'),
    ('Druid', 'Circle of the Moon', 'The Circle of the Moon allows Druids to transform into powerful beasts with enhanced physical abilities.'),
    ('Druid', 'Circle of the Sea', 'The Circle of the Sea attunes the Druid to the water’s power, gaining the ability to control tides and storms.'),
    ('Druid', 'Circle of the Stars', 'The Circle of the Stars connects the Druid to celestial power, guiding them to control star magic.'),
    
    ('Fighter', 'Battle Master', 'The Battle Master specializes in tactical combat, using maneuvers to control the battlefield.'),
    ('Fighter', 'Champion', 'The Champion is a master of physical prowess, excelling in brute strength and endurance.'),
    ('Fighter', 'Psi Warrior', 'The Psi Warrior blends martial skills with psionic powers, controlling the mind and body in combat.'),
    ('Fighter', 'Eldritch Knight', 'The Eldritch Knight combines magic and weaponry, casting spells while fighting with a sword or other weapon.'),
    
    ('Monk', 'Warrior of Mercy', 'The Warrior of Mercy focuses on unarmed combat and healing, using strikes that cripple enemies and restore allies.'),
    ('Monk', 'Warrior of Shadow', 'The Warrior of Shadow gains stealth and shadow manipulation abilities, striking from the darkness with precision.'),
    ('Monk', 'Warrior of Elements', 'The Warrior of Elements harnesses the power of the natural elements to enhance their martial abilities.'),
    ('Monk', 'Warrior of Open Hand', 'The Warrior of Open Hand focuses on perfecting unarmed combat, using disciplined martial arts to control foes.'),
    
    ('Paladin', 'Oath of Devotion', 'The Oath of Devotion represents purity and honor, pledging to protect others from evil and injustice.'),
    ('Paladin', 'Oath of Glory', 'The Oath of Glory focuses on achieving personal excellence and inspiring others to greatness.'),
    ('Paladin', 'Oath of Ancients', 'The Oath of Ancients is sworn to protect the forces of nature and light from corruption.'),
    ('Paladin', 'Oath of Vengeance', 'The Oath of Vengeance is taken by those seeking retribution, dedicating their power to punishing wrongdoers.'),
    
    ('Ranger', 'Beast Master', 'The Beast Master forms a bond with a powerful animal companion, fighting side by side in battle.'),
    ('Ranger', 'Fey Wanderer', 'The Fey Wanderer is attuned to the Feywild, gaining magical powers to manipulate fey energy.'),
    ('Ranger', 'Gloom Stalker', 'The Gloom Stalker specializes in stealth and ambush, manipulating darkness to move unseen and strike swiftly.'),
    ('Ranger', 'Hunter', 'The Hunter excels at fighting particular enemies, honing skills to track and neutralize their foes.'),
    
    ('Rogue', 'Arcane Trickster', 'The Arcane Trickster blends magic and stealth, using spells to deceive, disarm, and confound enemies.'),
    ('Rogue', 'Assassin', 'The Assassin excels at dealing deadly strikes, using deception and stealth to eliminate enemies.'),
    ('Rogue', 'Soulknife', 'The Soulknife manifests psionic blades, enhancing their combat abilities with mental power and skill.'),
    ('Rogue', 'Thief', 'The Thief specializes in quick movements, stealing and using tools to break into places and steal valuable items.'),
    
    ('Sorcerer', 'Aberrant', 'The Aberrant sorcerer draws on alien and incomprehensible powers, manifesting strange and chaotic magic.'),
    ('Sorcerer', 'Clockwork', 'The Clockwork sorcerer channels the precision and order of clockwork mechanisms into their magical abilities.'),
    ('Sorcerer', 'Draconic', 'The Draconic sorcerer has inherited the power of dragons, gaining abilities tied to elemental force.'),
    ('Sorcerer', 'Wild Magic', 'The Wild Magic sorcerer taps into the unpredictable forces of magic, unleashing chaos and randomness.'),
    
    ('Warlock', 'Celestial', 'The Celestial patron is a divine being who grants light and healing powers to the Warlock.'),
    ('Warlock', 'Fiend', 'The Fiend patron provides power at a steep cost, often demanding that their Warlock commit evil acts for power.'),
    ('Warlock', 'Archfey', 'The Archfey patron grants unpredictable and beguiling powers that bend the will of others to your control.'),
    ('Warlock', 'Great Old One', 'The Great Old One patron grants mind-bending psychic abilities, tied to the cosmic horrors of the deep.'),
    
    ('Wizard', 'Abjurer', 'The Abjurer is focused on protective and defensive magic, excelling at warding against harmful magic.'),
    ('Wizard', 'Diviner', 'The Diviner specializes in the magic of foresight, allowing them to predict and influence the future.'),
    ('Wizard', 'Evoker', 'The Evoker specializes in elemental magic, creating destructive spells that deal massive damage.'),
    ('Wizard', 'Illusionist', 'The Illusionist specializes in creating false images and illusions to confuse and deceive their enemies.');


INSERT INTO Feat (featName, lvlReq, descript) 
VALUES
    ('Ability Score Improvement', 1, 'Increase one ability score of your choice by 2, or increase two ability scores of your choice by 1. This feat cant increase an ability score above 20. Repeatable. You can take this feat more than once.'),
    ('Actor', 1, 'Increase your Charisma score by 1, to a maximum of 20. Impersonation. While youre disguised as a real or fictional person, you have Advantage on Charisma (Deception or Performance) checks to convince others that you are that person. You can mimic the sounds of other creatures, including speech. A creature that hears the mimicry must succeed on a Wisdom (Insight) check to determine the effect is faked (DC 8 plus your Charisma modifier and Proficiency Bonus).'),
    ('Alert', 1, 'When you roll Initiative, you can add your Proficiency Bonus to the roll. Immediately after you roll Initiative, you can swap your Initiative with the Initiative of one willing ally in the same combat. You cant make this swap if you or the ally has the Incapacitated condition.'),
    ('Archery', 1, 'Fighting Style Feat, You gain a +2 bonus to attack rolls you make with Ranged weapons.'),
    ('Athlete', 1, 'Increase your Strength or Dexterity score by 1, to a maximum of 20. You gain a Climb Speed equal to your Speed. When you have the Prone condition, you can right yourself with only 5 feet of movement. You can make a running Long or High Jump after moving only 5 feet.'),
    ('Blind Fighting', 1, 'Fighting Style Feat, You have Blindsight with a range of 10 feet.'),
    ('Boon of Combat Prowess', 19, 'Epic Boon Feat, Increase one ability score of your choice by 1, to a maximum of 30. When you miss with an attack roll, you can hit instead. Once you use this benefit, you cant use it again until the start of your next turn.'),
    ('Boon of Dimensional Travel', 19, 'Epic Boon Feat, Increase one ability score of your choice by 1, to a maximum of 30. Immediately after you take the Attack action or the Magic action, you can teleport up to 30 feet to an unoccupied space you can see.'),
    ('Boon of Energy Resistance', 19, 'Epic Boon Feat, Increase your Constitution, Intelligence, Wisdom, or Charisma score by 1, to a maximum of 30. You gain Resistance to two of the following damage types of your choice: Acid, Cold, Fire, Lightning, Necrotic, Poison, Psychic, Radiant, or Thunder. Whenever you finish a Long Rest, you can meditate and change those choices. When you take damage of a type to which you have Resistance, you can use your Reaction to direct damage of the same type toward another creature you can see within 60 feet of yourself that isnt behind Total Cover. If you do so, that creature must succeed on a Dexterity saving throw (DC equals 8 + your Proficiency Bonus + the ability modifier of the score increased by this feat) or take damage equal to 2d12 + your Constitution modifier.'),
    ('Boon of Fate', 19, 'Epic Boon Feat, Increase one ability score of your choice by 1, to a maximum of 30. When you or another creature within 60 feet of you succeeds on or fails a D20 Test, you can roll 2d4 and apply the total rolled as a bonus or penalty to the d20 roll. Once you use this benefit, you cant use it again until you roll Initiative or finish a Short or Long Rest.'),
    ('Boon of Fortitude', 19, 'Epic Boon Feat, Your Hit Point Maximum increases by 40. In addition, whenever you regain Hit Points, you regain additional Hit Points equal to your Constitution Modifier. You can regain these additional Hit Points no more than once per round.'),
    ('Boon of Irresistible Offense', 19, 'Epic Boon Feat, Increase your Strength or Dexterity score by 1, to a maximum of 30. The Bludgeoning, Piercing, and Slashing damage you deal always ignores Resistance. When you roll a 20 on the d20 for an attack roll, you can deal extra damage to the target equal to the ability score increased by this feat. The extra damages type is the same as the attacks type.'),
    ('Boon of Recovery', 19, 'Epic Boon Feat, Increase your Constitution score by 1, to a maximum of 30. When you would be reduced to 0 Hit Points, you can drop to 1 Hit Point instead and regain a number of Hit Points equal to half your Hit Point Maximum. Once you use this benefit, you cant use it again until you finish a Long Rest.When you take damage while you have 0 Hit Points, you can make a death saving throw instead of suffering a death saving throw failure.'),
    ('Boon of Skill', 19, 'Epic Boon Feat, You gain proficiency in all skills.'),
    ('Boon of Speed', 19, 'Epic Boon Feat, Increase your Dexterity score by 1, to a maximum of 30. As a Bonus Action, you can take the Disengage Action, which also ends the Grappled and Restrained conditions on you. Your Speed increases by 30 feet.'),
    ('Boon of Spell Recall', 19, 'Epic Boon Feat, Increase your Intelligence, Wisdom, or Charisma score by 1, to a maximum of 30. Whenever you cast a spell with a Spell Slot of 1st, 2nd, 3rd, or 4th level, roll a d4. If the number you roll equals the slots level, the slot isnt expended.'),
    ('Boon of the Night Spirit', 19, 'Epic Boon Feat, Increase one ability score of your choice by 1, to a maximum of 30. While within Dim Light or Darkness, you can give yourself the Invisible condition as a Bonus Action. The condition ends on you immediately after you take an action, a Bonus Action, or a Reaction. While within Dim Light or Darkness, you have Resistance to all damage except Psychic and Radiant.'),
    ('Boon of Truesight', 19, 'Epic Boon Feat,  Increase one ability score of your choice by 1, to a maximum of 30. You have Truesight within a range of 60 feet.'),
    ('Charger', 1, 'General Feat, Increase your Strength or Dexterity score by 1, to a maximum of 20. When you take the Dash Action, your Speed increases by 10 feet for that action. If you move at least 10 feet in a straight line toward a target immediately before hitting it with a melee attack roll as part of the Attack action, choose one of the following effects: gain a 1d8 bonus to the attacks damage roll, or push the target up to 10 feet away if it is no more than one size larger than you. You can use this benefit only once on each of your turns.'),
    ('Crafter', 1, 'Origin Feat,  You gain proficiency with three different Artisans Tools of your choice from the Fast Crafting table. Whenever you buy a nonmagical item, you receive a 20 percent discount on it. When you finish a Long Rest, you can craft one piece of gear from the Fast Crafting table, provided you have the Artisans Tools associated with that item and have proficiency with those tools. The item lasts until you finish another Long Rest, at which point the item falls apart.'),
    ('Crossbow Expert', 1, 'General Feat,  Increase your Dexterity score by 1, to a maximum of 20. You ignore the Loading property of the Hand Crossbow, Heavy Crossbow, and Light Crossbow (all called crossbows elsewhere in this feat). If youre holding one of them, you can load a piece of ammunition into it even if you lack a free hand. Being within 5 feet of an enemy doesnt impose Disadvantage on your attack rolls with crossbows. When you make the extra attack of the Light property, you can add your ability modifier to the damage of the extra attack if that attack is with a crossbow that has the Light property and you arent already adding that modifier to the damage.'),
    ('Defense', 1, 'Fighting Style Feat, While youre wearing Light, Medium, or Heavy armor, you gain a +1 bonus to Armor Class.'),
    ('Defensive Duelist', 1, 'General Feat, Increase your Dexterity score by 1, to a maximum of 20. If youre holding a Finesse weapon and another creature hits you with a melee attack, you can take a Reaction to add your Proficiency Bonus to your Armor Class, potentially causing the attack to miss you. You gain this bonus to your AC against melee attacks until the start of your next turn.'),
    ('Dual Wielder', 1, 'General Feat,  Increase your Strength or Dexterity score by 1, to a maximum of 20. When you take the Attack action on your turn and attack with a weapon that has the Light property, you can make one extra attack as a Bonus Action later on the same turn with a different weapon, which must be a Melee weapon that lacks the Two-Handed property. You dont add your ability modifier to the extra attacks damage unless that modifier is negative. You can draw or stow two weapons that lack the Two-Handed property when you would normally be able to draw or stow only one.'),
    ('Dueling', 1, 'Fighting Style Feat, When youre holding a Melee weapon in one hand and no other weapons, you gain a +2 bonus to damage rolls with that weapon.'),
    ('Durable', 1, 'General Feat,Increase your Constitution score by 1, to a maximum of 20. You have Advantage on Death Saving Throws. As a Bonus Action, you can expend one of your Hit Point Dice, roll the die, and regain a number of Hit Points equal to the roll.'),
    ('Elemental Adept', 1, 'General Feat,  Increase your Intelligence, Wisdom, or Charisma score by 1, to a maximum of 20. Choose one of the following damage types: Acid, Cold, Fire, Lightning, or Thunder. Spells you cast ignore Resistance to damage of the chosen type. In addition, when you roll damage for a spell you cast that deals damage of that type, you can treat any 1 on a damage die as a 2. You can take this feat more than once, but you must choose a different damage type each time for Energy Mastery.'),
    ('Grappler', 1, 'General Feat, Increase your Strength or Dexterity score by 1, to a maximum of 20. When you hit a creature with an Unarmed Strike as part of the Attack action on your turn, you can use both the Damage and the Grapple option. You can use this benefit only once per turn. You have Advantage on attack rolls against a creature Grappled by you. Your Speed isnt halved when you move a creature Grappled by you if the creature is your size or smaller.'),
    ('Great Weapon Fighting', 1, 'Fighting Style Feat, When you roll damage for an attack you make with a Melee weapon that you are holding with two hands, you can treat any 1 or 2 on a damage die as a 3. The weapon must have the Two-Handed or Versatile property to gain this benefit.'),
    ('Great Weapon Master', 1, 'General Feat, Increase your Strength score by 1, to a maximum of 20. When you hit a creature with a weapon that has the Heavy property as part of the Attack Action on your turn, you can cause the weapon to deal extra damage to the target. The extra damage equals your Proficiency Bonus. Immediately after you score a Critical Hit with a Melee weapon or reduce a creature to 0 Hit Points with one, you can make one attack with the same weapon as a Bonus Action.'),
    ('Healer', 1, 'Origin Feat,  If you have a Healers Kit, you can expend one use of it and tend to a creature within 5 feet of yourself as a Utilize action. That creature can expend one of its Hit Point Dice, and you then roll that die. The creature regains a number of Hit Points equal to the roll plus your Proficiency Bonus. Whenever you roll a die to determine the number of Hit Points you restore with a spell or with this feats Battle Medic benefit, you can reroll the die if it rolls a 1, and you must use the new roll.'),
    ('Heavy Armor Master', 1, 'General Feat, Increase your Constitution or Strength score by 1, to a maximum of 20. When youre hit by an attack while youre wearing Heavy armor, any Bludgeoning, Piercing, and Slashing damage dealt to you by that attack is reduced by an amount equal to your Proficiency Bonus.'),
    ('Inspiring Leader', 1, 'General Feat, Increase your Wisdom or Charisma score by 1, to a maximum of 20. When you finish a Short Rest or a Long Rest, you can give an inspiring performance: a speech, song, or dance. When you do so, choose up to six allies (which can include yourself) within 30 feet of yourself who witness the performance. The chosen creatures each gain Temporary Hit Points equal to your character level plus the modifier of the ability you increased with this feat.'),
    ('Interception', 1, 'Fighting Style Feat, When a creature you can see hits another creature within 5 feet of you with an attack roll, you can take a Reaction to reduce the damage dealt to the target by 1d10 plus your Proficiency Bonus. You must be holding a Shield or a Simple or Martial weapon to use this Reaction.'),
    ('Keen Mind', 1, 'General Feat, Increase your Intelligence score by 1, to a maximum of 20. Choose one of the following skills: Arcana, History, Investigation, Nature, or Religion. If you lack proficiency in the chosen skill, you gain proficiency in it, and if you already have proficiency in it, you gain Expertise in it. You can take the Study Action as a Bonus Action.'),
    ('Lucky', 1, 'Origin Feat, You have a number of Luck Points equal to your Proficiency Bonus and can spend the points on the benefits below. You regain your expended Luck Points when you finish a Long Rest. When you roll a d20 for a D20 Test, you can spend 1 Luck Point to give yourself Advantage on the roll. When a creature rolls a d20 for an attack roll against you, you can spend 1 Luck Point to impose Disadvantage on that roll.'),
    ('Mage Slayer', 1, 'General Feat, Increase your Strength or Dexterity score by 1, to a maximum of 20. When you damage a creature that is concentrating, it has Disadvantage on the saving throw it makes to maintain Concentration. If you fail an Intelligence, a Wisdom, or a Charisma saving throw, you can cause yourself to succeed instead. Once you use this benefit, you cant use it again until you finish a Short or Long Rest.'),
    ('Magic Initiate', 1, 'Origin Feat, You learn two cantrips of your choice from the Cleric, Druid, or Wizard spell list. Intelligence, Wisdom, or Charisma is your spellcasting ability for this feats spells (choose when you select this feat).Choose a level 1 spell from the same list you selected for this feats cantrips. You always have that spell prepared. You can cast it once without a spell slot, and you regain the ability to cast it in that way when you finish a Long Rest. You can also cast the spell using any spell slots you have. Whenever you gain a new level, you can replace one of the spells you chose for this feat with a different spell of the same level from the chosen spell list. You can take this feat more than once, but you must choose a different spell list each time.'),
    ('Musician', 1, 'Origin Feat, You gain proficiency with three Musical Instruments of your choice. As you finish a Short or Long Rest, you can play a song on a Musical Instrument with which you have proficiency and give Heroic Inspiration to allies who hear the song. The number of allies you can affect in this way equals your Proficiency Bonus.'),
    ('Observant', 1, 'General Feat,  Increase your Intelligence or Wisdom score by 1, to a maximum of 20.Choose one of the following skills: Insight, Investigation, or Perception. If you lack proficiency with the chosen skill, you gain proficiency in it, and if you already have proficiency in it, you gain Expertise in it.You can take the Search Action as a Bonus Action.'),
    ('Polearm Master', 1, 'General Feat, Increase your Dexterity or Strength score by 1, to a maximum of 20. Immediately after you take the Attack action and attack with a Quarterstaff, a Spear, or a weapon that has the Heavy and Reach properties, you can use a Bonus Action to make a melee attack with the opposite end of the weapon. The weapon deals Bludgeoning damage, and the weapons damage die for this attack is a d4. While youre holding a Quarterstaff, a Spear, or a weapon that has the Heavy and Reach properties, you can take a Reaction to make one melee attack against a creature that enters the reach you have with that weapon.'),
    ('Protection', 1, 'Fighting Style Feat, When a creature you can see attacks a target other than you that is within 5 feet of you, you can take a Reaction to interpose your Shield if youre holding one. You impose Disadvantage on the triggering attack roll and all other attack rolls against the target until the start of your next turn if you remain within 5 feet of the target.'), 
    ('Savage Attacker', 1, 'Origin Feat, Youve trained to deal particularly damaging strikes. Once per turn when you hit a target with a weapon, you can roll the weapons damage dice twice and use either roll against the target.'),
    ('Sentinel', 1, 'General Feat,  Increase your Strength or Dexterity score by 1, to a maximum of 20. Immediately after a creature within 5 feet of you takes the Disengage Action or hits a target other than you with an attack, you can make an Opportunity Attack against that creature. When you hit a creature with an Opportunity Attack, the creatures Speed becomes 0 for the rest of the current turn.'),
    ('Skilled', 1, 'Origin Feat, You gain proficiency in any combination of three skills or tools of your choice. You can take this feat more than once.'),
    ('Speedy', 1, 'General Feat, Increase your Dexterity or Constitution score by 1, to a maximum of 20. Your Speed increases by 10 feet. When you take the Dash action on your turn, Difficult Terrain doesnt cost you extra movement for the rest of that turn. Opportunity Attacks have Disadvantage against you.'),
    ('Thrown Weapon Fighting', 1, 'Fighting Style Feat, When you hit with a ranged attack roll using a weapon that has the Thrown property, you gain a +2 bonus to the damage roll.'),
    ('Tough', 1, 'Origin Feat, Your Hit Point maximum increases by an amount equal to twice your character level when you gain this feat. Whenever you gain a character level thereafter, your Hit Point maximum increases by an additional 2 Hit Points.'),
    ('Two-Weapon Fighting', 1, 'Fighting Style Feat, When you make an extra attack as a result of using a weapon that has the Light property, you can add your ability modifier to the damage of that attack if you arent already adding it to the damage.'),
    ('Unarmed Fighting', 1, 'Fighting Style Feat, When you hit with your Unarmed Strike and deal damage, you can deal Bludgeoning damage equal to 1d6 plus your Strength modifier instead of the normal damage of an Unarmed Strike. If you arent holding any weapons or a Shield when you make the attack roll, the d6 becomes a d8. At the start of each of your turns, you can deal 1d4 Bludgeoning damage to one creature Grappled by you.');
INSERT INTO Race (race_name, descript, speed, size) 
VALUES
    ('Human', 'Humans are versatile and adaptable, thriving in any environment with various cultural backgrounds.', 30, 'Medium'),
    ('High Elf', 'Elves from the high forests, known for their grace, intelligence, and affinity with magic.', 30, 'Medium'),
    ('Drow', 'Dark elves, with an affinity for magic and a complex culture steeped in shadow.', 30, 'Medium'),
    ('Wood Elf', 'Elves who live in forested areas, with a deep connection to nature and exceptional agility.', 35, 'Medium'),
    ('Dragonborn', 'Descendants of dragons, they have draconic heritage, breath weapons, and innate strength.', 30, 'Medium'),
    ('Dwarf', 'Short, stocky, and hardy, dwarves are known for their craftsmanship, resilience, and battle prowess.', 25, 'Medium'),
    ('Rock Gnome', 'Rock gnomes are inventive beings known for their mechanical genius, often living in underground dwellings or stone-crafted homes.', 25, 'Small'),
    ('Forest Gnome', 'Forest gnomes are small, curious beings, deeply connected to nature, and skilled in illusion magic, often living in wooded areas.', 25, 'Small'),
    ('Goliath', 'Tall, strong humanoids from mountainous regions, built for physical strength and endurance.', 30, 'Medium'),
    ('Halfling', 'Small, nimble, and courageous, halflings are often underestimated but capable adventurers.', 25, 'Small'),
    ('Orc', 'Orcs are strong, battle-hardened creatures with a fierce sense of honor and aggression.', 30, 'Medium'),
    ('Tiefling', 'Humanoid beings with infernal heritage, often marked by their horns, tails, and fiendish powers.', 30, 'Medium');

INSERT INTO AbilityByRace (race_id, lvlGainedAt, ability) 
VALUES
    (5, 1, 'Draconic Ancestry - Choose the kind of dragon for Breath Weapon and Damage Resistance traits.'),
    (5, 1, 'Breath Weapon - Exhale magical energy as a 15-foot cone or 30-foot line for 1d10 damage.'),
    (5, 1, 'Damage Resistance - Resistance to the damage type based on Draconic Ancestry.'),
    (5, 1, 'Darkvision - 60 feet range.'),
    (5, 5, 'Draconic Flight - Gain temporary flight as a Bonus Action for 10 minutes.'),
    (6, 1, 'Darkvision - 120 feet range.'),
    (6, 1, 'Dwarven Resilience - Resistance to Poison Damage and Advantage on saving throws to avoid Poisoned condition.'),
    (6, 1, 'Dwarven Toughness - Hit Point Maximum increases by 1 at 1st level and each level gained thereafter.'),
    (6, 1, 'Stonecunning - Tremorsense with 60-foot range when touching stone surfaces, usable a number of times equal to Proficiency Bonus.'),
    (6, 1, 'Darkvision - 60 feet range.'),
    (3, 1, 'Darkvision - 60 feet range.'),
    (3, 1, 'Fey Ancestry - Advantage on saving throws to avoid or end the Charmed Condition.'),
    (3, 1, 'Keen Senses - Proficiency in Insight, Perception, or Survival skill.'),
    (3, 1, 'Trance - Dont need sleep, can finish a Long Rest in 4 hours of trancelike meditation.'),
    (3, 1, 'Drow Lineage - Darkvision range increases to 120 feet, and you know the Dancing Lights cantrip.'),
    (3, 3, 'Drow Lineage - Can cast Faerie Fire once per long rest.'),
    (3, 5, 'Drow Lineage - Can cast Darkness once per long rest.'),
    (2, 1, 'Darkvision - 60 feet range.'),
    (2, 1, 'Fey Ancestry - Advantage on saving throws to avoid or end the Charmed Condition.'),
    (2, 1, 'Keen Senses - Proficiency in Insight, Perception, or Survival skill.'),
    (2, 1, 'Trance - Dont need sleep, can finish a Long Rest in 4 hours of trancelike meditation.'),
    (2, 1, 'High Elf Lineage - Know the Prestidigitation cantrip. Can replace it with another cantrip after each Long Rest.'),
    (2, 3, 'High Elf Lineage - Can cast Detect Magic once per long rest.'),
    (2, 5, 'High Elf Lineage - Can cast Misty Step once per long rest.'),
    (4, 1, 'Darkvision - 60 feet range.'),
    (4, 1, 'Fey Ancestry - Advantage on saving throws to avoid or end the Charmed Condition.'),
    (4, 1, 'Keen Senses - Proficiency in Insight, Perception, or Survival skill.'),
    (4, 1, 'Trance - Dont need sleep, can finish a Long Rest in 4 hours of trancelike meditation.'),
    (4, 1, 'Wood Elf Lineage - You know the Druidcraft cantrip.'),
    (4, 3, 'Wood Elf Lineage - You can cast Longstrider once per long rest.'),
    (4, 5, 'Wood Elf Lineage - Can cast Pass without Trace once per long rest.'),
    (7, 1, 'Darkvision - 60 feet range.'),
    (7, 1, 'Gnomish Cunning - Advantage on Intelligence, Wisdom, and Charisma saving throws.'),
    (7, 1, 'Rock Gnome Lineage - Know Mending and Prestidigitation cantrips.'),
    (7, 1, 'Rock Gnome Lineage - Create Tiny clockwork devices with Prestidigitation. Can have 3 devices at a time.'),
    (4, 1, 'Forest Gnome Lineage - Know the Minor Illusion cantrip. Can cast Speak with Animals using Proficiency Bonus.'),
    (4, 5, 'Forest Gnome Lineage - Speak with Animals (can be cast with Spell Slots).'),
    (8, 1, 'Darkvision - 60 feet range.'),
    (8, 1, 'Gnomish Cunning - Advantage on Intelligence, Wisdom, and Charisma saving throws.'),
    (1, 1, 'Resourceful - You gain Heroic Inspiration whenever you finish a Long Rest.'),
    (1, 1, 'Skillful - You gain Proficiency in one skill of your choice.'),
    (1, 1, 'Versatile - You gain an Origin feat of your choice.'),
    (9, 1, 'Natural Athlete - You have proficiency in the Athletics skill.'),
    (9, 1, 'Stones Endurance - You can use your reaction to roll a d12 and reduce damage by that total (Constitution modifier included). You regain this ability after a short or long rest.'),
    (9, 1, 'Powerful Build - You count as one size larger when determining carrying capacity and weight you can push, drag, or lift.'),
    (9, 1, 'Mountain Born - You have resistance to cold damage and are acclimated to high altitudes, including elevations above 20,000 feet.'),
    (10, 1, 'Brave - You have Advantage on saving throws to avoid or end the Frightened Condition.'),
    (10, 1, 'Halfling Nimbleness - You can move through the space of any creature that is larger than yours, but you cant stop in the same space.'),
    (10, 1, 'Luck - When you roll a 1 on the d20, you can reroll the die and must use the new roll.'),
    (10, 1, 'Naturally Stealthy - You can take the Hide action even when obscured by a creature that is at least one size larger than you.'),
    (11, 1, 'Adrenaline Rush - You can take the Dash Action as a Bonus Action. When you do, gain Temporary Hit Points equal to your Proficiency Bonus.'),
    (11, 1, 'Darkvision - You have Darkvision with a range of 120 feet.'),
    (11, 1, 'Relentless Endurance - When reduced to 0 HP but not killed, drop to 1 HP instead. You cant use this again until a Long Rest.'),
    (12, 1, 'Darkvision - You have Darkvision with a range of 60 feet.'),
    (12, 1, 'Fiendish Legacy - Choose a legacy from the Fiendish Legacies table. Gain level 1 benefit and additional spells at 3rd and 5th levels.'),
    (12, 1, 'Otherworldly Presence - You know the Thaumaturgy cantrip, using your Fiendish Legacy spellcasting ability.'),
    (12, 1, 'Abyssal Legacy - You have Resistance to Poison Damage, and know the Poison Spray cantrip.'),
    (12, 3, 'Abyssal Legacy  - You gain the Ray of Sickness spell, and it is always prepared.'),
    (12, 5, 'Abyssal Legacy - You gain the Hold Person spell, and it is always prepared.');


INSERT INTO Background (backgroundName, abilitiesImprovedOne, abilitiesImprovedTwo, abilitiesImprovedThree, descript, feat_id)
VALUES
    ('Acolyte', 'WIS', 'INT', 'CHA', 'A devout individual with spiritual knowledge and faith.', 38),
    ('Artisan', 'DEX', 'INT', 'STR', 'Skilled in crafting and creating objects with expertise.', 20),
    ('Charlatan', 'CHA', 'DEX', 'CON', 'A cunning individual skilled in deception and disguise.', 45),
    ('Criminal', 'DEX', 'CON', 'INT', 'An individual who thrives outside the law.', 3),
    ('Entertainer', 'CHA', 'DEX', 'STR', 'A performer who captivates audiences.', 39),
    ('Farmer', 'CON', 'STR', 'WIS', 'A hard-working individual familiar with agricultural life.', 48),
    ('Guard', 'STR', 'INT', 'WIS', 'A protector of people and places.', 3),
    ('Guide', 'WIS', 'DEX', 'CON', 'An experienced traveler skilled in navigation.', 38),
    ('Hermit', 'WIS', 'CON', 'CHA', 'A secluded individual with unique insights.', 31),
    ('Merchant', 'CHA', 'INT', 'CON', 'A savvy businessperson skilled in trade.', 36),
    ('Noble', 'CHA', 'STR', 'INT', 'A person of noble birth with wealth and influence.', 45),
    ('Sage', 'INT', 'WIS', 'CON', 'A scholar dedicated to knowledge and wisdom.', 38),
    ('Sailor', 'STR', 'DEX', 'WIS', 'A seasoned navigator of the seas.', 45),
    ('Scribe', 'INT', 'WIS', 'DEX', 'A meticulous writer with great knowledge.', 45),
    ('Soldier', 'STR', 'CON', 'DEX', 'A disciplined warrior trained for battle.', 43),
    ('Wayfarer', 'DEX', 'WIS', 'CHA', 'A wanderer familiar with roads and nature.', 36);




