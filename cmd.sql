DROP TABLE IF EXISTS pet;
DROP TABLE IF EXISTS person_pet;
DROP TABLE IF EXISTS person;

CREATE TABLE pet (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT,
        age INTEGER,
        dead INTEGER
);

CREATE TABLE person_pet (
        person_id INTEGER,
        pet_id INTEGER
);

CREATE TABLE person (
	id INTEGER PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	age INTEGER,
	address TEXT,
	ip INTEGER
);

INSERT INTO person (id, first_name, last_name, age) VALUES
        (0, "Zed", "Shaw", 37),
        (1, "Tom", "Ron", 100),
        (2, "Me", "Too", 22); 

INSERT INTO pet (id, name, breed, age, dead) VALUES 
        (0, "Fluffy", "Unicorn", 1000, 0), 
        (1, "Gigantor", "Robot", 1, 1),
        (2, "Goldy", "Fish", 1, 1);

INSERT INTO person_pet (person_id, pet_id) values (0,0);
INSERT INTO person_pet (person_id, pet_id) values (0,1);
INSERT INTO person_pet (person_id, pet_id) values (2,2);

ALTER TABLE person ADD COLUMN height INTEGER;
ALTER TABLE person ADD COLUMN weight INTEGER;
