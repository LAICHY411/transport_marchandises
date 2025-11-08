from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAuthenticated,AllowAny
from rest_framework.exceptions import ValidationError
from .models import Vehicules,DisponibiliteVehicules
from .serializer import VehiculesSerializer,DisponibiliteVehiculesSerializer
from .permissions import IsPrestataire


class VehiculesView(ModelViewSet):

    serializer_class = VehiculesSerializer
    permission_classes = [IsPrestataire]

    def get_queryset(self):
        user = self.request.user
        if user.is_staff or user.is_superuser:
            return Vehicules.objects.all()
        return Vehicules.objects.filter(prestataire=user)

    def perform_create(self, serializer):
        serializer.save(prestataire=self.request.user)

class DisponibiliteVehiculesView(ModelViewSet):
    queryset=DisponibiliteVehicules.objects.all()
    serializer_class = DisponibiliteVehiculesSerializer
    permission_classes = [IsPrestataire]
 
    def get_queryset(self):
            queryset = DisponibiliteVehicules.objects.all()
            vehicule_id = self.request.query_params.get('vehicule_id')
            if vehicule_id:
                queryset = queryset.filter(vehicule_id=vehicule_id)
            return queryset

    def perform_create(self, serializer):
            vehicule_id = self.request.query_params.get('vehicule_id')
            if not vehicule_id:
                raise ValidationError({"vehicule_id": "Le paramètre vehicule_id est obligatoire."})
            try:
                vehicule = Vehicules.objects.get(id=vehicule_id)
            except Vehicules.DoesNotExist:
                raise ValidationError({"vehicule_id": "Véhicule introuvable."})
            serializer.save(vehicule=vehicule)

            
        

