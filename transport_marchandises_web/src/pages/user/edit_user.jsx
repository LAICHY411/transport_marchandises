import React, { useState, useEffect } from "react";
import { Button, TextField, MenuItem, CircularProgress } from "@mui/material";
import { useNavigate, useLocation } from "react-router-dom";
import UserRepository from "../../repository/UserRepository";
import ApiService from "../../service/ApiService";
import "../../styles/theme.css";

const apiService = ApiService;
const userRepository = new UserRepository(apiService);

export default function ModifierUser() {
  const navigate = useNavigate();
  const location = useLocation();
  const { user } = location.state || {};

  const [formData, setFormData] = useState({
    nom: "", prenom: "", email: "", telephone: "", adresse: "", role: "Client", type_utilisateur: "Particulier"
  });
  const [loading, setLoading] = useState(false);
  const [editMode, setEditMode] = useState({});
  const [error, setError] = useState("");

  useEffect(() => {
    if (user) {
      setFormData({
        nom: user.nom || "",
        prenom: user.prenom || "",
        email: user.email || "",
        telephone: user.telephone || "",
        adresse: user.adresse || "",
        role: user.role || "Client",
        type_utilisateur: user.type_utilisateur || "Particulier"
      });
    }
  }, [user]);

  const handleChange = (field, value) => setFormData(prev => ({ ...prev, [field]: value }));
  const handleToggleEdit = (field) => setEditMode(prev => ({ ...prev, [field]: !prev[field] }));

  const handleSave = async () => {
    if (!user?.id) { setError("Utilisateur introuvable"); return; }
    setLoading(true); setError("");
    try {
      await userRepository.patchUser(user.id, formData);
      navigate("/profile", { state: { user: { ...user, ...formData } } });
    } catch (e) {
      console.error(e); setError("Erreur lors de la mise à jour des informations.");
    } finally { setLoading(false); }
  };

  return (
    <div className="app-container">
      <div className="card">
        <h3>Modifier mes informations</h3>
        {error && <p className="error">{error}</p>}
        {loading ? <div style={{textAlign:"center"}}><CircularProgress /></div> : (
          <>
            {["nom","prenom","email","telephone","adresse"].map((field) => (
              <div key={field} style={{ display:"flex", gap:12, marginBottom:14 }}>
                <TextField
                  label={field.charAt(0).toUpperCase() + field.slice(1)}
                  value={formData[field]}
                  onChange={(e) => handleChange(field, e.target.value)}
                  fullWidth
                  disabled={!editMode[field]}
                />
                <Button variant="outlined" onClick={() => handleToggleEdit(field)} sx={{ ml: 1 }}>
                  {editMode[field] ? "Sauver" : "Modifier"}
                </Button>
              </div>
            ))}

            <TextField select label="Rôle" fullWidth value={formData.role} onChange={(e) => handleChange("role", e.target.value)} sx={{ mb: 2 }}>
              <MenuItem value="Prestataire">Prestataire</MenuItem>
              <MenuItem value="Client">Client</MenuItem>
            </TextField>

            <TextField select label="Type d'utilisateur" fullWidth value={formData.type_utilisateur} onChange={(e) => handleChange("type_utilisateur", e.target.value)} sx={{ mb: 3 }}>
              <MenuItem value="Particulier">Particulier</MenuItem>
              <MenuItem value="Entreprise">Entreprise</MenuItem>
            </TextField>

            <Button variant="contained" sx={{ backgroundColor: "var(--secondaryColor)" }} fullWidth onClick={handleSave}>
              Enregistrer les informations
            </Button>
          </>
        )}
      </div>
    </div>
  );
}
