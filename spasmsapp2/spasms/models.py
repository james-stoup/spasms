from django.db import models
from django.core.validators import MaxValueValidator, MinValueValidator
from datetime import datetime


# Create your models here.

# The largest unit that our data can be divided into
class Exercise(models.Model):
    name = models.CharField(max_length=250, unique=True)
    description = models.TextField()
    logo = models.FilePathField(path="/img")

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return "view_exercise/%s" % self.name

class Group(models.Model):
    name = models.CharField(max_length=250,unique=True)
    description = models.TextField()
    num_users = models.PositiveIntegerField(default=0)
    percent_female = models.PositiveIntegerField(
        default=50, validators=[MaxValueValidator(100)]
    )
    exercise = models.ForeignKey("Exercise",on_delete=models.CASCADE,to_field="name")

    def __str__(self):
        return self.name


class TweetRun(models.Model):
    def __str__(self):
        return self.label

    label = models.CharField(max_length=250, unique=True)
    created_on = models.DateTimeField(auto_now_add=True)
    num_posts = models.PositiveIntegerField(default=0)
    sentiments = [("pos", "positive"), ("neg", "negative")]
    sentiment = models.CharField(
        max_length=100, choices=sentiments, verbose_name="Sentiment", default="pos"
    )
    topic_noun = models.CharField(
        max_length=100, verbose_name="Noun relating to topic", default="none"
    )
    start_date = models.DateField(default=datetime.now())
    end_date = models.DateField(default=datetime.now())
    group = models.ForeignKey("Group", on_delete=models.CASCADE, to_field="name")


# each exercise is made up of users
class TwitterUser(models.Model):
    # name data
    screen_name = models.CharField(max_length=250)
    first_name = models.CharField(max_length=250)
    last_name = models.CharField(max_length=250)

    # user traits
    gender = models.CharField(max_length=250)
    age = models.IntegerField()

    # account traits
    followers = models.IntegerField()
    favourites = models.IntegerField()
    statuses = models.IntegerField()
    description = models.CharField(max_length=250)
    created_at = models.DateTimeField(default=datetime.now())

    # locations
    country = models.CharField(max_length=250)
    province = models.CharField(max_length=250)
    language = models.CharField(max_length=250)

    # a user can only associate with one exercise
    group = models.ForeignKey("Group", on_delete=models.CASCADE)


# each tweet can, but isn't require to, have a hashtag
class HashTag(models.Model):
    author = models.OneToOneField(TwitterUser, on_delete=models.CASCADE)
    creation_time = models.DateTimeField()
    tag = models.CharField(max_length=100)
    group = models.ForeignKey("Group", on_delete=models.CASCADE)


# basic tweet structure (add fields as needed)
class Tweet(models.Model):
    author = models.ForeignKey(TwitterUser, on_delete=models.CASCADE)
    run = models.ForeignKey(TweetRun, on_delete=models.CASCADE)
    text = models.CharField(max_length=280)
    creation_time = models.DateTimeField()
    hashtags = models.ForeignKey("HashTag", on_delete=models.CASCADE, null=True)
