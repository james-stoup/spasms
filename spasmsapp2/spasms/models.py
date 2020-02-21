from django.db import models
# Create your models here.
class InputModel(models.Model):
	group_name = models.CharField(max_length=200, verbose_name='Group name')
	topic_name = models.CharField(max_length=200, verbose_name='Topic name')
	num_users = models.IntegerField()
	percent_female = models.IntegerField()
	post_options = [('twitter','Twitter'),('facebook','Facebook')]
	twitter_or_facebook = models.CharField(max_length=100, choices=post_options, default='twitter', verbose_name='Type of posts')
	num_posts = models.IntegerField()
	sentiments = [('pos','positive'),('neg','negative')]
	sentiment = models.CharField(max_length=100, choices=sentiments, verbose_name='Sentiment')
	topic_noun = models.CharField(max_length=100, verbose_name='Noun relating to topic')
	start_date = models.DateField()
	end_date = models.DateField()
	json_output = models.CharField(max_length=100, verbose_name='Name for json file output')

	def __str__(self):
		return self.group_name
