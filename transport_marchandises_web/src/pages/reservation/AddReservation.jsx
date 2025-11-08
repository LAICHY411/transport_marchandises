import React, { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import ReservationRepository from "../../repository/ReservationRepository";
import "../../styles/theme.css";

export default function AddReservation() {
  const location = useLocation();
  const navigate = useNavigate();
  const { user, vehicule } = location.state || {};
  const reservationRepository = ReservationRepository;

  const [formData, setFormData] = useState({ date: "", heurDebut: "", heurFin: "" });
  const [loading, setLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");

  const onChangeInput = (e) => { const { name, value } = e.target; setFormData(prev => ({ ...prev, [name]: value })); };

  const validateForm = () => {
    if (!formData.date || !formData.heurDebut || !formData.heurFin) {
      setErrorMessage("Veuillez remplir tous les champs obligatoires (*)");
      return false;
    }
    setErrorMessage("");
    return true;
  };

  const SubmitData = async (e) => {
    e.preventDefault();
    if (!validateForm()) return;
    setLoading(true);
    try {
      const data = { date_reservation: formData.date, heure_debut: formData.heurDebut, heure_fin: formData.heurFin };
      const response = await reservationRepository.postReservation(vehicule.id, data);
      navigate("/vehicule/details/", { state: { user, vehicule } });
    } catch (error) {
      console.error(error);
      setErrorMessage("Une erreur est survenue lors de l’ajout.");
    } finally { setLoading(false); }
  };

  return (
    <div className="app-container">
      <div style={{ marginBottom: 12 }}>
        <button className="btn btn-ghost" onClick={() => navigate(-1)}>← Retour</button>
      </div>
      <div className="card">
        <h3>Ajouter une réservation</h3>
        {errorMessage && <div className="error">{errorMessage}</div>}
        <form onSubmit={SubmitData} style={{ maxWidth: 520, marginTop: 12 }}>
          <label className="kv">Date *</label>
          <input className="form-input" type="date" name="date" value={formData.date} onChange={onChangeInput} required />

          <label className="kv" style={{ marginTop: 10 }}>Heure de début *</label>
          <input className="form-input" type="time" name="heurDebut" value={formData.heurDebut} onChange={onChangeInput} required />

          <label className="kv" style={{ marginTop: 10 }}>Heure de fin *</label>
          <input className="form-input" type="time" name="heurFin" value={formData.heurFin} onChange={onChangeInput} required />

          <div style={{ marginTop: 14 }}>
            <button className="btn btn-primary" type="submit">{loading ? "Création..." : "Ajouter la réservation"}</button>
          </div>
        </form>
      </div>
    </div>
  );
}
