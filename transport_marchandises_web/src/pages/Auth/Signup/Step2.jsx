import { TextField, Button, MenuItem } from "@mui/material";

export default function Step2({ user, setUser, onNext, onPrev }) {
  const handleChange = (e) => { setUser({ ...user, [e.target.name]: e.target.value }); };

  return (
    <div style={{ maxWidth: 460, margin: "auto" }}>
      <div className="form-group">
        <TextField name="telephone" label="Téléphone" fullWidth onChange={handleChange} />
      </div>
      <div className="form-group">
        <TextField name="adresse" label="Adresse" fullWidth onChange={handleChange} />
      </div>
      <div className="form-group">
        <TextField select name="role" label="Rôle" fullWidth onChange={handleChange}>
          <MenuItem value="Client">Client</MenuItem>
          <MenuItem value="Prestataire">Prestataire</MenuItem>
        </TextField>
      </div>
      <div style={{ display: "flex", gap: 10, marginTop: 15 }}>
        <Button variant="outlined" fullWidth onClick={onPrev}>Précédent</Button>
        <Button variant="contained" fullWidth sx={{ backgroundColor: "var(--secondaryColor)" }} onClick={onNext}>Suivant</Button>
      </div>
    </div>
  );
}
