    
from rest_framework.serializers import ModelSerializer
from rest_framework import serializers
from .models import Vehicules
from .models import DisponibiliteVehicules
class VehiculesSerializer(ModelSerializer):
    class Meta:
        model = Vehicules
        fields = "__all__"
        read_only_fields = ["prestataire", "date_ajout"]
class DisponibiliteVehiculesSerializer(serializers.ModelSerializer):
    vehicule = serializers.PrimaryKeyRelatedField(read_only=True)
    class Meta:
        model=DisponibiliteVehicules
        fields='__all__'
        