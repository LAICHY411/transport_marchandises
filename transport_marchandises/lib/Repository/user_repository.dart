import 'dart:ui';

import 'package:image_picker/image_picker.dart';
import '../routes/routes.dart';
import '../Service/Service.dart';
import '../models/utilisateur.dart' as User;

class UserRepository {
  ApiService apiService;
  UserRepository(this.apiService);

  final String pathUser = Routes.user;
  // Login

  Future<Map<String, String>?> login(String email, String password) async {
    try {
      final data = await apiService.post(
        Routes.login,
        data: {'email': email, 'password': password},
      );
      final String? access = data["access"];
      final String? refresh = data["refresh"];
      if (access != null && !access.isEmpty) {
        apiService.setAuthorizationToken(access);
        return {"access": access, "refresh": refresh!};
      }

      return null;
    } catch (e) {
      print("Erreur de connexion $e");
    }
  }

  // logout
  void logout() {
    apiService.setAuthorizationToken("");
  }

  // get User par email

  Future<User.Utilisateur?> getUserProfile() async {
    final data = await apiService.get(pathUser);
    return User.Utilisateur.jsonToUser(data[0]);
  }

  Future<User.Utilisateur?> patchUser(
    int id, {
    Map<String, dynamic>? data,
  }) async {
    print("id est ${id} et date est $data");
    final dataResponse = await apiService.patch(
      "${pathUser}/${id}/",
      data: data,
    );
    return User.Utilisateur.jsonToUser(dataResponse);
  }

  Future<User.Utilisateur?> postUser(User.Utilisateur user) async {
    final dataResponse = await apiService.post(
      "${pathUser}/",
      data: user.toJSON(),
    );
    return User.Utilisateur.jsonToUser(dataResponse);
  }

  Future<User.Utilisateur?> updateImage(int id, ImageByteFormat) async {
    if (ImageByteFormat == null) return null;
    Map<String, dynamic> dataImage = {"image_profile": ImageByteFormat};
    final dataResponse = await apiService.patchImage(
      "${pathUser}/${id}/",
      dataImage,
    );
    return User.Utilisateur.jsonToUser(dataResponse);
  }
}
