from django import forms
from .models import Exercise, Group, TweetRun, Tweet
from django.forms import ModelForm


class DateInput(forms.DateInput):
    input_type = "date"


class ExportJsonForm(ModelForm):
    class Meta:
        model = Tweet
        fields = ["run"]


class GroupForm(ModelForm):
    class Meta:
        model = Group
        fields = ["name", "description", "num_users", "percent_female"]


class TweetRunForm(ModelForm):
    class Meta:
        model = TweetRun
        fields = [
            "label",
            "num_posts",
            "sentiment",
            "topic_noun",
            "start_date",
            "end_date",
            "group",
        ]
        widgets = {"start_date": DateInput(), "end_date": DateInput()}


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
