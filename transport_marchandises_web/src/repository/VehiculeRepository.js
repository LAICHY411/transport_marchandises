import ApiService from "../service/ApiService";
import ApiRoutes from "../routes/ApiRoutes.js";
import { Vehicule } from "../models/Vehicule";

class VehiculeRepository {
  constructor(apiService = ApiService) {
    this.apiService = apiService;
    this.pathVehicule = ApiRoutes.vehicule;
  }

  // 🔹 Ajouter un véhicule
  async postVehicule(vehicule) {
    console.log("Vehicule est ",vehicule)
    const dataResponse = await this.apiService.post(
      `${this.pathVehicule}`,
      vehicule.toJSON()
    );
    console.log("data Responce  est",dataResponse)
    return Vehicule.fromJSON(dataResponse);
  }

  // 🔹 Récupérer tous les véhicules
  async getVehiculesProfile() {
    const data = await this.apiService.get(`${this.pathVehicule}`);
    return data.map(Vehicule.fromJSON);
  }

  // 🔹 Récupérer un véhicule par ID
  async getVehicule(id) {
    const data = await this.apiService.get(`${this.pathVehicule}${id}/`);
    return Vehicule.fromJSON(data);
  }

  // 🔹 Modifier un véhicule
  async patchVehicule(id, data = {}) {
    const dataResponse = await this.apiService.patch(
      `${this.pathVehicule}${id}/`,
      data
    );
    return Vehicule.fromJSON(dataResponse);
  }

  // 🔹 Supprimer un véhicule
  async deleteVehicule(id) {
    const data = await this.apiService.delete(`${this.pathVehicule}${id}/`);
    return data;
  }
}

export default new VehiculeRepository();
