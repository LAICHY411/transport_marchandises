import { TextField, Button } from "@mui/material";

export default function Step1({ user, setUser, onNext }) {
  const handleChange = (e) => {
    setUser({ ...user, [e.target.name]: e.target.value });
  };

  return (
    <div style={{ maxWidth: 460, margin: "auto" }}>
      <div className="form-group">
        <TextField name="nom" label="Nom" fullWidth onChange={handleChange} />
      </div>
      <div className="form-group">
        <TextField name="prenom" label="Prénom" fullWidth onChange={handleChange} />
      </div>
      <div className="form-group">
        <TextField name="email" label="Email" type="email" fullWidth onChange={handleChange} />
      </div>
      <div className="form-group">
        <TextField name="password" label="Mot de passe" type="password" fullWidth onChange={handleChange} />
      </div>

      <div style={{ marginTop: 12 }}>
        <Button
          variant="contained"
          fullWidth
          sx={{ mt: 2, backgroundColor: "var(--secondaryColor)", borderRadius: "10px" }}
          onClick={onNext}
        >
          Suivant
        </Button>
      </div>
    </div>
  );
}
