import React from "react";
import { useNavigate } from "react-router-dom";

export default function Unauthorized() {
  const navigate = useNavigate();

  return (
    <div style={styles.container}>
      <div style={styles.card}>
        <div style={styles.icon}>🚫</div>
        <h1 style={styles.title}>Accès refusé</h1>
        <p style={styles.text}>
          Vous n’avez pas l’autorisation d’accéder à cette page.
        </p>

        <button style={styles.button} onClick={() => navigate("/account/login/")}>
          Retour à la page de connexion
        </button>
      </div>
    </div>
  );
}

const styles = {
  container: {
    minHeight: "100vh",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    background: "#f2f4f7",
    fontFamily: "Arial, sans-serif",
  },
  card: {
    background: "#fff",
    padding: "40px",
    borderRadius: "12px",
    boxShadow: "0 4px 15px rgba(0,0,0,0.1)",
    textAlign: "center",
    width: "90%",
    maxWidth: "400px",
  },
  icon: {
    fontSize: "60px",
    marginBottom: "15px",
  },
  title: {
    fontSize: "28px",
    marginBottom: "10px",
    color: "#d32f2f",
  },
  text: {
    fontSize: "16px",
    marginBottom: "25px",
    color: "#555",
  },
  button: {
    background: "#1976d2",
    color: "white",
    padding: "10px 20px",
    border: "none",
    borderRadius: "6px",
    cursor: "pointer",
    fontSize: "16px",
  },
};
