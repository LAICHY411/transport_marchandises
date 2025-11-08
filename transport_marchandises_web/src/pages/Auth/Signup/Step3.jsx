import { Button } from "@mui/material";
import { useRef, useState } from "react";

export default function Step3({ user, setUser, onNext, onPrev }) {
  const fileRef = useRef();
  const [preview, setPreview] = useState(user.image_profile ? URL.createObjectURL(user.image_profile) : null);

  const handleFile = (e) => {
    const file = e.target.files[0];
    setPreview(URL.createObjectURL(file));
    setUser({ ...user, image_profile: file });
  };

  return (
    <div style={{ textAlign: "center" }}>
      <input type="file" ref={fileRef} hidden accept="image/*" onChange={handleFile} />
      <div style={{ margin: 20 }}>
        {preview ? (
          <img src={preview} alt="preview" style={{ width: 160, height:160, borderRadius: "50%", objectFit: "cover" }} />
        ) : (
          <div style={{ width: 160, height:160, borderRadius: "50%", backgroundColor: "#f3f4f6", display: "flex", alignItems: "center", justifyContent: "center" }}>
            <span className="small">Aucune image</span>
          </div>
        )}
      </div>

      <div style={{ display: "flex", gap: 10, justifyContent: "center" }}>
        <Button variant="outlined" onClick={() => fileRef.current.click()}>Choisir une image</Button>
        <Button variant="contained" sx={{ backgroundColor: "var(--secondaryColor)" }} onClick={onNext}>Suivant</Button>
      </div>

      <div style={{ marginTop: 12 }}>
        <Button variant="text" onClick={onPrev}>Précédent</Button>
      </div>
    </div>
  );
}
