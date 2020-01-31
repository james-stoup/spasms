import psycopg2
import sys

db_name = "spasms";
try:
	conn = psycopg2.connect(
		database=db_name,
		user="postgres",
		password="1514729",
		host="/var/run/postgresql",
		port="5432",
	)
except:
	print("Unable to connect to database, ensure that postgres is running")
	sys.exit(1)

curr = conn.cursor();

query1 = "SELECT * from words WHERE word=%s AND type=%s";
query2 = "INSERT INTO common_words VALUES (%s,%s,%s)";

filename = input("Enter file name: ");
inputFile = open(filename,"r");
wordType = input("Enter word type: ");

count = 0;
for line in inputFile.readlines():
	word = line.rstrip().lower();
	curr.execute(query1,(word,wordType));
	matches = curr.fetchall();
	if len(matches) > 0:
		curr.execute(query2,(matches[0][0],matches[0][1],matches[0][2]));
		count = count + 1;

conn.commit();
print(str(count)+" words inserted!");	
