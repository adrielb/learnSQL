
sqlite3 -header -column -bail test.db
.schema

.headers ON
.mode column


/* Exercise 0 */
sqlite3 test.db

CREATE TABLE test (id);

.quit


/* Exercise 1 */

CREATE TABLE person (
        id INTEGER PRIMARY KEY,
        first_name TEXT,
        last_name TEXT,
        age INTEGER
);


/* Exercise 2 */ 

sqlite3 ex2.db

CREATE TABLE person (
        id INTEGER PRIMARY KEY,
        first_name TEXT,
        last_name TEXT,
        age INTEGER
);

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

CREATE TABLE cars (
        id INTEGER PRIMARY KEY,
        make TEXT,
        model TEXT,
        year TEXT
);

CREATE TABLE person_cars (
        person_id INTEGER,
        car_id INTEGER
);

.schema


/* Exercise 3 */ 

INSERT INTO person (id, first_name, last_name, age)
        VALUES (0, "Zed", "Shaw", 37);

INSERT INTO pet (id, name, breed, age, dead)
        VALUES (0, "Fluffy", "Unicorn", 1000, 0);

INSERT INTO pet VALUES (1, "Gigantor", "Robot", 1, 1);

INSERT INTO person (id, first_name, last_name, age)
        VALUES (1, "Tom", "Ron", 100); 

/* 4: Referential Data */ 

INSERT INTO person_pet (person_id, pet_id) values (0,0);

INSERT INTO person_pet values (0, 1);

INSERT INTO person_pet (person_id, pet_id) values (0,1);


/* 5: Selecting Data */

SELECT * FROM person;

SELECT * FROM pet;

SELECT * FROM person_pet;

SELECT name, age FROM pet;

SELECT name, age FROM pet WHERE dead=0;

SELECT * FROM person WHERE first_name != "Zed";

SELECT * FROM pet WHERE age > 10;

SELECT * FROM person WHERE age > 50;
SELECT * FROM person WHERE age < 50;

SELECT * FROM person WHERE first_name='Zed' and age > 30;

/* 6: Select across many tables */
.headers ON
.mode column

SELECT pet.id, pet.name, pet.age, pet.dead
        FROM pet, person_pet, person
        WHERE
        person_pet.pet_id = pet.id AND
        person_pet.person_id = person.id AND
        person.first_name = 'Zed';

/* 7: Deleting Data */

SELECT name, age FROM pet WHERE dead = 1;

DELETE FROM pet WHERE dead = 1;

SELECT * FROM pet;

INSERT INTO pet (id, name, breed, age, dead)
        VALUES (1, 'Gigantor', 'Robot', 1, 0); 

SELECT * FROM pet;

DELETE FROM person_pet WHERE person_id=0 AND pet_id=1 LIMIT 1;

DROP TABLE person_pet; 

.schema

/* 8: Deleting using other tables */

DELETE FROM pet WHERE id IN (
        SELECT pet.id
        FROM pet, person_pet, person
        WHERE 
        person_pet.person_id = person.id AND
        person_pet.pet_id = pet.id AND
        person.first_name = 'Zed'
);

SELECT * FROM pet;
SELECT * FROM person_pet;

DELETE FROM person_pet 
        WHERE pet_id NOT IN (
                SELECT id FROM pet
        );
SELECT * FROM person_pet;

SELECT * FROM pet;
SELECT * FROM person_pet;
SELECT * FROM person;

/* Delete any dead pets owned by you */ 
DELETE FROM pet WHERE id in (
        SELECT pet.id 
        FROM pet, person_pet, person
        WHERE
        person_pet.person_id = person.id AND
        person_pet.pet_id = pet.id AND
        pet.dead=1 AND
        person.first_name = 'Me'
);
SELECT * FROM pet;

/* Delete people who have dead pets */
DELETE FROM person WHERE id IN (
        SELECT person.id
        FROM pet, person_pet, person
        WHERE 
        person_pet.person_id = person.id AND
        person_pet.pet_id = pet.id AND
        pet.dead = 1
);
SELECT * FROM person;

