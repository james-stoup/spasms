from django.urls import path

from . import views

urlpatterns = [
	path('', views.get_name, name='get_name'),
	path('your-name/', views.get_name, name='get_name'),
	path('thanks/', views.thanks, name='thanks'),
]
