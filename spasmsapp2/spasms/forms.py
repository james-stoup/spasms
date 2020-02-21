from django import forms
from .models import InputModel
from django.forms import ModelForm

class InputModelForm(ModelForm):
	class Meta:
		model = InputModel
		fields = ['group_name', 'topic_name', 'num_users', 'percent_female', 'twitter_or_facebook', 'num_posts', 'sentiment', 'topic_noun', 'json_output']

# class NameForm(forms.Form):
# 	group_name = forms.CharField(label='Group name', max_length=100)
# 	topic_name = forms.CharField(label='Topic name', max_length=200)
# 	num_users = forms.IntegerField(initial=1, min_value=1)
# 	percent_female = forms.IntegerField(initial=50, min_value=0, max_value=100)
# 	post_options = [('twitter','Twitter'),('facebook','Facebook')]
# 	twitter_or_facebook = forms.ChoiceField(choices=post_options,label='Type of Posts')
# 	num_posts = forms.IntegerField(initial=1, min_value=1)
# 	sentiments = [('pos','positive'),('neg','negative')]
# 	sentiment = forms.ChoiceField(choices=sentiments,label='Sentiment')
# 	topic_noun = forms.CharField(label='Noun relating to topic', max_length=100)
# 	json_output = forms.CharField(label='Name for json file output', max_length=100)
