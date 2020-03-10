from django.db import models
from django.core.validators import MaxValueValidator, MinValueValidator
from datetime import datetime

# Create your models here.
class InputModel(models.Model):
    group_name = models.CharField(max_length=200, verbose_name="Group name")
    topic_name = models.CharField(max_length=200, verbose_name="Topic name")
    num_users = models.PositiveIntegerField(default=0)
    percent_female = models.PositiveIntegerField(
        default=50, validators=[MaxValueValidator(100)]
    )
    post_options = [("twitter", "Twitter"), ("facebook", "Facebook")]
    twitter_or_facebook = models.CharField(
        max_length=100,
        choices=post_options,
        default="twitter",
        verbose_name="Type of posts",
    )
    num_posts = models.PositiveIntegerField(default=0)
    sentiments = [("pos", "positive"), ("neg", "negative")]
    sentiment = models.CharField(
        max_length=100, choices=sentiments, verbose_name="Sentiment"
    )
    topic_noun = models.CharField(max_length=100, verbose_name="Noun relating to topic")
    start_date = models.DateField()
    end_date = models.DateField()
    json_output = models.CharField(
        max_length=100, verbose_name="Name for json file output"
    )

    def __str__(self):
        return self.group_name

# The largest unit that our data can be divided into
class Exercise(models.Model):
	name = models.CharField(max_length=250,unique=True)
	description = models.TextField()
	num_users = models.PositiveIntegerField(default=0)
	percent_female = models.PositiveIntegerField(default=50, validators=[MaxValueValidator(100)])
	logo = models.FilePathField(path="/img")

	def __str__(self):
		return self.name

class TweetRun(models.Model):	
	label = models.CharField(max_length=250)
	created_on = models.DateTimeField(auto_now_add=True)
	num_posts = models.PositiveIntegerField(default=0)
	sentiments = [("pos", "positive"), ("neg", "negative")]
	sentiment = models.CharField(max_length=100, choices=sentiments, verbose_name="Sentiment", default='pos')
	topic_noun = models.CharField(max_length=100, verbose_name="Noun relating to topic", default='none')
	start_date = models.DateField(default=datetime.now())
	end_date = models.DateField(default=datetime.now())
	exercise = models.ForeignKey("Exercise", on_delete=models.CASCADE,to_field='name')

# each exercise is made up of users
class TwitterUser(models.Model):
    # name data
    screen_name = models.CharField(max_length=250)
    first_name = models.CharField(max_length=250)
    last_name = models.CharField(max_length=250)

    # user traits
    gender = models.CharField(max_length=250)
    age = models.IntegerField()

    # locations
    country = models.CharField(max_length=250)
    province = models.CharField(max_length=250)
    language = models.CharField(max_length=250)

    # a user can only associate with one exercise
    exercise = models.ForeignKey("Exercise", on_delete=models.CASCADE)


# each tweet can, but isn't require to, have a hashtag
class HashTag(models.Model):
    author = models.OneToOneField(TwitterUser, on_delete=models.CASCADE)
    creation_time = models.DateTimeField()
    tag = models.CharField(max_length=100)
    exercise = models.ForeignKey("Exercise", on_delete=models.CASCADE)


# basic tweet structure (add fields as needed)
class Tweet(models.Model):
    author = models.ForeignKey(TwitterUser, on_delete=models.CASCADE)
    text = models.CharField(max_length=280)
    creation_time = models.DateTimeField()
    hashtags = models.ForeignKey("HashTag", on_delete=models.CASCADE)
