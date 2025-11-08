import React, { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import VehiculeRepository from "../../repository/VehiculeRepository";
import { Vehicule } from "../../models/Vehicule";
import "../../styles/theme.css";

export default function AddVehicules() {
  const location = useLocation();
  const navigate = useNavigate();
  const { user } = location.state || {};

  const vehiculeRepository = VehiculeRepository;
  const [formData, setFormData] = useState({
    marque: "",
    modele: "",
    immatriculation: "",
    capacite: "",
    tarif_km: "",
  });
  const [loading, setLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const validateForm = () => {
    if (!formData.marque || !formData.immatriculation || !formData.capacite || !formData.tarif_km) {
      setErrorMessage("Veuillez remplir tous les champs obligatoires (*)");
      return false;
    }
    if (isNaN(formData.capacite) || isNaN(formData.tarif_km)) {
      setErrorMessage("Capacité et Tarif doivent être numériques");
      return false;
    }
    setErrorMessage("");
    return true;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!validateForm()) return;
    setLoading(true);
    try {
      const data = Vehicule.fromJSON({
        marque: formData.marque,
        modele: formData.modele,
        immatriculation: formData.immatriculation,
        capacite: parseFloat(formData.capacite),
        tarif_km: parseFloat(formData.tarif_km),
      });

      await vehiculeRepository.postVehicule(data);
      navigate("/profile", { state: { user } });
    } catch (error) {
      console.error(error);
      setErrorMessage("Erreur lors de l’ajout du véhicule.");
    } finally { setLoading(false); }
  };

  return (
    <div className="app-container">
      <div style={{ marginBottom: 12 }}>
        <button className="btn btn-ghost" onClick={() => navigate(-1)}>← Retour</button>
      </div>

      <div className="card">
        <h3>Ajouter un véhicule</h3>
        {errorMessage && <div className="error">{errorMessage}</div>}

        <form onSubmit={handleSubmit} style={{ maxWidth: 520, marginTop: 16 }}>
          <label className="kv">Marque *</label>
          <input className="form-input" name="marque" placeholder="Ex: Renault"
            value={formData.marque} onChange={handleChange} />

          <label className="kv" style={{ marginTop: 10 }}>Modèle</label>
          <input className="form-input" name="modele" placeholder="Ex: Kangoo"
            value={formData.modele} onChange={handleChange} />

          <label className="kv" style={{ marginTop: 10 }}>Immatriculation *</label>
          <input className="form-input" name="immatriculation" placeholder="Ex: 1234-AB-56"
            value={formData.immatriculation} onChange={handleChange} />

          <label className="kv" style={{ marginTop: 10 }}>Capacité (kg) *</label>
          <input className="form-input" name="capacite" type="number" placeholder="Ex: 1000"
            value={formData.capacite} onChange={handleChange} />

          <label className="kv" style={{ marginTop: 10 }}>Tarif/km (DH) *</label>
          <input className="form-input" name="tarif_km" type="number" placeholder="Ex: 0.8"
            value={formData.tarif_km} onChange={handleChange} />

          <div style={{ marginTop: 16 }}>
            <button className="btn btn-primary" type="submit" disabled={loading}>
              {loading ? "Ajout..." : "Ajouter"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
