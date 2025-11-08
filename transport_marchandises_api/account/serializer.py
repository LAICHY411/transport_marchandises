from rest_framework import serializers
from .models import CustomUser
class CustomUserSerializer(serializers.ModelSerializer):
    # is_active = serializers.BooleanField(default=True)
    class Meta:
        model=CustomUser
        fields='__all__'
        extra_kwargs={
            'password':{'write_only':True},
            "is_staff":{'read_only':True},
            "is_superuser":{'read_only':True},
            'is_active': {'read_only': True}, 
        }
    def create(self, validated_data):
        validated_data.pop('groups', None)
        validated_data.pop('user_permissions', None)
        password = validated_data.pop('password')
        user = CustomUser(**validated_data)
        user.set_password(password)
        user.save()
        return user
        
# sirialise de token pour remplace username par email
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.tokens import RefreshToken


class CustomTokenObtainPairSerializer(TokenObtainPairSerializer):
    username_field = CustomUser.USERNAME_FIELD 

    def validate(self, attrs):
        credentials = {
            self.username_field: attrs.get(self.username_field),
            'password': attrs.get('password')
        }
        print(f"credentials {credentials}")
        if not credentials[self.username_field] or not credentials['password']:
            raise serializers.ValidationError("Email et mot de passe requis.")

        user = CustomUser.objects.filter(email=credentials[self.username_field]).first()
        if user is None or not user.check_password(credentials['password']):
            raise serializers.ValidationError("Identifiants invalides.")

        refresh = RefreshToken.for_user(user)
        return {
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        }
