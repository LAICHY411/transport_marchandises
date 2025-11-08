import 'dart:ui';
import '../Service/Service.dart';
import '../models/utilisateur.dart' as User;
import '../models/vehicule.dart' as Vehicule;
import '../routes/routes.dart';

class VehiculeRepository {
  final ApiService apiService;
  VehiculeRepository(this.apiService);
  final String pathVehicule = Routes.vehicule;
  // add Vehicule
  Future<Vehicule.Vehicules?> postVehicule(Vehicule.Vehicules vehicule) async {
    final dataResponse = await apiService.post(
      "${pathVehicule}/",
      data: vehicule.toJSON(),
    );
    return Vehicule.Vehicules.jsonToVehicule(dataResponse);
  }

  Future<List<dynamic>?> getVehiculesProfile() async {
    final data = await apiService.get("${pathVehicule}/");
    // print(data.runtimeType);
    return data;
  }

  // get Vehicule par id
  Future<Vehicule.Vehicules?> getVehicule(int id) async {
    final data = await apiService.get("${pathVehicule}/${id}/");
    return Vehicule.Vehicules.jsonToVehicule(data);
  }

  Future<Vehicule.Vehicules?> patchVehicule(
    int id, {
    Map<String, dynamic>? data,
  }) async {
    print("id est ${id} et date est $data");
    final dataResponse = await apiService.patch(
      "${pathVehicule}/${id}/",
      data: data,
    );
    return Vehicule.Vehicules.jsonToVehicule(dataResponse);
  }

  Future<dynamic> delete(int id) async {
    final data = await apiService.delete("${pathVehicule}/${id}/");
    return data;
  }
}
