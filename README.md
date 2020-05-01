# Sentiment Predictor And Social Media Shaper (spasms)

Hello and welcome to spasms! Spasms is a tool that can be used create a multitude of users and posts for twitter to sway the sentiment on a topic one way or another. The purpose of this tool is to create training data for those who analyze how sentiment on social media affects our world.

## Dependencies

We recommend having the following on your system.

- [Pip](https://pip.pypa.io/en/stable/installing/ "Pip") which can be used for other dependencies, and at a later date spasms itself.
- [PyEnv](https://github.com/pyenv/pyenv-installer "PyEnv") to manage different versions of Python. Python 3.7+ is recommended. Can be installed using pip.
- [PostgreSQL](https://www.postgresql.org/docs/9.3/tutorial-install.html "PostgreSQL") to be able create the database used in the spasms tool in creation of twitter users and posts as well as storage of what was created. It is recommended that during the creation of the postgres user it does not require a password to switch to the postgres user, or require a password to connect to a database.
- [Django](https://docs.djangoproject.com/en/3.0/topics/install/ "Django") to run the webui used for input into the tool. Can be installed using pip.
- [Psycopg2](https://pypi.org/project/psycopg2/ "Psycopg2") is required for the code to access the database. Can be installed using pip.

Once these have been installed correctly there are just a few things to finish setting up to use the tool.


## Setup

The first thing that needs to be done is to clone the repository.

```git clone https://github.com/james-stoup/spasms.git```

Next will be to create a blank database named spasms.

```
sudo su
(type password for sudo)
su - postgres
psql postgres
CREATE DATABASE spasms;
\c spasms (to connect to database)
\q (to close database)
```

While you're still using your postgres user type pwd and write down the path it gives you as it will be needed for the next step. Type exit followed by pressing enter until you're back to your user. The final step for setup will be to import the database file provided into the database you just created.

```
cd spasms
cd data
sudo cp spasms.sql (paste path returned from pwd here)
(password if it asks)
sudo su
(password if it asks... again)
su - postgres
psql spasms < spasms.sql
```

Once you've imported the file you can exit back to your user.

## Usage

To use the tool in it's current state you will run the django test server. This can be done quite easily. The steps below will assume you're already in the spasms folder.

```
cd spasmsapp2
python manage.py runserver
```

In the terminal will be a server address you can copy and paste into your broweser of choice, or you can right click the address and click open link.

This will open your browser where you will be greeted with the homepage.

![Homepage Image](/resources/homepage.png)

What you will notice on the home page are three links in the navbar at the top. The welcome link takes you back to this page, and the help and contact links will take you to there respective pages. The most important things to notice for this usage guide are the "Create new exercise" button in the middle of the page and the list of previously created exercises. We'll come back to the list later in this guide so for now we'll click the button to create a new exercise.

### Creating an Exercise

When you've clicked the button to create a new exercise you'll be brought here.

![Exercise Image](/resources/create_exercise.png)

Here you will input of the name of the exercise as well as a description of the exercise. An exercise is a broad category, like an event, that will contain sub groups. For our example we will use the 2020 election as our exercise.

![Exercise filled Image](/resources/create_exercise_filled.png)

Once we've filled in what we need we can click submit which will take you to the thanks page.

From here you can head back to the homepage or create a group. We will choose to create a group for this exercise. One thing to note about the thanks page is the create a group button will change to create a run when a group is created, and once a run is created the button will then change to view the json data.

For the sake of not taking too many screenshots to fill this guide we will show creating groups and runs with the input filled in.

### Creating a Group

When creating a group you will be brought to a page that looks like this...

![Group creation Image](/resources/create_group.png)

This will create a group of 10 users that we've labeled as Republicans and half of the users will be female. One thing to note is that the exercise will be preselected for you, but can be changed if needed. Once we're ready we can click submit which will bring us to the thanks page where we can click the "create run" button.

### Creating a Run

When creating a run you will be brought to this page...

![Run creation Image](/resources/create_run.png)

For our group of Republicans will create a run of tweets that will be supportive of President Trump. We will create 10 tweets, the sentiment is postivive since they're supportive of Trump, and our noun is Trump because we want the tweets to talk about Trump. We can also specify the date range of the tweets created. Once again the group is preselected for us.

### Viewing the json Data

When you have a run created you can view the json data. The run you either just created, or clicked the "view json" button, will be preselected, but the run can be changed to another created run. It will have a scrollable window on the page where you can view all the formated data in that json file.

![View json Image](/resources/view_json.png)

## The Team

- Sharon Jose
- John Martinez
- Thomas Klock
