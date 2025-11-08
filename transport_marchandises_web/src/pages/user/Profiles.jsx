import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import UserRepository from "../../repository/UserRepository";
import VehiculeRepository from "../../repository/VehiculeRepository";
import ApiService from "../../service/ApiService";
import "../../styles/theme.css";

export default function Profile() {
  const location = useLocation();
  const navigate = useNavigate();
  const userData = location.state?.user || null;

  const apiService = ApiService;
  const userRepository = new UserRepository(apiService);
  const vehiculeRepository = VehiculeRepository;

  const [user, setUser] = useState(userData);
  const [image, setImage] = useState(null);
  const [errorMessage, setErrorMessage] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [vehicules, setVehicules] = useState([]);

  const lireVehicule = async () => {
    try {
      const data = await vehiculeRepository.getVehiculesProfile();
      if (data) setVehicules(data);
    } catch (e) {
      setErrorMessage("Erreur lors de l'affichage des véhicules : " + e);
    }
  };

  const updateImageProfile = async (selectedFile) => {
    if (!selectedFile || !user?.id) return;
    try {
      setIsLoading(true);
      const updatedUser = await userRepository.updateImage(user.id, selectedFile);
      if (updatedUser) setUser(updatedUser);
    } catch (e) {
      setErrorMessage("Erreur lors de la mise à jour de l'image");
    } finally { setIsLoading(false); }
  };

  const editVehicule = async (id) => {
    try {
      const data = await vehiculeRepository.getVehicule(id);
      if (!data) { setErrorMessage("Erreur lors du téléchargement du véhicule"); return; }
      navigate("/vehicule/edit", { state: { user, vehicule: data } });
    } catch (e) { setErrorMessage("Erreur d'édition du véhicule"); }
  };

  const detailsVehicule = async (id) => {
    try {
      const data = await vehiculeRepository.getVehicule(id);
      if (!data) { setErrorMessage("Erreur lors du téléchargement du véhicule"); return; }
      navigate("/vehicule/details", { state: { user, vehicule: data } });
    } catch (e) { setErrorMessage("Erreur lors du chargement des détails"); }
  };

  useEffect(() => { if (user) lireVehicule(); }, []);

  if (!user) {
    return (
      <div className="app-container">
        <div className="card">
          <p>Utilisateur non connecté</p>
          <button className="btn btn-ghost" onClick={() => navigate("/login")}>Retour</button>
        </div>
      </div>
    );
  }

  return (
    <div className="app-container">
      {errorMessage && <p className="error">{errorMessage}</p>}

      <div className="card profile-header">
        <div style={{display:"flex", alignItems:"center", gap:16}}>
          <div className="profile-avatar">
            {user.urlImageProfile ? <img src={user.urlImageProfile} alt="profil" style={{width:96,height:96,borderRadius:"50%"}}/> : "👤"}
          </div>
          <div>
            <h3 style={{margin:0}}>{user.nom}</h3>
            <p className="small" style={{margin:4}}>{user.email}</p>
            <p className="kv" style={{margin:0}}>{user.role}</p>
          </div>
        </div>

        <div className="profile-actions">
          <button className="btn btn-ghost" onClick={() => navigate("/edit_user", { state: { user } })}>Modifier</button>
          <button className="btn btn-primary" onClick={() => navigate("/vehicule/add", { state: { user } })}>Ajouter véhicule</button>
        </div>
      </div>

      {user.role !== "Client" && (
        <>
          <div style={{display:"flex", justifyContent:"space-between", alignItems:"center", marginTop:16}}>
            <h3>Mes Véhicules</h3>
          </div>

          {isLoading ? <p>Chargement...</p> : vehicules.length > 0 ? (
            <div className="grid">
              {vehicules.map(v => (
                <div key={v.id} className="card">
                  <p><strong>Marque :</strong> {v.marque}</p>
                  <p><strong>Capacité :</strong> {v.capacite} tonne</p>
                  <p className="kv"><strong>Tarif/km :</strong> {v.tarif_km} DH/km</p>
                  <div style={{ display:"flex", gap:8, marginTop:8 }}>
                    <button className="btn btn-ghost" onClick={() => editVehicule(v.id)}>Modifier</button>
                    <button className="btn btn-primary" onClick={() => detailsVehicule(v.id)}>Détails</button>
                  </div>
                </div>
              ))}
            </div>
          ) : <p>Aucun véhicule trouvé</p>}
        </>
      )}
    </div>
  );
}
