DROP DATABASE IF EXISTS dnd;
CREATE DATABASE dnd;
GRANT ALL PRIVILEGES ON dnd.* TO 'django'@'localhost' WITH GRANT OPTION;
USE dnd;
CREATE TABLE Character_Class (
    character_id int,
    character_name varchar(255),
    STR int(2),
    DEX int(2),
    CON int(2),
    INTE int(2),
    WIS int(2),
    CHA int(2)

);

INSERT INTO Character_Class(character_id, character_name, STR,DEX,CON,INTE,WIS,CHA) VALUES
(1, 'Theo Hawthorne', 8,14,16,20,16,10);