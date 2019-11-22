import json;

def exportTweets(cursor, topic, fileName):
	data = [];
	data.append({
		"created_at": "2019-11-20 03:00:00",
		"id": 123456789,
		"id_str": "123456789",
		"text": "My name is Bob",
		"user": {
			"id": 1,
			"name": "Bob"
		}
	});
	data.append({
		"created_at": "2019-11-20 03:30:00",
		"id": 549861901,
		"id_str": "111111111",
		"text": "My name is Jane",
		"user": {
			"id":2,
			"name":"Jane"
		}
	});
	cursor.execute("SELECT * FROM Twitter_posts WHERE topic=%s",(topic,));
	twitterData = [];
	tweets = cursor.fetchall();
	for tweet in tweets:
		userId = int(tweet[0]);
		cursor.execute("SELECT * FROM Twitter_users WHERE id=%s",(userId,));
		user = cursor.fetchone();
		twitterData.append({
			"created_at": str(tweet[3]),
			"id": int(tweet[1]),
			"id_str": tweet[2],
			"text": tweet[4],
			"entities": {
				"hashtags": [],
				"urls": [],
				"user_mentions": [],
				"symbols": []
			},
			"lang":"en",
			"user": {
				"id": userId,
				"id_str": user[1],
				"name": user[12],
				"screen_name": user[2],
				"location": user[3],
				"created_at": str(user[4]),
				"followers_count": int(user[5]),
				"favourites_count": int(user[6]),
				"statuses_count": int(user[7]),
				"description": user[8]
			}
		});
	outputFile = open(fileName,"w");
	json.dump(twitterData,outputFile);

