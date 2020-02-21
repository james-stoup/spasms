import sys,os
sys.path.append(os.path.abspath(os.path.join('..','src')))

from django.shortcuts import render
from django.http import HttpResponse,HttpResponseRedirect
from .forms import InputModelForm

from spasmsMain import spasms_main

def index(request):
	return HttpResponse("Hello, world. You're at the polls index.")

def thanks(request):
	return HttpResponse("Thank you for your submission!")

def get_name(request):
	# if this is a POST request we need to process the form data
	if request.method == 'POST':
		# create a form instance and populate it with data from the request:
		form = InputModelForm(request.POST)
		# check whether it's valid:
		if form.is_valid():
			# process the data in form.cleaned_data as required
			data = form.cleaned_data
			print(data)
			#spasms_main(data['group_name'],data['topic_name'],data['num_users'],data['percent_female'],data['twitter_or_facebook'],data['num_posts'],data['sentiment'],data['topic_noun'],data['json_output'])	
			#redirect to new url
			return HttpResponseRedirect('/thanks/')
	# if a GET (or any other method) we'll create a blank form
	else:
		form = InputModelForm()
	return render(request, 'form_template.html', {'form': form})
