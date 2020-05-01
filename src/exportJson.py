import json
import spasmsMain

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
                    "created_at": str(user[9]),
                    "followers_count": int(user[11]),
                    "favourites_count": int(user[12]),
                    "statuses_count": int(user[13]),
                    "description": user[10],
                },
            }
        )
    outputFile = open(fileName, "w")
    json.dump(twitterData, outputFile, indent=4)