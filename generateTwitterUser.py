import psycopg2
import random
from genDescription import generateDescription
from genTimestamp import generateTime


# def connect():
# 	conn = psycopg2.connect(database="spasms", user="postgres", password="1514729", host="/var/run/postgresql", port="5432")
# 	print("Connected to database: spasms")

	
# 	return conn

#following line for picking between male and female name
#cur.execute("SELECT COUNT(*) FROM names")

#cur is a connection to the database
#groupName is the group of the individuals created
#gender_type takes in a argument of 'first_m' or 'first_f' and is the gender of the individuals crated
def createTwitterUser(cur,groupName,gender_type):

	if gender_type == 'm':
		gender = 'first_m'
	else:
		gender = 'first_f'

	cur.execute("SELECT count(*) from names where name_type='"+gender+"'")
	firstNamesNum = cur.fetchone()[0]

	randFirstName = random.randrange(0,firstNamesNum,1)

	cur.execute("SELECT name,name_type from names where name_type='"+gender+"'")
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

	description = generateDescription(10)
	
	start = '2000-01-01 12:00:00';
	end = '2019-11-07 12:00:00';

	# if gender_type == 'first_m':
	# 	gender = 'm'
	# else:
	# 	gender = 'f'

	tupleTwitterUser = (randId,randIdStr,twitter_name,twitter_screen_name,randomLocation,generateTime(start,end),followerCount,favouritesCount,statusesCount,description,gender_type,groupName) 
	return tupleTwitterUser



def insertTwitterUsers(cur,groupName,numUsers,gender_type):
	#add exception handling here	
#	howManyUsers = int(raw_input('Enter how many users you want: '))
#	outputFileName = raw_input('Enter output file name: ')
	
#	outputFile = open(outputFileName,'w')	

	#conn = connect()
	#cur = conn.cursor()


	for i in range(numUsers):
	
		twitterUser = createTwitterUser(cur,groupName,gender_type)
								
		cur.execute("INSERT INTO twitter_users (id,id_str,name,screen_name,location,created_at,followers,favourites,statuses,description,gender,group_name) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",twitterUser)
	
	#conn.commit()				
		

# conn = connect()
# cur = conn.cursor()
#createTwitterUser(cur,"red","first_f")
# insertTwitterUsers("American",3,"first_f")
# conn.close()
# print("Database connection closed")
