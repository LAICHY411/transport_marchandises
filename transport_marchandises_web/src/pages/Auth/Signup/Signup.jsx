import { useState } from "react";
import Step1 from "./Step1";
import Step2 from "./Step2";
import Step3 from "./Step3";
import Step4 from "./Step4";
import "../../../styles/theme.css";

export default function Signup() {
  const [etape, setEtape] = useState(0);
  const [user, setUser] = useState({}); 

  const steps = [
    <Step1 user={user} setUser={setUser} onNext={() => setEtape(1)} />,
    <Step2 user={user} setUser={setUser} onNext={() => setEtape(2)} onPrev={() => setEtape(0)} />,
    <Step3 user={user} setUser={setUser} onNext={() => setEtape(3)} onPrev={() => setEtape(1)} />,
    <Step4 user={user} />,
  ];

  return (
    <div className="auth-page">
      <div className="auth-card card">
        <h2 className="h-title text-center">Inscription</h2>
        <p className="h-sub text-center">Crée ton compte en quelques étapes</p>
        <div>{steps[etape]}</div>
      </div>
    </div>
  );
}
