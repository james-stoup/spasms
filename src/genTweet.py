import psycopg2

import random
from genTimestamp import generateTime
from sentenceGenerator import generateSentence
import pdb


def genTweet(cursor, runName, group, noun, sentiment, numOfTweets, startDate, endDate):
    cursor.execute("SELECT id FROM spasms_tweetrun WHERE label=%s", (runName,))
    tweetRunId = cursor.fetchone()[0]
    cursor.execute("SELECT id FROM spasms_group WHERE name=%s", (group,))
    groupId = cursor.fetchone()[0]
    cursor.execute("SELECT * FROM spasms_twitteruser WHERE group_id=%s", (groupId,))
    numUsers = cursor.rowcount
    users = cursor.fetchall()

    for x in range(numOfTweets):
        i = random.randint(1, numUsers)
        userId = users[i - 1][0]
        # createdAt = users[i - 1][4]
        date1 = startDate + " 12:00:00"
        date2 = endDate + " 12:00:00"
        # randTime = generateTime(str(createdAt), "2019-11-15 03:00:00")
        creationTime = generateTime(date1, date2)
        text = generateSentence(cursor, noun, sentiment)
        # randId = random.randint(0, 999999999)
        # randIdStr = str(randId)
        # add leading 0's to make the id a string of 19 characters
        # randIdStr = "0" * (19 - len(randIdStr)) + randIdStr
        # lang = "en"

        try:
            # cursor.execute(
            #     "INSERT INTO Twitter_posts (user_id,id,id_str,created_at,text,topic,language) VALUES (%s,%s,%s,%s,%s,%s,%s)",
            #     (userId, randId, randIdStr, randTime, text, topic, lang),
            # )
            cursor.execute(
                "INSERT INTO spasms_tweet (author_id, run_id, text, creation_time) VALUES (%s, %s, %s, %s)",
                (userId, tweetRunId, text, creationTime),
            )
        except Exception as e:
            print("Unable to insert into spasms_tweet table : %s" % e)

    #return (userId, randId, randIdStr, randTime, text)
