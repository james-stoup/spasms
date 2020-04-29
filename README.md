# Sentiment Predictor And Social Media Shaper (spasms)

Hello and welcome to spasms! Spasms is a tool that can be used create a multitude of users and posts for twitter to sway the sentiment on a topic one way or another. The purpose of this tool is to create training data for those who analyze how sentiment on social media affects our world.

## Dependencies

We recommend having the following on your system.

- [PyEnv](https://github.com/pyenv/pyenv-installer "PyEnv") to manage different versions of Python. Python 3.7+ is recommended.
- [Pip](https://pip.pypa.io/en/stable/installing/ "Pip") which can be used for other dependencies, and at a later date spasms itself.
- [PostgreSQL](https://www.postgresql.org/docs/9.3/tutorial-install.html "PostgreSQL") to be able create the database used in the spasms tool in creation of twitter users and posts as well as storage of what was created. It is recommended that during the creation of the postgres user it does not require a password to switch to the postgres user, or require a password to connect to a database.
- [Django](https://docs.djangoproject.com/en/3.0/topics/install/ "Django") to run the webui used for input into the tool.
- [Psycopg2](https://pypi.org/project/psycopg2/ "Psycopg2") is required for the code to access the database.

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


## The Team

- Sharon Jose
- John Martinez
- Thomas Klock
