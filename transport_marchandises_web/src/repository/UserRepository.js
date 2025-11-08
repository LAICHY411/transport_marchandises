import ApiService from "../service/ApiService.js";
import ApiRoutes from "../routes/ApiRoutes.js";
import { Utilisateur } from "../models/Utilisateur.js";

export default class UserRepository {
  constructor(apiService = ApiService) {
    this.apiService = apiService;
    this.pathUser = ApiRoutes.user;
  }

  // 🔐 Connexion utilisateur
  async login(email, password) {
    try {
      const data = await this.apiService.post(ApiRoutes.login, {
        email,
        password,
      });
      if (data==null) return null;
      if (data?.access) {
        this.apiService.setAuthorizationToken(data.access);
        return {
          access: data.access,
          refresh: data.refresh,
        };
      }
      return null;
    } catch (error) {
      console.error("❌ Erreur de connexion :", error);
      throw error;
    }
  }

  // 🚪 Déconnexion
  logout() {
    this.apiService.setAuthorizationToken("");
    localStorage.removeItem("token");
  }

  // 👤 Récupérer le profil utilisateur
  async getUserProfile() {
    try {
      const data = await this.apiService.get(this.pathUser);
      if (!data) return null;

      // Si le backend renvoie un tableau
      if (Array.isArray(data) && data.length > 0) {
        return Utilisateur.fromJSON(data[0]);
      }

      // Si le backend renvoie un seul objet
      return Utilisateur.fromJSON(data);
    } catch (error) {
      console.error("❌ Erreur lors du chargement du profil :", error);
      return null;
    }
  }

  // ✏️ Modifier les données d’un utilisateur
  async patchUser(id, data = {}) {
    try {
      const dataResponse = await this.apiService.patch(
        `${this.pathUser}${id}/`,
        data
      );
      return Utilisateur.fromJSON(dataResponse);
    } catch (error) {
      console.error("❌ Erreur lors de la mise à jour utilisateur :", error);
      throw error;
    }
  }

  // ➕ Créer un utilisateur (inscription)
  async postUser(user) {
    try {
      const dataResponse = await this.apiService.post(
        this.pathUser,
        user.toJSON() 
      );
      return Utilisateur.fromJSON(dataResponse);
    } catch (error) {
      console.error("❌ Erreur lors de la création d’utilisateur :", error);
      throw error;
    }
  }

  // 🖼️ Mettre à jour l’image de profil
  async updateImage(id, imageFile) {
    if (!imageFile) return null;

    try {
      const formData = new FormData();
      formData.append("image_profile", imageFile);

      const dataResponse = await this.apiService.patchImage(
        `${this.pathUser}${id}/`,
        formData
      );
      return Utilisateur.fromJSON(dataResponse);
    } catch (error) {
      console.error("❌ Erreur lors du chargement de l’image :", error);
      throw error;
    }
  }
}
