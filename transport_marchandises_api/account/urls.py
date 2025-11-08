from django.urls import path
from rest_framework.routers import SimpleRouter
from rest_framework_simplejwt import views as jwt_views
from .views import UserView,CustomTokenObtainPairView
routers=SimpleRouter()
routers.register('users',UserView,basename="users")

urlpatterns=[path("login/",CustomTokenObtainPairView.as_view(),name="token_obtain_pair"), 
             path("api/refresh/",jwt_views.TokenRefreshView.as_view(),name="token_refresh")
             
    
    ]+routers.urls