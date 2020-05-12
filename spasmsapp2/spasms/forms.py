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
        fields = [
            "name", 
            "description", 
            "num_users", 
            "percent_female",
            "exercise"
        ]

class ExerciseForm(ModelForm):
    class Meta:
        model = Exercise
        fields = ["name","description"]

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