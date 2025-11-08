import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import UserRepository from "../../repository/UserRepository.js";
import ApiService from "../../service/ApiService.js";
import "../../styles/theme.css";

const apiService = ApiService;
const userRepository = new UserRepository(apiService);

export default function Login() {
  const navigate = useNavigate();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const validateForm = () => {
    if (!email) return "Veuillez entrer votre email";
    if (!email.includes("@")) return "Adresse email invalide";
    if (!password) return "Veuillez entrer votre mot de passe";
    return "";
  };

  const LoginAuth = async (e) => {
    e.preventDefault();
    const validationError = validateForm();
    if (validationError) { setErrorMessage(validationError); return; }

    setIsLoading(true);
    setErrorMessage("");
    try {
      const tokenRefresh = await userRepository.login(email, password);
      if (!tokenRefresh?.access) {
        setErrorMessage("Email ou mot de passe incorrect");
        return;
      }
      localStorage.setItem("token", tokenRefresh.access);
      const user = await userRepository.getUserProfile();
      if (!user) { setErrorMessage("Erreur : utilisateur non trouvé"); return; }
      navigate("/profile", { state: { user } });
    } catch (error) {
      console.error("Erreur de connexion :", error);
      setErrorMessage("Impossible de se connecter au serveur.");
    } finally { setIsLoading(false); }
  };

  return (
    <div className="auth-page">
      <div className="auth-card card">
        <h2 className="h-title">Connexion</h2>
        <p className="h-sub">Bienvenue — connecte-toi pour continuer</p>

        {errorMessage && <div className="error">{errorMessage}</div>}

        <form onSubmit={LoginAuth}>
          <div className="form-group">
            <input
              className="input"
              type="email"
              placeholder="exemple@gmail.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>

          <div className="form-group">
            <div style={{ position: "relative" }}>
              <input
                className="input"
                type={showPassword ? "text" : "password"}
                placeholder="Mot de passe"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                style={{ paddingRight: 44 }}
              />
              <button
                type="button"
                onClick={() => setShowPassword(!showPassword)}
                style={{
                  position: "absolute",
                  right: 8,
                  top: 8,
                  background: "transparent",
                  border: "none",
                  cursor: "pointer",
                  fontSize: 14,
                  color: "var(--muted)"
                }}
                aria-label="toggle password visibility"
              >
                {showPassword ? "Masquer" : "Afficher"}
              </button>
            </div>
          </div>

          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
            <label className="small"><input type="checkbox" style={{ marginRight: 8 }}/> Se souvenir</label>
            <a className="link-like" onClick={() => alert("Fonction oubli mot de passe à implémenter")}>Mot de passe oublié?</a>
          </div>

          <div className="form-actions">
            <button className="btn btn-primary" type="submit" disabled={isLoading}>
              {isLoading ? "Connexion..." : "Se connecter"}
            </button>
            <button
              type="button"
              className="btn btn-ghost"
              onClick={() => navigate("/signup")}
            >
              S'inscrire
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
