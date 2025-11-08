from django.db import models
from django.contrib.auth.models import BaseUserManager,AbstractBaseUser,PermissionsMixin


# Create your models here.

class CustomUserManager(BaseUserManager):
    def create_user(self,email,password=None, **kwargs):
        if not email:
            raise ValueError("L'utilisateur doit avoir une adresse email.")
        kwargs.setdefault('is_active', True) 
        print("hna hna serveur ")
        email=self.normalize_email(email=email)
        user=self.model(email=email,**kwargs)
        user.set_password(password)
        user.save()
        return user
    def create_superuser(self,email,password,**kwargs):
        
        kwargs.setdefault('is_staff',True)
        kwargs.setdefault("is_superuser",True)
        if kwargs.get('is_staff') is not True:
            raise ValueError("Le superutilisateur doit avoir is_staff=True.")
        if kwargs.get('is_superuser') is not True:
            raise ValueError("Le superutilisateur doit avoir is_superuser=True.")
        return self.create_user(email,password,**kwargs)

class CustomUser(AbstractBaseUser,PermissionsMixin):
   nom=models.CharField(max_length=30)
   prenom=models.CharField(max_length=30)
   email=models.EmailField(unique=True)
#    password=models.CharField(max_length=30,min=8)
   telephone=models.CharField(max_length=12,blank=True)
   adresse=models.CharField(max_length=30,blank=True)
   role=models.CharField(choices=[("Client","Client"),("Prestataire","Prestataire")])
   type_utilisateur=models.CharField(choices=[("Entreprise","Entreprise"),("Particulier","Particulier")],default="Particulier" )
   image_profile=models.ImageField(upload_to="images/%Y/%m/%d/",blank=True,null=True)
   is_active=models.BooleanField(default=True)
   is_superuser=models.BooleanField(default=False)
   is_staff=models.BooleanField(default=False)
   objects=CustomUserManager()
   USERNAME_FIELD="email"
   REQUIRED_FIELDS=['nom',
                    'prenom',
                    'telephone',
                    'adresse',
                    'role',
                    'type_utilisateur']
   def __str__(self):
       return self.email
   