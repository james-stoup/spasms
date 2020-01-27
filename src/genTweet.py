import psycopg2;
import random;
from genTimestamp import generateTime;
from sentenceGenerator import generateSentence;
import pdb
def genTweet(cursor, group, noun, sentiment, topic, numOfTweets):
	cursor.execute("SELECT * FROM Twitter_users WHERE group_name=%s", (group,));
	numUsers = cursor.rowcount;
	users = cursor.fetchall();

	for x in range(numOfTweets):
		i = random.randint(1,numUsers);
		userId = users[i-1][0];
		createdAt = users[i-1][4];
		randTime = generateTime(str(createdAt),'2019-11-15 03:00:00');
		text = generateSentence(cursor,noun,sentiment);
		randId = random.randint(0,999999999);
		randIdStr = str(randId);
		#add leading 0's to make the id a string of 19 characters
		randIdStr = "0"*(19-len(randIdStr)) + randIdStr;
		lang = "en";

		try:
			cursor.execute("INSERT INTO Twitter_posts (user_id,id,id_str,created_at,text,topic,language) VALUES (%s,%s,%s,%s,%s,%s,%s)",(userId,randId,randIdStr,randTime,text,topic,lang));
		except Exception as e:
			print("Unable to insert into twitter_posts table : %s" % e)
		
	return (userId, randId, randIdStr, randTime, text);


