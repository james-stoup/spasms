from django import forms

class NameForm(forms.Form):
	group_name = forms.CharField(label='Group name', max_length=100)
	topic_name = forms.CharField(label='Topic name', max_length=200)
	

