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
		});
	outputFile = open(fileName,"w");
	json.dump(twitterData,outputFile);

