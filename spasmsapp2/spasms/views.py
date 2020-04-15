import os
import sys


sys.path.append(os.path.abspath(os.path.join("..", "src")))

from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect, Http404
from datetime import datetime
from .forms import GroupForm, TweetRunForm, ExportJsonForm
from spasmsMain import spasms_main, create_twitter_users, create_tweets
from exportJson import exportTweetsDjango
from django.contrib import messages
from .models import Exercise, Group, Tweet, TweetRun
from django.views import generic
import pdb


def spasms_index(request):
    if "exercise_name" in request.session:
        del request.session["exercise_name"]
    if "messages" in request.session:
        del request.session["messages"]
    request.session.modified = True
    return render(request, "spasms_index.html")

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
        return render(
            request, "display_json.html", {"form": form, "file_name": file_name}
        )
    else:
        form = ExportJsonForm()
        return render(request, "display_json.html", {"form": form})


def thanks(request):
    if "exercise_name" in request.session:
        print(request.session["exercise_name"])
        return render(
            request,
            "thanks.html",
            {
                "messages": request.session["messages"],
                "exercise_name": request.session["exercise_name"],
            },
        )
    if "messages" in request.session:
        return render(request, "thanks.html", {"messages": request.session["messages"]})
    return render(request, "thanks.html")


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
    if "exercise_name" in request.session:
        form = TweetRunForm(
            initial={
                "exercise": Exercise.objects.filter(
                    name=request.session["exercise_name"]
                ).first
            }
        )
    elif request.method == "POST":
        form = TweetRunForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            print(data)
            print(data["exercise"])
            form.save()
            create_tweets(
                data["label"],
                data["num_posts"],
                data["sentiment"],
                data["topic_noun"],
                str(data["start_date"]),
                str(data["end_date"]),
                data["exercise"],
            )
            # redirect to new url
            request.session["messages"] = ["Run succesfully created!"]
            return HttpResponseRedirect("/thanks")
            # if a GET (or any other method) we'll create a blank form
    else:
        form = TweetRunForm()
    return render(request, "run_form.html", {"form": form})


def exercise_list(request):
    Exercise_list = Exercise.objects.all()
    print("yes")
    # pdb.set_trace()
    return render(request, "exercise_list.html", {"objectlist": Exercise_list})


def runs_list(request, id_exercise):
    try:
        tweetRuns = TweetRun.objects.filter(exercise_id=id_exercise)
    except TweetRun.DoesNotExist:
        raise Http404("Book does not exist")
    print(tweetRuns)

    return render(
        request, "runs_list.html", {"runs_list": tweetRuns, "id_exercise": id_exercise}
    )


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
            request.session["messages"] = ["Exercise succesfully created!"]
            request.session["exercise_name"] = data["name"]
            return HttpResponseRedirect("/thanks")
    # if a GET (or any other method) we'll create a blank form
    else:
        form = GroupForm()
    return render(request, "exercise_form.html", {"form": form})