from django.urls import path

from . import views

urlpatterns = [
    path("", views.spasms_index, name="spasms_index"),
    path("home", views.spasms_index, name="spasms_index"),
    path("getname", views.get_name, name="get_name"),
    path("thanks", views.thanks, name="thanks"),
    path("exercise",views.get_exercise_form,name="get_exercise_form")
]
