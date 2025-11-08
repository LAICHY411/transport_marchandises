import '../Service/Service.dart';
import '../routes/routes.dart';

class ReservationRepository {
  final ApiService apiService;
  ReservationRepository(this.apiService);
  final String pathReservation = Routes.resirvation;
  final String paramsVecule = "?vehicule_id=";
  // add Resirvation
  Future<Map<String, dynamic>> postReservation(
    id,
    Map<String, dynamic> data,
  ) async {
    final dataResponse = await apiService.post(
      "${pathReservation}/${paramsVecule}${id}",
      data: data,
    );
    return dataResponse;
  }

  // get les reservation
  Future<List<dynamic>?> getReservationVehicule(id) async {
    final data = await apiService.get(
      "${pathReservation}/${paramsVecule}${id}",
    );
    // print(data.runtimeType);
    return data;
  }

  Future<Map<String, dynamic>> patchVehicule(
    int id, {
    Map<String, dynamic>? data,
  }) async {
    final dataResponse = await apiService.patch(
      "${pathReservation}/${id}/",
      data: data,
    );
    return dataResponse;
  }

  Future<dynamic> delete(int id) async {
    final data = await apiService.delete("${pathReservation}/${id}/");
    return data;
  }
}
