from django.urls import path

from . import views

urlpatterns = [
    path("", views.spasms_index, name="spasms_index"),
    path("getname", views.get_name, name="get_name"),
    path("your-name/", views.get_name, name="get_name"),
    path("thanks/", views.thanks, name="thanks"),
]
