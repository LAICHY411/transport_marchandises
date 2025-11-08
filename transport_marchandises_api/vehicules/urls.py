from django.urls import path
from .views import VehiculesView,DisponibiliteVehiculesView
from rest_framework.routers import SimpleRouter
routers=SimpleRouter()
routers.register("vehicules",VehiculesView,basename="")
routers.register(r'reservation',DisponibiliteVehiculesView,basename="reservation")
urlpatterns=[
]+routers.urls
