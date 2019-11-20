import psycopg2
import random
from genDescription import generateDescription
from genTimestamp import generate_time


def connect():
	conn = psycopg2.connect(database="spasms", user="postgres", password="1514729", host="/var/run/postgresql", port="5432")
	print("Connected to database: spasms")

	
	return conn

#following line for picking between male and female name
#cur.execute("SELECT COUNT(*) FROM names")

def create_twitter_user(cur):


	cur.execute("SELECT count(*) from names where name_type='first_m' or name_type='first_f'")
	firstNamesNum = cur.fetchone()[0]

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
	#friendsCount = userCount[1]
	favouritesCount = userCount[2]
	statusesCount =userCount[3]
#only goes up to 7 characters
	randomIdVal = 100000000
	randId= random.randrange(0,randomIdVal,1)
	randIdStr = str(randId)

	description = generateDescription(25)

	tupleTwitterUser = (randId,randIdStr,twitter_name,twitter_screen_name,randomLocation,generate_time(),followerCount,favouritesCount,statusesCount,description,lang,'m','----') 
	return tupleTwitterUser



def insert_twitter_users():
	#add exception handling here	
#	howManyUsers = int(raw_input('Enter how many users you want: '))
#	outputFileName = raw_input('Enter output file name: ')
	
#	outputFile = open(outputFileName,'w')	

	conn = connect()
	cur = conn.cursor()


	for i in range(2):
	
		twitterUser = create_twitter_user(cur)
								
		cur.execute("INSERT INTO twitter_users (id,id_str,name,screen_name,location,created_at,followers,favourites,statuses,description,language,gender,group_name) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",twitterUser)
	
	conn.commit()				
		

conn = connect()
cur = conn.cursor()
#val = create_twitter_user(conn)
#val2 = create_twitter_user(conn)

insert_twitter_users()
#print(val)
#print(val[0])
#print(val2)

#insert_twitter_users()

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


conn.close()
print("Database connection closed")