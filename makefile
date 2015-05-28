DB=test.db

all: test.db

rebuild: clean test.db

test.db:
	sqlite3 -bail -echo test.db < cmd.sql 

clean:
	rm test.db

backup:
	sqlite3 ${DB} .dump > dump.sql

restore:
	sqlite3 -init dump.sql ${DB} .exit
