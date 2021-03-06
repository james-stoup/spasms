from django.urls import path


from . import views

urlpatterns = [
    path("", views.spasms_index, name="spasms_index"),
    path("help",views.help_you,name="spasms_help"),
    path("contact",views.contact_us,name="spasms_contact_us"), 
    path("exercise", views.get_exercise_form, name='get_exercise_form'),
    path("view_groups/<str:id_exercise>", views.groups_list, name="groups_list"),
    path("view_groups/view_runs/<str:id_group>", views.runs_list, name="runs_list"),
    path("view_groups/view_users/<str:id_group>", views.users_list, name="users_list"),
    path("thanks", views.thanks, name="thanks"),
    path("group", views.get_group_form, name="get_group_form"),
    path("run", views.get_run_form, name="get_run_form"),
    path("view_groups/run/<str:group_name>", views.get_run_form_from_group, name="get_run_form_from_group"),
    path("view_groups/view_runs/run/<str:group_name>", views.get_run_form_from_group, name= "get_run_form_from_group"),
    path("view_exercise", views.ExerciseListView.as_view(), name="get_exercise_list"),
    path("<int:id>/delete_exercise/", views.ExerciseDelete.as_view(), name="exercise_confirm_delete"),
    path("view_groups/<int:id>/delete_group/", views.GroupDelete.as_view(), name="group_confirm_delete"),
    path("export_json", views.export_json, name="export_json"),
    path("view_exercise/<str:id_exercise>", views.runs_list, name="get_runs_list"),
    path("group/<str:id_exercise>", views.get_group_form_from_list, name="get_group_form_from_list"),
    path("display_json", views.display_json, name="display_json"),
    path("view_groups/view_runs/display_json/<str:run_label>",views.display_json_from_run, name="display_json_from_run"),
    path("group",views.get_group_form, name='get_group_form'),
    path(
        "view_exercise/exercise_list/<str:id_exercise>/<str:id_run>",
        views.export_json_direct,
        name="export_json_direct",
    ),
]
