

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
