import os
import sys

sys.path.append(os.path.abspath(os.path.join("..", "src")))

from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect, Http404
from datetime import datetime
from .forms import InputModelForm, ExerciseForm, TweetRunForm, ExportJsonForm
from spasmsMain import spasms_main, create_twitter_users, create_tweets
from exportJson import exportTweetsDjango
from django.contrib import messages
from .models import Exercise, Tweet, TweetRun
from django.views import generic
import pdb


def spasms_index(request):
    return render(request, "spasms_index.html")


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
    return render(request, "thanks.html", {"messages": request.session["messages"]})


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


def get_exercise_form(request):
    if request.method == "POST":
        form = ExerciseForm(request.POST)
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
            return HttpResponseRedirect("/thanks")
    # if a GET (or any other method) we'll create a blank form
    else:
        form = ExerciseForm()
    return render(request, "exercise_form.html", {"form": form})


def get_name(request):
    # if this is a POST request we need to process the form data
    if request.method == "POST":
        # create a form instance and populate it with data from the request:
        form = InputModelForm(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            data = form.cleaned_data
            start_date = str(data["start_date"])
            end_date = str(data["end_date"])
            nameOfJsonFile = data["json_output"]
            outputFileLoc = os.path.join("../../output", nameOfJsonFile)
            absOutputFileLoc = os.path.abspath(outputFileLoc)
            messages.success(request, absOutputFileLoc)
            # print(data)
            spasms_main(
                data["group_name"],
                data["topic_name"],
                data["num_users"],
                data["percent_female"],
                data["twitter_or_facebook"],
                data["num_posts"],
                data["sentiment"],
                data["topic_noun"],
                start_date,
                end_date,
                data["json_output"],
            )
            # redirect to new url
            return HttpResponseRedirect("/thanks/")
    # if a GET (or any other method) we'll create a blank form
    else:
        form = InputModelForm()
    return render(request, "form_template.html", {"form": form})
