import psycopg2
import random

conn = psycopg2.connect(database="spasms", user="postgres", password="PASSWORD", host="/var/run/postgresql", port="5432")
print("Connected to database: spasms")

cur = conn.cursor()

#following line for picking between male and female name
#cur.execute("SELECT COUNT(*) FROM names")

cur.execute("SELECT count(*) from names where name_type='first_m' or name_type='first_f'")
firstNamesNum = cur.fetchone()[0]
#print(firstNamesNum)

randFirstName = random.randrange(0,firstNamesNum,1)

cur.execute("SELECT name from names where name_type='first_m' or name_type='first_f'")
firstNames = cur.fetchall()

firstName = firstNames[randFirstName][0]
firstLetter = firstName[0]

cur.execute("Select count(*) from names where Name_type='last'")
lastNamesNum = cur.fetchone()[0]

randLastName = random.randrange(0,lastNamesNum,1)

cur.execute("SELECT name from names where Name_type='last'")
lastNames = cur.fetchall()

lastName = lastNames[randLastName][0]

cur.execute("SELECT COUNT(*) from Locations where Country='United States'")
locationsNum = cur.fetchone()[0]
#print(locationsNum)

randLocation = random.randrange(0,locationsNum,1)


cur.execute("SELECT city from Locations where Country='United States'")
locations = cur.fetchall()
randomLocation = locations[randLocation][0]
#print(randomLocation)



twitter_name = firstName +" "+ lastName
lastName = lastName.lower()
twitter_screen_name = firstLetter + lastName
#set language to english for right now, come back and add multiple options later
lang = "eng"

#would like to make this a choice between 3 numbers such as 10, 10000, 100000
randomVal = 10000
userCount = []

for i in range(4):
	randNum = random.randrange(0,randomVal,1)
	userCount.append(randNum)

followerCount = userCount[0]
friendsCount = userCount[1]
favouritesCount = userCount[2]
statusesCount =userCount[3]
#only goes up to 7 characters
randomIdVal = 10000000
randId= random.randrange(0,randomIdVal,1)
randIdStr = str(randId)



tupleTwitterUser = (twitter_screen_name,twitter_name,followerCount,friendsCount,favouritesCount,statusesCount,randId,randIdStr,lang,randomLocation) 

print(tupleTwitterUser)

#cur.execute("SELECT COUNT(*) FROM sentence_frags")
#sentFragNum = cur.fetchone()[0]
#print(sentFragNum)



#randNum = random.randrange(0, sentFragNum, 1)
#print(randNum)

#cur.execute("SELECT fragment FROM sentence_frags")
#frag = cur.fetchall()
#frag = frag[randNum][0]
#print(frag)

#cur.execute("SELECT word FROM words WHERE (sentiment < 0) and (type = 'adjective')")
#numOfAdjectives = cur.rowcount
#print(numOfAdjectives)
#adjectives = cur.fetchall()


cur.close()
conn.close()
print("Database connection closed")
