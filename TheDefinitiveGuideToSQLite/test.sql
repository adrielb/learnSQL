.mode column
.headers on
.nullvalue NULL
.echo on

select * 
from foods
where name='JujyFruit'
and type_id=9;

select f.name name, types.name type
from foods f
inner join (
  select *
  from food_types
  where id=6) types
on f.type_id=types.id;
