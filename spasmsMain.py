#!/usr/bin/env python


import psycopg2
import genTweet
import generateTwitterUser
import exportJson
import math
import sys


def connect_to_db(db_name):
	"""Try to connect to the DB, return connection if successful"""
	conn = psycopg2.connect(
		database=db_name,
		user="postgres",
		password="wowarcraft12",
		host="/var/run/postgresql",
		port="5432",
	)

	return conn


def get_input(prompt):
	"""Prompt the user for input until they enter valid data"""
	while True:
		user_input = input("%38s : " % prompt)
		if not user_input.strip():
			print("Please enter valid input")
		else:
			return user_input

def main():

	conn = connect_to_db("spasms")
	cur = conn.cursor()

	# get input
	groupName = get_input("Group name")
	topicName = get_input("Topic name")
	numberOfUsers = get_input("Number of users")
	genderPercentage = get_input("Percent of users to be female")
	typeOfPosts = get_input("Select Post Type (Twitter/Facebook)")
	numberOfPosts = get_input("Number of posts")
	sentimentOfPosts = get_input("Select Attitude (pos/neg")
	nounOfPosts = get_input("Enter noun relating to topic")
	nameOfJsonFile = get_input("Name for json file output")

	genderPercentage = int(genderPercentage) / 100
	numberOfFemales = int(int(numberOfUsers) * genderPercentage)
	numberOfMales = int(numberOfUsers) - numberOfFemales

	if typeOfPosts.lower() == "twitter":
		if numberOfFemales > 0:
			generateTwitterUser.insertTwitterUsers(cur, groupName, numberOfFemales, "f")

		if numberOfMales > 0:
			generateTwitterUser.insertTwitterUsers(cur, groupName, numberOfMales, "m")
				
		genTweet.genTweet(
			cur,
			groupName,
			nounOfPosts,
			sentimentOfPosts,
			topicName,
			int(numberOfPosts),
		)
			
		conn.commit()
		exportJson.exportTweets(cur, topicName, nameOfJsonFile)
		print("Twitter posts have been generated and file successfully exported")
			
	elif typeOfPosts.lower() == "facebook":
		print("Feature under development")
	else:
		sys.exit("Invalid Feature Selected. Goodbye.")

	conn.close()


if __name__ == "__main__":
    main()
