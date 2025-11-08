import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class Utilisateur {
  int? id;
  String? nom;
  String? prenom;
  String? email;
  String? password;
  String? telephone;
  String? adresse;
  String? role;
  String? type_utilisateur;
  Uint8List? image_profile;
  String? urlImageProfile;

  Utilisateur({
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.password,
    this.telephone,
    this.adresse,
    this.role,
    this.type_utilisateur,
    this.image_profile,
    this.urlImageProfile,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
      'telephone': telephone,
      'adresse': adresse,
      'role': role,
      'type_utilisateur': type_utilisateur,
      'image_profile': image_profile,
    };
  }

  static Utilisateur? jsonToUser(data) {
    if (data == null) return null;

    return Utilisateur(
      id: data["id"],
      nom: data['nom'] as String?,
      prenom: data['prenom'] as String?,
      email: data['email'] as String?,
      telephone: data['telephone'] as String?,
      adresse: data['adresse'] as String?,
      role: data['role'] as String?,
      type_utilisateur: data['type_utilisateur'] as String?,
      urlImageProfile: data['image_profile'] as String?,
    );
  }
}
