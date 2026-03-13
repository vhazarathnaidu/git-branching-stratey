import sqlite3

con = sqlite3.connect("test.db")
cur = con.cursor()

cur.execute("CREATE TABLE IF NOT EXISTS student(id INT, name TEXT)")
cur.execute("INSERT INTO student VALUES(1,'Venkatesh')")

cur.execute("SELECT * FROM student")
print(cur.fetchall())

con.close()