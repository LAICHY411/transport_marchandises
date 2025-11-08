from django.shortcuts import render
from rest_framework.viewsets import ModelViewSet
from .serializer import CustomUserSerializer,CustomTokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from .models import CustomUser
from rest_framework.permissions import IsAuthenticated,IsAdminUser,AllowAny
# Create your views here.
# pout custom Token 
class CustomTokenObtainPairView(TokenObtainPairView):
    serializer_class = CustomTokenObtainPairSerializer
    
class UserView(ModelViewSet):
    # permission_classes=[IsAuthenticated]
    queryset=CustomUser.objects.all()
    serializer_class=CustomUserSerializer
    def get_queryset(self):
        if self.request.user.is_staff or self.request.user.is_superuser:
            return CustomUser.objects.all()
        return CustomUser.objects.filter(id=self.request.user.id)
    def get_permissions(self):
        if self.action=="create":
            return [AllowAny()]
        else:
            return [IsAuthenticated()]
    
        
    