# Ch 3: SQL for SQLite

DDL - data definition language
DML - data manipulation language

create temp - temporary tables is deleted after disconnection

native types
* integer
* real 
* text
* blob
* null

output of any select statement can be fed as input to another select statement
similar to unix piping

* select operates thru a series of clauses: from/where/having/...
SELECT [DISTINCT] heading
FROM tables
WHERE predicate
GROUP BY cols
HAVING predicate
ORDER BY cols
LIMIT count,offset;


## Filtering
**where** filters by row

**like** operator matches strings **like 'J%'**

* % - matches zero or more characters in the string
* _ - matches any single character

**glob** operates like unix globbing

## Functions and Aggregations

