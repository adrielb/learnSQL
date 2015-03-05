all: test.db

rebuild: clean test.db

test.db:
	sqlite3 -bail -echo test.db < cmd.sql 

clean:
	rm test.db

