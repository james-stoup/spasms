#!/usr/bin/env python

import pdb
import psycopg2
import genTweet
import generateTwitterUser
import exportJson
import math
import sys
import os

def connect_to_db(db_name):
	"""Try to connect to the DB, return connection if successful"""

	try:
		conn = psycopg2.connect(
			database=db_name,
			user="postgres",
			password="1514729",
			host="/var/run/postgresql",
			port="5432",
		)
	except:
		print("Unable to connect to database, ensure that postgres is running")
		sys.exit(1)
	
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
	pdb.set_trace()
	numberOfPosts = get_input("Number of posts")
	sentimentOfPosts = get_input("Select Attitude (pos/neg")
	nounOfPosts = get_input("Enter noun relating to topic")
	nameOfJsonFile = get_input("Name for json file output")

	# make sure the file is outputed as a .json file
	if not nameOfJsonFile.endswith(".json"):
		nameOfJsonFile = "%s.json" % nameOfJsonFile
	outputFileLoc = os.path.join("../output", nameOfJsonFile)
		
	genderPercentage = int(genderPercentage) / 100
	numberOfFemales = int(int(numberOfUsers) * genderPercentage)
	numberOfMales = int(numberOfUsers) - numberOfFemales

	if typeOfPosts.lower() == "twitter":
		if numberOfFemales > 0:
			generateTwitterUser.insertTwitterUsers(cur, groupName, numberOfFemales, "f")

		if numberOfMales > 0:
			generateTwitterUser.insertTwitterUsers(cur, groupName, numberOfMales, "m")
		pdb.set_trace()
		numPosts = int(numberOfPosts)		
		genTweet.genTweet(
			cur,
			groupName,
			nounOfPosts,
			sentimentOfPosts,
			topicName,
			numPosts,
		)
			
		conn.commit()
		exportJson.exportTweets(cur, topicName, outputFileLoc)
		print("Twitter posts have been generated and file successfully exported to : %s" % os.path.abspath(outputFileLoc))
			
	elif typeOfPosts.lower() == "facebook":
		print("Feature under development")
	else:
		sys.exit("Invalid Feature Selected. Goodbye.")

	conn.close()


if __name__ == "__main__":
    main()
