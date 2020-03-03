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
    except OSError as err:
        print("OS error: {0}".format(err))
    except:
        print("Unexpected error:", sys.exc_info()[0])
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

    # First let's try to hit the database
    conn = connect_to_db("spasms")

    # get input
    groupName = get_input("Group name")
    topicName = get_input("Topic name")
    numberOfUsers = get_input("Number of users")
    genderPercentage = get_input("Percent of users to be female")
    typeOfPosts = get_input("Select Post Type (Twitter/Facebook)")
    numberOfPosts = get_input("Number of posts")
    sentimentOfPosts = get_input("Select Attitude (pos/neg)")
    startDate = get_input("Enter starting date")
    endDate = get_input("Enter ending date")
    nounOfPosts = get_input("Enter noun relating to topic")
    nameOfJsonFile = get_input("Name for json file output")

    # pass in the params to kick it off
    spasms_main(
        conn,
        groupName,
        topicName,
        numberOfUsers,
        genderPercentage,
        typeOfPosts,
        numberOfPosts,
        sentimentOfPosts,
        nounOfPosts,
        startDate,
        endDate,
        nameOfJsonFile,
    )


def spasms_main(
    conn,
    groupName,
    topicName,
    numberOfUsers,
    genderPercentage,
    typeOfPosts,
    numberOfPosts,
    sentimentOfPosts,
    nounOfPosts,
    startDate,
    endDate,
    nameOfJsonFile,
):

    cur = conn.cursor()

    # make sure the file is outputed as a .json file
    if not nameOfJsonFile.endswith(".json"):
        nameOfJsonFile = "%s.json" % nameOfJsonFile
    outputFileLoc = os.path.join("../output", nameOfJsonFile)

    genderPercentage = int(genderPercentage) / 100
    numberOfFemales = int(int(numberOfUsers) * genderPercentage)
    numberOfMales = int(numberOfUsers) - numberOfFemales

    if typeOfPosts.lower() == "twitter":
        if numberOfFemales > 0:
            generateTwitterUser.insertTwitterUsers(
                cur, groupName, numberOfFemales, "f", startDate, endDate
            )

        if numberOfMales > 0:
            generateTwitterUser.insertTwitterUsers(
                cur, groupName, numberOfMales, "m", startDate, endDate
            )
        numPosts = int(numberOfPosts)
        genTweet.genTweet(
            cur, groupName, nounOfPosts, sentimentOfPosts, topicName, numPosts,
        )

        conn.commit()
        exportJson.exportTweets(cur, topicName, outputFileLoc)
        print(
            "Twitter posts have been generated and file successfully exported to : %s"
            % os.path.abspath(outputFileLoc)
        )

    elif typeOfPosts.lower() == "facebook":
        print("Feature under development")
    else:
        sys.exit("Invalid Feature Selected. Goodbye.")

    conn.close()


def create_twitter_users(
    groupName,
    numUsers,
    percentFemale,
    startDate,
    endDate
):    
    conn = connect_to_db("spasms")
    cur = conn.cursor()

    #comput # of males and females
    percentFemale = int(percentFemale) / 100
    numFemales = int(int(numUsers) * percentFemale)
    numMales = int(numUsers) - numFemales
    if numFemales > 0:
        generateTwitterUser.insertTwitterUsers(
            cur, groupName, numFemales, "f", startDate, endDate
        )
    if numMales > 0:
        generateTwitterUser.insertTwitterUsers(
            cur, groupName, numMales, "m", startDate, endDate
        )
    conn.commit()
    conn.close()
    print("Twitter users created!")

if __name__ == "__main__":
    main()
