import psycopg2
import random

noun = "Trump"

conn = psycopg2.connect(database="spasms", user="postgres", password="postgres", host="/var/run/postgresql", port="5432")
print("Connected to database: spasms")

cur = conn.cursor()

cur.execute("SELECT COUNT(*) FROM sentence_frags")
sentFragNum = cur.fetchone()[0]
print(sentFragNum)

randNum = random.randrange(0, sentFragNum, 1)
print(randNum)

cur.execute("SELECT fragment FROM sentence_frags")
frag = cur.fetchall()
frag = frag[randNum][0]
print(frag)

cur.execute("SELECT word FROM words WHERE (sentiment < 0) and (type = 'adjective')")
numOfAdjectives = cur.rowcount
print(numOfAdjectives)
adjectives = cur.fetchall()

fragSplit = frag.split(" ")
print(fragSplit)
for x in range(len(fragSplit)):
	if fragSplit[x] == '<noun>':
		print(x)
		fragSplit[x] = noun
	elif fragSplit[x] == '<adjective>':
		print(x)
		randAdjNum = random.randrange(0, numOfAdjectives, 1)
		fragSplit[x] = adjectives[randAdjNum][0]

fragJoin = " ".join(fragSplit)
print(fragJoin)


cur.close()
conn.close()
print("Database connection closed")
