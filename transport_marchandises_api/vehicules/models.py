from django.db import models
from account.models import CustomUser
from django.core.exceptions import ValidationError
from django.utils import timezone

class Vehicules(models.Model):
    marque = models.CharField(max_length=50)
    modele = models.CharField(max_length=50, blank=True, null=True)
    immatriculation = models.CharField(max_length=20, unique=True)
    capacite = models.DecimalField(max_digits=10, decimal_places=2)
    prestataire = models.ForeignKey(
        CustomUser, on_delete=models.CASCADE, related_name="vehicules"
    )
    tarif_km = models.DecimalField(max_digits=10, decimal_places=2)
    date_ajout = models.DateTimeField(default=timezone.now) 

    def __str__(self):
        return f"{self.marque} ({self.immatriculation})"
    


class DisponibiliteVehicules(models.Model):
    date_reservation = models.DateField()
    heure_debut = models.TimeField()
    heure_fin = models.TimeField()
    vehicule = models.ForeignKey(
        Vehicules, on_delete=models.CASCADE, related_name="disponibilites"
    )

    def clean(self):

        if self.heure_fin <= self.heure_debut:
            raise ValidationError("L'heure de fin doit être supérieure à l'heure de début.")

    def save(self, *args, **kwargs):
        self.clean()  
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.vehicule.marque} - {self.date_reservation} ({self.heure_debut} → {self.heure_fin})"

