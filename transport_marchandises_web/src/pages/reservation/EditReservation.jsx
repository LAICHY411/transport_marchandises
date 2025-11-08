import React, { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import ReservationRepository from "../../repository/ReservationRepository";
import "../../styles/theme.css";

export default function EditReservation() {
  const location = useLocation();
  const navigate = useNavigate();
  const { user, vehicule, reservation } = location.state || {};
  const reservationRepository = ReservationRepository;

  const [formData, setFormData] = useState({
    date: reservation?.date_reservation || "",
    heurDebut: reservation?.heure_debut || "",
    heurFin: reservation?.heure_fin || ""
  });
  const [loading, setLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");

  const handleChange = (e) => { const { name, value } = e.target; setFormData(prev => ({ ...prev, [name]: value })); };

  const validateForm = () => {
    if (!formData.date || !formData.heurDebut || !formData.heurFin) {
      setErrorMessage("Veuillez remplir tous les champs obligatoires (*)"); return false;
    }
    setErrorMessage(""); return true;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!validateForm()) return;
    setLoading(true);
    try {
      const data = { date_reservation: formData.date, heure_debut: formData.heurDebut, heure_fin: formData.heurFin };
      const response = await reservationRepository.patchReservation(reservation.id, data);
      navigate("/vehicule/details", { state: { user, vehicule } });
    } catch (error) {
      console.error(error);
      setErrorMessage("Une erreur est survenue lors de la mise à jour.");
    } finally { setLoading(false); }
  };

  return (
    <div className="app-container">
      <div style={{ marginBottom: 12 }}>
        <button className="btn btn-ghost" onClick={() => navigate(-1)}>← Retour</button>
      </div>
      <div className="card">
        <h3>Modifier la réservation</h3>
        {errorMessage && <div className="error">{errorMessage}</div>}
        <form onSubmit={handleSubmit} style={{ maxWidth: 520, marginTop: 12 }}>
          <label className="kv">Date *</label>
          <input className="form-input" name="date" type="date" value={formData.date} onChange={handleChange} required />

          <label className="kv" style={{ marginTop: 10 }}>Heure de début *</label>
          <input className="form-input" name="heurDebut" type="time" value={formData.heurDebut} onChange={handleChange} required />

          <label className="kv" style={{ marginTop: 10 }}>Heure de fin *</label>
          <input className="form-input" name="heurFin" type="time" value={formData.heurFin} onChange={handleChange} required />

          <div style={{ marginTop: 14 }}>
            <button className="btn btn-primary" type="submit">{loading ? "Modification..." : "Enregistrer"}</button>
          </div>
        </form>
      </div>
    </div>
  );
}
