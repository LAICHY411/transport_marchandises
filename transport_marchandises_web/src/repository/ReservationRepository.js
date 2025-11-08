import ApiService from "../service/ApiService";
import ApiRoutes from "../routes/ApiRoutes.js";

class ReservationRepository {
  constructor(apiService = ApiService) {
    this.apiService = apiService;
    this.pathReservation = ApiRoutes.reservation;
    this.paramsVehicule = "?vehicule_id=";
  }

  // ➕ Ajouter une réservation
  async postReservation(id, data) {
    const dataResponse = await this.apiService.post(
      `${this.pathReservation}${this.paramsVehicule}${id}`,
      data
    );
    console.log
    return dataResponse;
  }

  // 📋 Récupérer les réservations d’un véhicule
  async getReservationVehicule(id) {
    const data = await this.apiService.get(
      `${this.pathReservation}${this.paramsVehicule}${id}`
    );
    return data;
  }

  // ✏️ Modifier une réservation
  async patchReservation(id, data = {}) {
    const dataResponse = await this.apiService.patch(
      `${this.pathReservation}${id}/`,
      data
    );
    return dataResponse;
  }

  // ❌ Supprimer une réservation
  async deleteReservation(id) {
    const data = await this.apiService.delete(`${this.pathReservation}${id}/`);
    return data;
  }
}
export default new ReservationRepository();


