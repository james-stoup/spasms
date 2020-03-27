import psycopg2
import random

from random import seed
from random import randint
from genDescription import generateDescription
from genTimestamp import generateTime
import sys


def grab_data(cur, statement_1, statement_2):
    try:
        cur.execute(statement_1)
        firstRow = cur.fetchone()[0]
        randVal = random.randrange(0, firstRow, 1)

        cur.execute(statement_2)
        rows = cur.fetchall()
        result = rows[randVal][0]

        return result
    except Exception as e:
        print("Error while trying to execute SQL query: %s"%e)
        sys.exit(0)


# cur is a connection to the database
# groupName is the group of the individuals created
# gender_type takes in a argument of 'm' or 'f' and is the gender of the individuals crated
def createTwitterUser(cur, groupName, gender_type, startDate, endDate):
    gender = "first_f"
    if gender_type == "m":
        gender = "first_m"

    # first name
    str_1 = "SELECT count(*) from names where name_type='" + gender + "'"
    str_2 = "SELECT name, name_type from names where name_type='" + gender + "'"
    firstName = grab_data(cur, str_1, str_2)

    # last name
    str_1 = "Select count(*) from names where Name_type='last'"
    str_2 = "SELECT name from names where Name_type='last'"
    lastName = grab_data(cur, str_1, str_2)

    # location
    str_1 = "SELECT COUNT(*) from Locations where Country='United States'"
    str_2 = "SELECT city from Locations where Country='United States'"
    randomLocation = grab_data(cur, str_1, str_2)

    # twitter real name
    twitter_name = firstName + " " + lastName

    # twitter screen name
    firstLetter = firstName[0]
    lastName = lastName.lower()
    twitter_screen_name = firstLetter + lastName

    ### NOTES ###
    ###
    ### Maybe consider adding an option to randomize the twitter handles
    ### so that everyone isn't the same "first initial last name" pattern?
    ### Here is an example of what I mean.
    ###
    ### !!! Oh, you need to alter the table so the screen_name is more than 15 chars
    ### like so:
    ### alter table twitter_users alter COLUMN screen_name type character varying(100);
    ###

    colors = [
        "blue",
        "black",
        "green",
        "yellow",
        "red",
        "white",
        "teal",
        "orange",
        "lilac",
        "neon",
        "clear",
    ]
    adjs = [
        "avenging",
        "strident",
        "lucky",
        "sexy",
        "funky",
        "dancing",
        "weaving",
        "somnombulating",
    ]
    critters = [
        "angel",
        "dog",
        "whale",
        "shield",
        "sword",
        "knight",
        "pony",
        "snake",
        "salesman",
        "cat",
    ]
    name_modifiers = [colors, adjs]

    value = randint(0, 100)
    if value > 60:  # 40% of the time make a random user name
        coin = randint(0, 1)
        modifier_list = name_modifiers[coin]  # pick a color or an adjective
        first = random.choice(modifier_list)  # pick a value from the list
        second = random.choice(critters)  # pick a noun
        third = randint(0, 100)  # and for good measure, pick a number
        twitter_screen_name = "%s_%s%s" % (first, second, third)

    # would like to make this a choice between 3 numbers such as 10,  10000,  100000
    randomVal = 10000
    userCount = []

    for i in range(4):
        randNum = random.randrange(0, randomVal, 1)
        userCount.append(randNum)

    followerCount = userCount[0]
    # friendsCount = userCount[1]
    favouritesCount = userCount[2]
    statusesCount = userCount[3]
    # only goes up to 7 characters
    randomIdVal = 100000000
    randId = random.randrange(0, randomIdVal, 1)
    randIdStr = str(randId)

    randAge = randint(18,80)

    description = generateDescription(10)

    start = startDate + " 12:00:00"
    end = endDate + " 12:00:00"
    # start = '2000-01-01 12:00:00';
    # end = '2019-11-07 12:00:00';

    '''
    tupleTwitterUser = (
        randId,
        randIdStr,
        twitter_name,
        twitter_screen_name,
        randomLocation,
        generateTime(start, end),
        followerCount,
        favouritesCount,
        statusesCount,
        description,
        gender_type,
        groupName,
    )
    '''

    query = "SELECT id FROM spasms_exercise WHERE name='"+groupName+"'"
    print("group name = "+groupName)
    try:
        cur.execute(query)
        exercise_id = cur.fetchone()[0]
    except Exception as e:
        print("Error while trying to execute SQL query: %s"%e)
        sys.exit(0)

    tupleTwitterUser = (
        randId,
        twitter_screen_name,
        firstName,
        lastName,
        gender_type,
        randAge,
        'United States',
        randomLocation,
        'eng',
        exercise_id,
        generateTime(start, end),
        description,
        favouritesCount,
        followerCount,
        statusesCount
    )

    return tupleTwitterUser


def insertTwitterUsers(cur, groupName, numUsers, gender_type, startDate, endDate):

    # if there are no users, just bail
    if numUsers < 1:
        return

    # add exception handling here
    # 	howManyUsers = int(raw_input('Enter how many users you want: '))
    # 	outputFileName = raw_input('Enter output file name: ')

    # 	outputFile = open(outputFileName, 'w')

    # conn = connect()
    # cur = conn.cursor()

    for i in range(numUsers):
        twitterUser = createTwitterUser(cur, groupName, gender_type, startDate, endDate)

        try:
            cur.execute(
                "INSERT INTO spasms_twitteruser (id,screen_name,first_name,last_name,gender,age,country,province,language,exercise_id,created_at,description,favourites,followers,statuses) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                twitterUser,
            )
            '''
            cur.execute(
                "INSERT INTO twitter_users (id, id_str, name, screen_name, location, created_at, followers, favourites, statuses, description, gender, group_name) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                twitterUser,
            )
            '''
        except Exception as e:
            print("Unable to insert into twitter_users : %s" % e)

    # conn.commit()


# conn = connect()
# cur = conn.cursor()
# createTwitterUser(cur, "red", "first_f")
# insertTwitterUsers("American", 3, "first_f")
# conn.close()
# print("Database connection closed")
