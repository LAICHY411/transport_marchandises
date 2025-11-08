import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import VehiculeRepository from "../../repository/VehiculeRepository";
import "../../styles/theme.css";

export default function EditVehicules() {
  const location = useLocation();
  const navigate = useNavigate();
  const { user, vehicule } = location.state || {};

  const vehiculeRepository = VehiculeRepository;
  const [vehiculeData, setVehicule] = useState({
    marque: "",
    modele: "",
    immatriculation: "",
    capacite: "",
    tarif_km: "",
  });
  const [loading, setLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");

  useEffect(() => {
    const fetchVehicule = async () => {
      try {
        setLoading(true);
        const data = await vehiculeRepository.getVehicule(vehicule.id);
        if (!data) return setErrorMessage("Erreur de chargement du véhicule.");
        setVehicule({
          marque: data.marque,
          modele: data.modele,
          immatriculation: data.immatriculation,
          capacite: data.capacite,
          tarif_km: data.tarif_km,
        });
      } catch (err) {
        console.error(err);
        setErrorMessage("Erreur serveur.");
      } finally { setLoading(false); }
    };
    fetchVehicule();
  }, [vehicule?.id]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setVehicule(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      await vehiculeRepository.patchVehicule(vehicule.id, vehiculeData);
      navigate("/profile", { state: { user } });
    } catch (err) {
      console.error(err);
      setErrorMessage("Erreur de mise à jour.");
    } finally { setLoading(false); }
  };

  return (
    <div className="app-container">
      <div style={{ marginBottom: 12 }}>
        <button className="btn btn-ghost" onClick={() => navigate(-1)}>← Retour</button>
      </div>

      <div className="card">
        <h3>Modifier le véhicule</h3>
        {errorMessage && <div className="error">{errorMessage}</div>}
        <form onSubmit={handleSubmit} style={{ maxWidth: 520 }}>
          {["marque","modele","immatriculation","capacite","tarif_km"].map((field) => (
            <div key={field}>
              <label className="kv" style={{ marginTop: 10 }}>
                {field.charAt(0).toUpperCase() + field.slice(1)}
              </label>
              <input
                className="form-input"
                name={field}
                type={field === "capacite" || field === "tarif_km" ? "number" : "text"}
                value={vehiculeData[field]}
                onChange={handleChange}
                required={["marque","immatriculation","capacite","tarif_km"].includes(field)}
              />
            </div>
          ))}

          <div style={{ marginTop: 16 }}>
            <button className="btn btn-primary" type="submit" disabled={loading}>
              {loading ? "Sauvegarde..." : "Enregistrer"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
