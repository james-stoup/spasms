import psycopg2
import genTweet
import generateTwitterUser
import exportJson
import math


def main():
	conn = psycopg2.connect(database="spasms", user="postgres", password="wowarcraft12", host="/var/run/postgresql", port="5432")
	cur = conn.cursor()

	groupName = raw_input("Group name: ")
	topicName = raw_input("Topic name: ")
	numberOfUsers = raw_input ("Number of users: ")
	genderPercentage = raw_input("Percent of users to be female: ")
	typeOfPosts = raw_input("Twitter or Facebook posts: ")
	numberOfPosts = raw_input("Number of posts: ")
	sentimentOfPosts = raw_input("Positive (pos) or Negative (neg) posts: ")
	nounOfPosts = raw_input("Please input noun relating to topic for tweets: ")
	nameOfJsonFile = raw_input("Name for json file output: ")

	genderPercentage = int(genderPercentage)/100
	numberOfFemales = int(int(numberOfUsers)*genderPercentage)
	numberOfMales = int(numberOfUsers) - numberOfFemales

	if typeOfPosts.lower() == "twitter":
		if numberOfFemales > 0:
			generateTwitterUser.insertTwitterUsers(cur, groupName, numberOfFemales, "f")
		if numberOfMales > 0:
			generateTwitterUser.insertTwitterUsers(cur, groupName, numberOfMales, "m")
		genTweet.genTweet(cur, groupName, nounOfPosts, sentimentOfPosts, topicName, int(numberOfPosts))
	elif typeOfPosts.lower() == "facebook":
		print("Feature under development")

	conn.commit()
	exportJson.exportTweets(cur, topicName, nameOfJsonFile)

if __name__ == '__main__':
	main()