from django import forms

class NameForm(forms.Form):
	group_name = forms.CharField(label='Group name', max_length=100)
	topic_name = forms.CharField(label='Topic name', max_length=200)
	num_users = forms.IntegerField()
	percent_female = forms.IntegerField()
	post_options = [('1','Twitter'),('2','Facebook')]
	twitter_or_facebook = forms.ChoiceField(choices=post_options,label='Type of Posts')
	num_posts = forms.IntegerField()
	sentiments = [(1,'positive'),(2,'negative')]
	sentiment = forms.ChoiceField(choices=sentiments,label='Sentiment')
	#topic_noun = forms.CharField(lebel='Noun relating to topic', max_length=100)
