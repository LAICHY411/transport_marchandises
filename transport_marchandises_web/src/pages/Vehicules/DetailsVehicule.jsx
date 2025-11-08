import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import VehiculeRepository from "../../repository/VehiculeRepository";
import ReservationRepository from "../../repository/ReservationRepository";
import "../../styles/theme.css";

export default function DetailsVehicule() {
  const location = useLocation();
  const navigate = useNavigate();
  const { user, vehicule } = location.state || {};

  const vehiculeRepository = VehiculeRepository;
  const reservationRepository = ReservationRepository;

  const [reservations, setReservations] = useState([]);
  const [loading, setLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");

  const loadReservations = async () => {
    try {
      setLoading(true);
      const res = await reservationRepository.getReservationVehicule(vehicule.id);
      setReservations(res || []);
    } catch (e) {
      console.error(e);
      setErrorMessage("Erreur lors du chargement des réservations.");
    } finally { setLoading(false); }
  };

  useEffect(() => { loadReservations(); }, []);

  const deleteReservation = async (id) => {
    if (!window.confirm("Supprimer cette réservation ?")) return;
    try {
      await reservationRepository.deleteReservation(id);
      await loadReservations();
    } catch { setErrorMessage("Erreur de suppression."); }
  };

  return (
    <div className="app-container">
      <div style={{ marginBottom: 12 }}>
        <button className="btn btn-ghost" onClick={() => navigate("/profile", { state: { user } })}>← Retour</button>
      </div>

      <div className="card">
        <h3>Détails du véhicule</h3>
        {errorMessage && <p className="error">{errorMessage}</p>}
        <div className="vehicule-details">
          <p><strong>Marque :</strong> {vehicule.marque}</p>
          <p><strong>Modèle :</strong> {vehicule.modele}</p>
          <p><strong>Immatriculation :</strong> {vehicule.immatriculation}</p>
          <p><strong>Capacité :</strong> {vehicule.capacite} kg</p>
          <p><strong>Tarif/km :</strong> {vehicule.tarif_km} DH</p>
        </div>

        <div style={{ display:"flex", gap:8, marginTop:16 }}>
          <button className="btn btn-primary" onClick={() => navigate("/vehicule/edit", { state: { user, vehicule } })}>
            ✏️ Modifier
          </button>
          <button className="btn btn-ghost" onClick={() => navigate("/vehicule/reservation/add", { state: { user, vehicule } })}>
            ➕ Réservation
          </button>
        </div>
      </div>

      <div className="card" style={{ marginTop: 20 }}>
        <h3>Réservations</h3>
        {loading ? <p>Chargement...</p> : reservations.length > 0 ? (
          <table className="reservation-table" style={{ width:"100%", borderCollapse:"collapse", marginTop:12 }}>
            <thead>
              <tr style={{ background:"var(--surface-variant)" }}>
                <th style={{ padding:8 }}>Date</th>
                <th>Heure Début</th>
                <th>Heure Fin</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {reservations.map((r) => (
                <tr key={r.id}>
                  <td style={{ padding:8 }}>{r.date_reservation}</td>
                  <td>{r.heure_debut}</td>
                  <td>{r.heure_fin}</td>
                  <td style={{ display:"flex", gap:8, justifyContent:"center" }}>
                    <button className="btn btn-ghost"
                      onClick={() => navigate("/vehicule/reservation/edit", { state: { user, vehicule, reservation: r } })}>
                      ✏️
                    </button>
                    <button className="btn btn-primary" onClick={() => deleteReservation(r.id)}>🗑️</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        ) : <p>Aucune réservation.</p>}
      </div>
    </div>
  );
}
