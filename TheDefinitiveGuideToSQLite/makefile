
test: test.sql
	sqlite3 food.db < $<

food.db: ./code/ch01/examples/foods.sql
	sqlite3 $@ < $<
