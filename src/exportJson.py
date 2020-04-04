import json
import spasmsMain

def exportTweets(cursor, topic, fileName):
    cursor.execute("SELECT * FROM Twitter_posts WHERE topic=%s", (topic,))
    twitterData = []
    tweets = cursor.fetchall()
    for tweet in tweets:
        userId = int(tweet[0])
        cursor.execute("SELECT * FROM Twitter_users WHERE id=%s", (userId,))
        user = cursor.fetchone()
        twitterData.append(
            {
                "created_at": str(tweet[3]),
                "id": int(tweet[1]),
                "id_str": tweet[2],
                "text": tweet[4],
                "entities": {
                    "hashtags": [],
                    "urls": [],
                    "user_mentions": [],
                    "symbols": [],
                },
                "lang": tweet[10],
                "user": {
                    "id": userId,
                    "id_str": user[1],
                    "name": user[11],
                    "screen_name": user[2],
                    "location": user[3],
                    "created_at": str(user[4]),
                    "followers_count": int(user[5]),
                    "favourites_count": int(user[6]),
                    "statuses_count": int(user[7]),
                    "description": user[8],
                },
            }
        )
    outputFile = open(fileName, "w")
    json.dump(twitterData, outputFile)

def exportTweetsDjango(label, fileName):
    conn = spasmsMain.connect_to_db("spasms")
    cursor = conn.cursor()
    cursor.execute("SELECT id FROM spasms_tweetrun WHERE label=%s", (label,))
    run_id = cursor.fetchone() [0]
    cursor.execute("SELECT * FROM spasms_tweet WHERE run_id=%s", (run_id,))
    twitterData = []
    tweets = cursor.fetchall()
    for tweet in tweets:
        userId = int(tweet[3])
        cursor.execute("SELECT * FROM spasms_twitteruser WHERE id=%s", (userId,))
        user = cursor.fetchone()
        twitterData.append(
            {
                "created_at": str(tweet[2]),
                "id": int(tweet[0]),
                "id_str": tweet[0],
                "text": tweet[1],
                "entities": {
                    "hashtags": [],
                    "urls": [],
                    "user_mentions": [],
                    "symbols": [],
                },
                "lang": 'eng',
                "user": {
                    "id": userId,
                    "id_str": userId,
                    "name": user[2] + " " +user[3],
                    "screen_name": user[1],
                    "location": user[7]+', '+user[6],
                    "created_at": str(user[10]),
                    "followers_count": int(user[13]),
                    "favourites_count": int(user[12]),
                    "statuses_count": int(user[14]),
                    "description": user[11],
                },
            }
        )
    outputFile = open(fileName, "w")
    json.dump(twitterData, outputFile, indent=4)