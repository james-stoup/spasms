from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse,HttpResponseRedirect
from .forms import NameForm

def index(request):
	return HttpResponse("Hello, world. You're at the polls index.")

def thanks(request):
	return HttpResponse("Thank you for your submission!")

def get_name(request):
	# if this is a POST request we need to process the form data
	if request.method == 'POST':
		# create a form instance and populate it with data from the request:
		form = NameForm(request.POST)
		# check whether it's valid:
		if form.is_valid():
			# process the data in form.cleaned_data as required
			# ..
			# redirect to a new URL:
			print(form.cleaned_data)
			return HttpResponseRedirect('/thanks/')
	# if a GET (or any other method) we'll create a blank form
	else:
		form = NameForm()
	return render(request, 'name.html', {'form': form})
