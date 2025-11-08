import { Button } from "@mui/material";
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import UserRepository from "../../../repository/UserRepository.js";
import Utilisateur from "../../../models/Utilisateur.js";

const userRepository = new UserRepository();

export default function Step4({user}) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async () => {
    setLoading(true);
    setError("");
    try {
      const utilisateur = new Utilisateur(user);
      const response = await userRepository.postUser(utilisateur);
      navigate("/login");
    } catch (err) {
      console.error(err);
      setError("Erreur lors de la création du compte.");
    } finally { setLoading(false); }
  };

  return (
    <div style={{ textAlign: "center" }}>
      <h3>Récapitulatif</h3>
      <pre style={{ textAlign: "left", background: "#fbfbff", padding: 12, borderRadius: 8, maxHeight: 240, overflowY: "auto" }}>
        {JSON.stringify(user, null, 2)}
      </pre>

      {error && <p className="error">{error}</p>}

      <div style={{ marginTop: 12 }}>
        <Button variant="contained" sx={{ backgroundColor: "var(--secondaryColor)" }} onClick={handleSubmit}>
          {loading ? "Envoi..." : "Terminer"}
        </Button>
      </div>
    </div>
  );
}
