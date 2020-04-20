import os
import sys


sys.path.append(os.path.abspath(os.path.join("..", "src")))

from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect, Http404
from datetime import datetime
from .forms import GroupForm, TweetRunForm, ExportJsonForm, ExerciseForm
from spasmsMain import spasms_main, create_twitter_users, create_tweets
from exportJson import exportTweetsDjango
from django.contrib import messages
from .models import Exercise, Group, Tweet, TweetRun, TwitterUser
from django.views import generic
from django.urls import reverse
from django.shortcuts import get_object_or_404
from django.views.generic.edit import DeleteView
from django.db.models import Count
import pdb


def spasms_index(request):
    request.session.flush()
    try:
        #exerciseList = Exercise.objects.all()
        exerciseList = Exercise.objects.annotate(num_groups=Count('group'))
    except Exercise.DoesNotExist:
        raise Http404("Exercises not found.")
    return render(request, "spasms_index.html",{"exercise_list": exerciseList})

def help_you(request):
	return render(request,"spasms_help.html")

def contact_us(request):
	return render(request,"spasms_contact_us.html")

def index(request):
    return HttpResponse("Hello, world. You're at the polls index")


def display_json(request):
    if request.method == "POST":
        form = ExportJsonForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
        file_name = str(data["run"]).replace(" ", "_") + ".json"
        variables = {"form": form, "file_name": file_name}
    elif "run_label" in request.session:
        form = ExportJsonForm(
                initial = {
                    'run': TweetRun.objects.filter(label=request.session['run_label']).first
                }
            )
        file_name = request.session['run_label'].replace(" ", "_") + ".json"
        variables = {"form": form, "file_name": file_name}
        del request.session["run_label"]
    else:
        form = ExportJsonForm()
        variables = {"form": form}
    return render(request, "display_json.html", variables)

def display_json_from_run(request,run_label):
    request.session["run_label"] = run_label
    return display_json(request)

def thanks(request):
    data = {}
    if "messages" in request.session:
        data['messages'] = request.session['messages']
    if "run_label" in request.session:
        data["run_label"] = request.session["run_label"]
    elif "group_name" in request.session:
        data['group_name'] = request.session['group_name']
    elif "exercise_name" in request.session:
        data['exercise_name'] = request.session['exercise_name']
    return render(request, "thanks.html", data)

class ExerciseDelete(DeleteView):

    def get_object(self):
        id_ = self.kwargs.get("id")
        return get_object_or_404(Exercise, id=id_)

    def get_success_url(self):
        return reverse("spasms_index")

class GroupDelete(DeleteView):

    def get_object(self):
        id_ = self.kwargs.get("id")
        return get_object_or_404(Group, id=id_)

    def get_success_url(self):
        return reverse("spasms_index")

class ExerciseListView(generic.ListView):
    model = Exercise
    context_object_name = "myExerciseList"

def export_json(request):
    if request.method == "POST":
        form = ExportJsonForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            file_name = str(data["run"]).replace(" ", "_") + ".json"
            outputFileLoc = os.path.join("../spasmsapp2/spasms/static", file_name)
            exportTweetsDjango(str(data["run"]), outputFileLoc)
            request.session["messages"] = [
                "Tweets succesfully exported to %s!" % file_name
            ]
            return HttpResponseRedirect("/thanks")
    else:
        form = ExportJsonForm()
    return render(request, "json_form.html", {"form": form})


def export_json_direct(request, id_exercise, id_run):

    file_name = str(id_run).replace(" ", "_") + ".json"
    outputFileLoc = os.path.join("../spasmsapp2/spasms/static", file_name)
    exportTweetsDjango(id_run, outputFileLoc)
    request.session["messages"] = ["Tweets succesfully exported to %s!" % file_name]
    return HttpResponseRedirect("/thanks")


