sqlite3 food.db
.mode column
.headers on
.schema

select * from episodes order by name limit 10;

select name from 
(
        select name, type_id from 
        (
                select * from foods
        )
);

select id, name from food_types;

select * from food_types;

select 1 > 2;

select * from foods where name='JujyFruit' and type_id=9;

select id, name from foods where name like 'J%';

select id, name from foods where name like '%ac%P%';

select id, name from foods where name like '%ac%P%' and 
name not like '%Sch%';

select id, name from foods where name glob 'Pine*';

select * from food_types order by id limit 1 offset 1;

select * from foods where name like 'B%'
        order by type_id desc, name limit 10;

select upper("hello newman"), length("hello newman"), abs(-12);

select id, upper(name), length(name) from foods where type_id=1 limit 10;

select id, upper(name), length(name) from foods where length(name) < 5 limit 5;

select count(*) from foods where type_id=1;

select count(*) from foods;

select avg(length(name)) from foods;

select avg(length(name)) from foods where type_id=1;

select type_id from foods group by type_id;

select type_id, count(*) from foods group by type_id;

select count(*) from foods where type_id=1;
select count(*) from foods where type_id=2;

select type_id, count(*) from foods group by type_id having count(*) > 20;

select type_id, count(*) from foods;

select distinct type_id from foods;

