import axios from "axios";
import { ApiConfig } from "../config/ApiConfig.js";

class ApiService {
  constructor() {
    this.api = axios.create({
      baseURL: ApiConfig.baseUrl,
      timeout: ApiConfig.connectTimeout,
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
    });

    /** 🚨 Intercepteur de réponse globale */
    this.api.interceptors.response.use(
      (response) => response,
      (error) => {
        // Si l'erreur contient une réponse HTTP
        if (error.response) {
          const status = error.response.status;

          // 🔹 Si le token n’est plus valide
          if (status === 401) {
            console.warn("🔒 401 détecté — redirection vers /unauthorized");

            // Supprime le token (sécurité)
            this.removeAuthorizationToken();

            // Redirection vers une page d'erreur / login
            if (window.location.pathname !== "/unauthorized") {
              window.location.href = "/unauthorized";
            }
          }

          // Retourne l'erreur pour gestion locale si besoin
          return Promise.reject(error.response);
        } else {
          console.error("❌ Erreur réseau :", error.message);
          return Promise.reject(error);
        }
      }
    );
  }

  /** 🔐 Définit le token d’authentification JWT */
  setAuthorizationToken(token) {
    if (token) {
      this.api.defaults.headers["Authorization"] = `Bearer ${token}`;
    } else {
      delete this.api.defaults.headers["Authorization"];
    }
  }

  /** 🔓 Supprimer le token */
  removeAuthorizationToken() {
    delete this.api.defaults.headers["Authorization"];
    localStorage.removeItem("token");
  }

  /** 🔹 GET */
  async get(path) {
    const res = await this.api.get(path);
    return res.data;
  }

  /** 🔹 POST */
  async post(path, data = {}) {
    if (data && data.image_profile instanceof File) {
      const formData = new FormData();
      for (const key in data) formData.append(key, data[key]);
      const res = await this.api.post(path, formData, {
        headers: { "Content-Type": "multipart/form-data" },
      });
      return res.data;
    }

    const res = await this.api.post(path, data);
    return res.data;
  }

  /** 🔹 PATCH */
  async patch(path, data = {}) {
    const res = await this.api.patch(path, data);
    return res.data;
  }

  /** 🔹 PATCH (image) */
  async patchImage(path, data = {}) {
    const formData = new FormData();
    for (const key in data) formData.append(key, data[key]);
    const res = await this.api.patch(path, formData, {
      headers: { "Content-Type": "multipart/form-data" },
    });
    return res.data;
  }

  /** 🔹 DELETE */
  async delete(path) {
    const res = await this.api.delete(path);
    return res.data;
  }
}

export default new ApiService();
