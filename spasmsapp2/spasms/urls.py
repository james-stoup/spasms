from django.urls import path


from . import views

urlpatterns = [
    path("", views.spasms_index, name="spasms_index"),
    path("home", views.spasms_index, name="spasms_index"),
    path("getname", views.get_name, name="get_name"),
    path("thanks", views.thanks, name="thanks"),
    path("exercise", views.get_exercise_form, name="get_exercise_form"),
    path("run", views.get_run_form, name="get_run_form"),
    path("view_exercise", views.ExerciseListView.as_view(), name="get_exercise_list"),
    path("export_json", views.export_json, name="export_json"),
    path("view_exercise/<str:id_exercise>", views.runs_list, name="get_runs_list"),
    path("display_json", views.display_json, name="display_json"),
    path(
        "view_exercise/exercise_list/<str:id_exercise>/<str:id_run>",
        views.export_json_direct,
        name="export_json_direct",
    ),
]