/* Remove dead pets from link table */
SELECT * FROM person_pet;
DELETE FROM person_pet WHERE pet_id IN (
        SELECT id
        FROM pet
        WHERE
        pet.dead = 1
);
SELECT * FROM person_pet;

/* 9: Updating Data */
SELECT * FROM person;
SELECT * FROM pet;

UPDATE person 
SET first_name = "Hilarious Guy"
WHERE first_name = "Zed";

UPDATE pet 
SET name = "Facny pants"
WHERE id = 0;

UPDATE person 
SET first_name = "Zed"
WHERE first_name = "Hilarious Guy";

UPDATE pet
SET name = "DECEASED"
WHERE dead = 1;

UPDATE person 
SET age = 10
WHERE id IN (
        SELECT person.id
        FROM person, person_pet, pet
        WHERE
        person_pet.person_id = person.id AND
        person_pet.pet_id = pet.id AND
        pet.dead = 1
);

/* 10: Updating Complex Data */
SELECT * FROM pet;

UPDATE pet 
SET name = "Zed's Pet"
WHERE id IN (
        SELECT pet.id
        FROM pet, person_pet, person
        WHERE 
        person_pet.person_id = person.id AND
        person_pet.pet_id = pet.id AND
        person.first_name = "Zed"
);
SELECT * FROM pet;

/* rename dead pets */
UPDATE pet 
SET name = "Zed's DEAD Pet"
WHERE id IN (
        SELECT pet.id
        FROM pet, person_pet, person
        WHERE 
        person_pet.person_id = person.id AND
        person_pet.pet_id = pet.id AND
        pet.dead = 1 AND
        person.first_name = 'Zed'
);
SELECT * FROM pet;


/* 11: Replacing Data */
/* update without transactions */
INSERT INTO person (id, first_name, last_name, age) VALUES
        ( 0, 'Frank', 'Smith', 100);

INSERT OR REPLACE INTO person (id, first_name, last_name, age) VALUES
        ( 0, 'Frank', 'Smith', 100);

SELECT * FROM person;

REPLACE INTO person (id, first_name, last_name, age) VALUES
        ( 0,  'Zed', 'Shaw', 37);

SELECT * FROM pet;

REPLACE INTO pet (id, name, breed, age, dead) VALUES
        (0, 'peeky', "Parrot", 10, 0);

/* 12: Destroying and Altering Tables */
DROP TABLE IF EXISTS person;

.schema

CREATE TABLE person (
        id INTEGER PRIMARY KEY,
        first_name TEXT,
        last_name TEXT,
        age INTEGER
);

ALTER TABLE person RENAME TO peoples;

ALTER TABLE peoples ADD COLUMN hatred INTEGER;

ALTER TABLE peoples RENAME TO person;

.schema person

DROP TABLE person;

/* 13: Migrating and Evolving Data */
ALTER TABLE person ADD COLUMN dead INTEGER;

ALTER TABLE person ADD COLUMN phone_number TEXT;

ALTER TABLE person ADD COLUMN salary FLOAT;

ALTER TABLE person ADD COLUMN dob DATETIME;
ALTER TABLE pet    ADD COLUMN dob DATETIME;

ALTER TABLE person_pet ADD COLUMN purchased_on DATETIME;

ALTER TABLE pet ADD COLUMN parent INTEGER;

.schema 

SELECT * FROM person;

UPDATE person SET 
dead = 0,
phone_number = '123-345-6789',
salary = 10000,
dob = 'March 20, 2011'
WHERE id = 0;

UPDATE person SET 
dead = 0,
phone_number = '345-312-6789',
salary = 20000,
dob = 'April 20, 2011'
WHERE id = 1;

UPDATE person SET 
dead = 0,
phone_number = '890-345-6789',
salary = 40002,
dob = 'Jan 20, 2011'
WHERE id = 2;

SELECT * FROM pet;

UPDATE pet SET dob = 'Feb 3, 2000', parent = 1 WHERE id = 0; 
UPDATE pet SET dob = 'Feb 3, 2000', parent = NULL WHERE id = 1;
UPDATE pet SET dob = 'Feb 3, 2000', parent = 1 WHERE id = 2;