def get_run_form(request):
    if request.method == "POST":
        form = TweetRunForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            print(data)
            form.save()
            create_tweets(
                data["label"],
                data["num_posts"],
                data["sentiment"],
                data["topic_noun"],
                str(data["start_date"]),
                str(data["end_date"]),
                str(data["group"]),
            )
            #export to json
            file_name = str(data["label"]).replace(" ", "_") + ".json"
            outputFileLoc = os.path.join("../spasmsapp2/spasms/static", file_name)
            exportTweetsDjango(str(data["label"]), outputFileLoc)
            # redirect to new url
            request.session["messages"] = ["Run %s succesfully created and exported to %s!"%(data["label"],file_name)]
            request.session["run_label"] = data["label"]
            return HttpResponseRedirect("/thanks")
            # if a GET (or any other method) we'll create a blank form
    elif "group_name" in request.session:
        form = TweetRunForm(
            initial={
                "group": Group.objects.filter(
                    name=request.session["group_name"]
                ).first
            }
        )
        del request.session["group_name"]
    else:
        form = TweetRunForm()
    return render(request, "run_form.html", {"form": form})

def get_run_form_from_group(request, group_name):
    request.session["group_name"] = group_name
    return get_run_form(request)

def exercise_list(request):
    Exercise_list = Exercise.objects.all()
    print("yes")
    # pdb.set_trace()
    return render(request, "exercise_list.html", {"objectlist": Exercise_list})

def groups_list(request, id_exercise):
    print("exercise id = "+id_exercise)
    try:
        exercise = Exercise.objects.filter(id=id_exercise).first
        groups = Group.objects.filter(exercise_id=id_exercise).annotate(num_runs=Count('tweetrun'))
    except Group.DoesNotExist:
        raise Http404("Exercise does not exist")
    print("groups list: ")
    print(groups)

    return render(
        request, "groups_page.html", {"groups_list": groups, "exercise":exercise}
    )

def get_group_form_from_list(request, id_exercise):
    request.session["exercise_name"] = id_exercise
    return get_group_form(request)

def runs_list(request, id_group):
    try:
        group = Group.objects.filter(id=id_group).first
        tweetRuns = TweetRun.objects.filter(group_id=id_group)
    except TweetRun.DoesNotExist:
        raise Http404("Gruop does not exist")

    return render(
        request, "runs_page.html", {"runs_list": tweetRuns, "group":group}
    )

def users_list(request, id_group):
    try:
        group = Group.objects.filter(id=id_group).first
        users = TwitterUser.objects.filter(group_id=id_group)
    except TweetRun.DoesNotExist:
        raise Http404("Gruop does not exist")
    return render(request,"users_page.html",{"users_list": users, "group": group})

def get_exercise_form(request):
    if request.method == "POST":
        form = ExerciseForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            form.save()
            # redirect to new URL
            request.session["messages"] = ["Exercise %s succesfully created!"%data['name']]
            request.session["exercise_name"] = data["name"]
            return HttpResponseRedirect("/thanks")
    # if a GET (or any other method) we'll create a blank form
    else:
        form = ExerciseForm()
    return render(request, "exercise_form.html", {"form": form})


def get_group_form(request):
    if request.method == "POST":
        form = GroupForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            print(data)
            today = str(datetime.now()).split()[0]
            form.save()
            print("form saved!")
            create_twitter_users(
                data["name"], data["num_users"], data["percent_female"], today, today
            )
            # redirect to new URL
            request.session["messages"] = ["Group %s succesfully created!"%data['name']]
            request.session["group_name"] = data["name"]
            return HttpResponseRedirect("/thanks")
    # if a GET (or any other method) we'll create a blank form
    elif "exercise_name" in request.session:
        form = GroupForm(
                initial={
                "exercise": Exercise.objects.filter(
                    name=request.session["exercise_name"]
                ).first
                }
            )
        del request.session["exercise_name"]
    else:
        form = GroupForm()
    return render(request, "group_form.html", {"form": form})
