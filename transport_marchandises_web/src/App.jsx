import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Login from "./pages/Auth/Login.jsx";
import Profile from "./pages/user/Profiles.jsx";
import Singup from './pages/Auth/Signup/Signup.jsx';
import Edit_user from './pages/user/edit_user.jsx';
import AddVehicules from "./pages/Vehicules/AddVehicules.jsx";
import DetailVehicules from './pages/Vehicules/DetailsVehicule.jsx';
import EditVehicules from "./pages/Vehicules/EditVehicules.jsx";
import Unauthorized from "./pages/Unauthorized.jsx";
import AddReseravtion from './pages/reservation/AddReservation.jsx';
import EditReservation from './pages/reservation/EditReservation.jsx'
export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/account/login/" element={<Login />} />
        <Route path="/profile" element={<Profile/>}></Route>
        <Route path="/signup" element={<Singup/>}></Route>
        <Route path="/edit_user" element={<Edit_user/>}></Route>
        <Route path="/vehicule/add" element={<AddVehicules/>}></Route>
        <Route path="/vehicule/details" element={<DetailVehicules/>}></Route>
        <Route path="/vehicule/edit" element={<EditVehicules/>}></Route>
        <Route path="/unauthorized" element={<Unauthorized/>}></Route>
        <Route path="/vehicule/reservation/add" element={<AddReseravtion/>}></Route>
        <Route path="/vehicule/reservation/edit" element={<EditReservation/>}></Route>



        

      </Routes>
    </Router>
  );
}
